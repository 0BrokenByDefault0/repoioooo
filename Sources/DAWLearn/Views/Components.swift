import SwiftUI

/// A thin horizontal meter used for progress, styled like a DAW level meter.
struct MeterBar: View {
    let value: Double        // 0...1
    var tint: Color = Theme.lime
    var height: CGFloat = 6

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(Theme.well)
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [tint.opacity(0.7), tint],
                            startPoint: .leading, endPoint: .trailing
                        )
                    )
                    .frame(width: max(0, min(1, value)) * geo.size.width)
            }
        }
        .frame(height: height)
        .overlay(Capsule().stroke(Theme.hairline, lineWidth: 1))
    }
}

/// Standard tappable row used across every list in the app.
struct NavRow<Trailing: View>: View {
    let title: String
    var subtitle: String?
    var accent: Color = Theme.inkDim
    var icon: String?
    var done: Bool = false
    @ViewBuilder var trailing: () -> Trailing

    var body: some View {
        HStack(spacing: 12) {
            if let icon {
                ZStack {
                    RoundedRectangle(cornerRadius: Theme.radiusChip, style: .continuous)
                        .fill(accent.opacity(0.15))
                        .frame(width: 34, height: 34)
                    Image(systemName: icon)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(accent)
                }
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(Theme.text(16, .semibold))
                    .foregroundColor(Theme.ink)
                    .multilineTextAlignment(.leading)
                if let subtitle {
                    Text(subtitle)
                        .font(Theme.caption)
                        .foregroundColor(Theme.inkDim)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Spacer(minLength: 8)

            trailing()

            if done {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Theme.lime)
                    .font(.system(size: 15))
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Theme.inkFaint)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .panel()
        .contentShape(Rectangle())
    }
}

extension NavRow where Trailing == EmptyView {
    init(title: String, subtitle: String? = nil, accent: Color = Theme.inkDim, icon: String? = nil, done: Bool = false) {
        self.init(title: title, subtitle: subtitle, accent: accent, icon: icon, done: done, trailing: { EmptyView() })
    }
}

/// Key-combination badge.
struct KeyCap: View {
    let keys: String

    var body: some View {
        Text(keys)
            .font(Theme.mono(12, .semibold))
            .foregroundColor(Theme.ink)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(Theme.panelRaised)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .stroke(Theme.hairlineBright, lineWidth: 1)
            )
    }
}

struct ShortcutRow: View {
    @EnvironmentObject private var state: AppState
    let shortcut: Shortcut

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top, spacing: 10) {
                KeyCap(keys: state.keys(shortcut.keys))
                Text(shortcut.what)
                    .font(Theme.body)
                    .foregroundColor(Theme.ink)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer(minLength: 0)
            }
            if let note = shortcut.note {
                Text(note)
                    .font(Theme.caption)
                    .foregroundColor(Theme.inkDim)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 4)
    }
}

/// Bulleted line with a small square marker.
struct BulletLine: View {
    let text: String
    var color: Color = Theme.inkFaint

    var body: some View {
        HStack(alignment: .top, spacing: 9) {
            RoundedRectangle(cornerRadius: 1.5)
                .fill(color)
                .frame(width: 5, height: 5)
                .padding(.top, 7)
            Text(text)
                .font(Theme.body)
                .foregroundColor(Theme.ink.opacity(0.92))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

/// Amber "watch out" callout.
struct GotchaBox: View {
    let text: String
    var title: String = "Watch out"

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 12, weight: .bold))
                Text(title.uppercased())
                    .font(Theme.label)
                    .tracking(1.2)
            }
            .foregroundColor(Theme.amber)

            Text(text)
                .font(Theme.caption)
                .foregroundColor(Theme.ink.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: Theme.radiusChip, style: .continuous)
                .fill(Theme.amber.opacity(0.10))
        )
        .overlay(
            RoundedRectangle(cornerRadius: Theme.radiusChip, style: .continuous)
                .stroke(Theme.amber.opacity(0.35), lineWidth: 1)
        )
    }
}

/// Horizontal signal-flow strip: Source → Effect → Master.
struct FlowStrip: View {
    let stages: [String]
    var tint: Color = Theme.cyan

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(Array(stages.enumerated()), id: \.offset) { index, stage in
                    Text(stage)
                        .font(Theme.mono(11, .semibold))
                        .foregroundColor(tint)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 7)
                        .background(
                            RoundedRectangle(cornerRadius: Theme.radiusChip, style: .continuous)
                                .fill(tint.opacity(0.12))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: Theme.radiusChip, style: .continuous)
                                .stroke(tint.opacity(0.35), lineWidth: 1)
                        )
                    if index < stages.count - 1 {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(Theme.inkFaint)
                    }
                }
            }
            .padding(.vertical, 2)
        }
    }
}

/// The two-up DAW selector used on Home and in Settings.
struct DAWSwitcher: View {
    @EnvironmentObject private var state: AppState

    var body: some View {
        HStack(spacing: 10) {
            ForEach(DAW.allCases) { daw in
                Button {
                    withAnimation(.easeOut(duration: 0.18)) { state.select(daw) }
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(daw.name)
                            .font(Theme.text(15, .bold))
                            .foregroundColor(state.daw == daw ? Theme.void : Theme.ink)
                        Text("\(Library.maps(for: daw).count) screens · \(Library.walkthroughs(for: daw).count) how-tos")
                            .font(Theme.mono(10, .medium))
                            .foregroundColor(state.daw == daw ? Theme.void.opacity(0.7) : Theme.inkFaint)
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: Theme.radiusCard, style: .continuous)
                            .fill(state.daw == daw ? daw.accent : Theme.panel)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.radiusCard, style: .continuous)
                            .stroke(state.daw == daw ? .clear : Theme.hairline, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

/// Applies the app's dark ground to a scrolling screen.
struct ScreenBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Theme.void.ignoresSafeArea()
            content
        }
    }
}

extension View {
    func screenBackground() -> some View { modifier(ScreenBackground()) }
}
