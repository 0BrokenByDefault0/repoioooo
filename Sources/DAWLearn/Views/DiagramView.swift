import SwiftUI

/// Renders an `InterfaceMap` as a pinch-zoomable, tappable diagram.
///
/// The diagram is laid out in a fixed "design space" (900pt wide) and then
/// scaled to fit, so labels keep their proportions at any screen size.
struct DiagramView: View {
    let map: InterfaceMap
    var highlightedID: String?
    var onSelect: (MapElement) -> Void

    private let designWidth: CGFloat = 900

    @State private var zoom: CGFloat = 1
    @GestureState private var pinch: CGFloat = 1
    @State private var pan: CGSize = .zero
    @GestureState private var dragPan: CGSize = .zero
    @EnvironmentObject private var state: AppState

    private var designHeight: CGFloat { designWidth / map.aspect }

    var body: some View {
        GeometryReader { geo in
            let fit = geo.size.width / designWidth
            let scale = fit * zoom * pinch

            ZStack {
                Theme.well
                diagram
                    .frame(width: designWidth, height: designHeight)
                    .scaleEffect(scale, anchor: .center)
                    .offset(x: pan.width + dragPan.width, y: pan.height + dragPan.height)
            }
            .frame(width: geo.size.width, height: designHeight * fit)
            .clipShape(RoundedRectangle(cornerRadius: Theme.radiusCard, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: Theme.radiusCard, style: .continuous)
                    .stroke(Theme.hairline, lineWidth: 1)
            )
            .gesture(
                SimultaneousGesture(
                    MagnificationGesture()
                        .updating($pinch) { value, pinchState, _ in pinchState = value }
                        .onEnded { value in
                            zoom = min(6, max(1, zoom * value))
                            if zoom == 1 { pan = .zero }
                        },
                    DragGesture()
                        .updating($dragPan) { value, dragState, _ in
                            guard zoom > 1 else { return }
                            dragState = value.translation
                        }
                        .onEnded { value in
                            guard zoom > 1 else { return }
                            pan.width += value.translation.width
                            pan.height += value.translation.height
                        }
                )
            )
            .onTapGesture(count: 2) {
                withAnimation(.easeOut(duration: 0.2)) {
                    zoom = zoom > 1 ? 1 : 2.4
                    pan = .zero
                }
            }
        }
        .aspectRatio(map.aspect, contentMode: .fit)
    }

    private var diagram: some View {
        ZStack(alignment: .topLeading) {
            GridBackdrop(spacing: 30)

            ForEach(map.elements) { element in
                elementView(element)
                    .frame(
                        width: element.frame.width * designWidth,
                        height: element.frame.height * designHeight,
                        alignment: .center
                    )
                    .offset(
                        x: element.frame.minX * designWidth,
                        y: element.frame.minY * designHeight
                    )
            }
        }
        .frame(width: designWidth, height: designHeight, alignment: .topLeading)
    }

    @ViewBuilder
    private func elementView(_ element: MapElement) -> some View {
        let isHighlighted = element.id == highlightedID
        let role = element.role

        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(isHighlighted ? Theme.magenta.opacity(0.30) : role.fill)

            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(
                    isHighlighted ? Theme.magenta : role.stroke,
                    lineWidth: isHighlighted ? 3.5 : (element.isTappable ? 2 : 1)
                )

            if state.showDiagramLabels && !element.label.isEmpty {
                Text(element.label)
                    .font(Theme.mono(13, .semibold))
                    .foregroundColor(isHighlighted ? Theme.ink : role.labelColor)
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)
                    .minimumScaleFactor(0.5)
                    .padding(6)
            }

            if element.isTappable {
                // Small "there's more here" marker in the corner.
                VStack {
                    HStack {
                        Spacer()
                        Circle()
                            .fill(role.color)
                            .frame(width: 8, height: 8)
                            .padding(5)
                    }
                    Spacer()
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            guard element.isTappable else { return }
            onSelect(element)
        }
        .allowsHitTesting(element.isTappable)
    }
}

/// The sheet that opens when a diagram region is tapped.
struct ElementDetailSheet: View {
    @EnvironmentObject private var state: AppState
    let element: MapElement
    let daw: DAW

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    if let detail = element.detail {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 8) {
                                Chip(text: element.role.rawValue.uppercased(), color: element.role.color)
                                Chip(text: daw.shortName, color: daw.accent)
                            }
                            Text(detail.summary)
                                .font(Theme.text(17))
                                .foregroundColor(Theme.ink)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        if !detail.bullets.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                SectionHeader(text: "What each part does", accent: element.role.color)
                                ForEach(Array(detail.bullets.enumerated()), id: \.offset) { _, line in
                                    BulletLine(text: line, color: element.role.color)
                                }
                            }
                        }

                        if !detail.actions.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                SectionHeader(text: "Try this", accent: Theme.lime)
                                ForEach(Array(detail.actions.enumerated()), id: \.offset) { _, line in
                                    BulletLine(text: line, color: Theme.lime)
                                }
                            }
                        }

                        if !detail.shortcuts.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                SectionHeader(text: "Shortcuts")
                                ForEach(detail.shortcuts) { ShortcutRow(shortcut: $0) }
                            }
                        }

                        if let gotcha = detail.gotcha {
                            GotchaBox(text: gotcha)
                        }
                    }
                }
                .padding(18)
            }
            .screenBackground()
            .navigationTitle(element.detail?.title ?? element.label)
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.medium, .large])
    }
}
