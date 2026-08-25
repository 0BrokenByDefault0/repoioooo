import SwiftUI

struct MapListView: View {
    @EnvironmentObject private var state: AppState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    DAWSwitcher()
                        .padding(.bottom, 2)

                    Text("Every screen in \(state.daw.name), drawn and annotated. Tap any coloured region on a diagram to find out exactly what it does.")
                        .font(Theme.caption)
                        .foregroundColor(Theme.inkDim)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)

                    ForEach(Library.maps(for: state.daw)) { map in
                        NavigationLink {
                            MapDetailView(map: map)
                        } label: {
                            NavRow(
                                title: map.title,
                                subtitle: map.subtitle,
                                accent: state.daw.accent,
                                icon: "rectangle.split.3x3",
                                done: state.visitedMaps.contains(map.id)
                            ) {
                                Chip(text: "\(map.tappableCount)", color: state.daw.secondaryAccent)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(16)
            }
            .screenBackground()
            .navigationTitle("Screens")
        }
    }
}

struct MapDetailView: View {
    @EnvironmentObject private var state: AppState
    let map: InterfaceMap
    var highlightedID: String?

    @State private var selected: MapElement? = nil

    private var tappable: [MapElement] {
        map.elements.filter(\.isTappable)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(map.subtitle)
                    .font(Theme.body)
                    .foregroundColor(Theme.inkDim)
                    .fixedSize(horizontal: false, vertical: true)

                if !map.howToOpen.isEmpty {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "arrow.turn.down.right")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(map.daw.accent)
                            .padding(.top, 3)
                        Text(map.howToOpen)
                            .font(Theme.caption)
                            .foregroundColor(Theme.ink.opacity(0.9))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .panel(fill: Theme.panelRaised)
                }

                DiagramView(map: map, highlightedID: highlightedID) { element in
                    selected = element
                }

                HStack(spacing: 10) {
                    Label("Pinch to zoom · double-tap to fit", systemImage: "hand.draw")
                        .font(Theme.mono(10, .medium))
                        .foregroundColor(Theme.inkFaint)
                    Spacer()
                    Circle().fill(map.daw.accent).frame(width: 7, height: 7)
                    Text("= tappable")
                        .font(Theme.mono(10, .medium))
                        .foregroundColor(Theme.inkFaint)
                }

                VStack(alignment: .leading, spacing: 10) {
                    SectionHeader(text: "Controls on this screen", accent: map.daw.accent)
                    Text("Small screen? Read them here instead of zooming.")
                        .font(Theme.caption)
                        .foregroundColor(Theme.inkFaint)

                    ForEach(tappable) { element in
                        Button {
                            selected = element
                        } label: {
                            HStack(spacing: 10) {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(element.role.color)
                                    .frame(width: 4, height: 30)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(element.detail?.title ?? element.label)
                                        .font(Theme.text(15, .semibold))
                                        .foregroundColor(Theme.ink)
                                        .multilineTextAlignment(.leading)
                                    if let summary = element.detail?.summary {
                                        Text(summary)
                                            .font(Theme.caption)
                                            .foregroundColor(Theme.inkDim)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                Spacer(minLength: 4)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(Theme.inkFaint)
                            }
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .panel()
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                }

                let related = Library.walkthroughs(for: map.daw).filter { $0.mapID == map.id }
                if !related.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        SectionHeader(text: "How-tos that use this screen", accent: Theme.lime)
                        ForEach(related) { walkthrough in
                            NavigationLink {
                                WalkthroughDetailView(walkthrough: walkthrough)
                            } label: {
                                NavRow(
                                    title: walkthrough.title,
                                    subtitle: walkthrough.goal,
                                    accent: Theme.lime,
                                    icon: "list.number",
                                    done: state.isCompleted(walkthrough.id)
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(16)
        }
        .screenBackground()
        .navigationTitle(map.title)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selected) { element in
            ElementDetailSheet(element: element, daw: map.daw)
                .environmentObject(state)
        }
        .onAppear { state.markVisited(map.id) }
    }
}
