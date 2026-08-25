import SwiftUI

/// Every colour, radius and type ramp in the app resolves through here, so the
/// whole look can be re-skinned by editing this one file.
enum Theme {

    // MARK: Surfaces

    /// Behind everything.
    static let void = Color(hex: 0x09_0A_0B)
    /// Cards, list rows, the body of a panel.
    static let panel = Color(hex: 0x12_13_15)
    /// A panel sitting on top of another panel.
    static let panelRaised = Color(hex: 0x1A_1C_1F)
    /// Inset wells: code blocks, diagram backgrounds, text fields.
    static let well = Color(hex: 0x0D_0E_10)

    static let hairline = Color(hex: 0x26_28_2C)
    static let hairlineBright = Color(hex: 0x3A_3D_43)

    // MARK: Ink

    static let ink = Color(hex: 0xEC_EE_F1)
    static let inkDim = Color(hex: 0x9A_A0_A8)
    static let inkFaint = Color(hex: 0x62_68_70)

    // MARK: Accents

    static let amber = Color(hex: 0xF3_D4_2E)     // Ableton yellow
    static let lime = Color(hex: 0xB0_E8_4C)      // playing / confirmed
    static let orange = Color(hex: 0xE8_60_2A)    // FL Studio orange
    static let magenta = Color(hex: 0xD8_46_8C)   // FL Studio pink
    static let cyan = Color(hex: 0x4F_C3_D9)      // routing / audio signal
    static let violet = Color(hex: 0x9A_7C_F0)    // MIDI signal
    static let red = Color(hex: 0xE0_45_45)       // record / destructive

    // MARK: Radii + strokes

    static let radiusCard: CGFloat = 14
    static let radiusChip: CGFloat = 7
    static let radiusCell: CGFloat = 4
    static let hairlineWidth: CGFloat = 1

    // MARK: Type

    /// Panel headers and diagram labels use a condensed mono, like hardware silkscreen.
    static func mono(_ size: CGFloat, _ weight: Font.Weight = .medium) -> Font {
        .system(size: size, weight: weight, design: .monospaced)
    }

    static func text(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }

    static let label = mono(11, .semibold)
    static let cellLabel = mono(9, .medium)
    static let title = text(22, .bold)
    static let sectionTitle = text(17, .semibold)
    static let body = text(15)
    static let caption = text(13)
}

extension Color {
    init(hex: UInt32) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: 1
        )
    }
}

// MARK: - Shared chrome

/// The bordered dark card used for every block of content in the app.
struct PanelBackground: ViewModifier {
    var fill: Color = Theme.panel
    var stroke: Color = Theme.hairline

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: Theme.radiusCard, style: .continuous)
                    .fill(fill)
            )
            .overlay(
                RoundedRectangle(cornerRadius: Theme.radiusCard, style: .continuous)
                    .stroke(stroke, lineWidth: Theme.hairlineWidth)
            )
    }
}

extension View {
    func panel(fill: Color = Theme.panel, stroke: Color = Theme.hairline) -> some View {
        modifier(PanelBackground(fill: fill, stroke: stroke))
    }
}

/// Small uppercase silkscreen header that sits above a group of content.
struct SectionHeader: View {
    let text: String
    var accent: Color = Theme.inkFaint

    var body: some View {
        HStack(spacing: 8) {
            Text(text.uppercased())
                .font(Theme.label)
                .tracking(1.4)
                .foregroundColor(accent)
            Rectangle()
                .fill(Theme.hairline)
                .frame(height: 1)
        }
    }
}

/// Rounded tag used for shortcuts, difficulty, and DAW attribution.
struct Chip: View {
    let text: String
    var color: Color = Theme.inkDim
    var filled: Bool = false

    var body: some View {
        Text(text)
            .font(Theme.mono(11, .semibold))
            .foregroundColor(filled ? Theme.void : color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: Theme.radiusChip, style: .continuous)
                    .fill(filled ? color : color.opacity(0.13))
            )
            .overlay(
                RoundedRectangle(cornerRadius: Theme.radiusChip, style: .continuous)
                    .stroke(filled ? .clear : color.opacity(0.30), lineWidth: 1)
            )
    }
}

/// Faint engineering grid drawn behind diagrams.
struct GridBackdrop: View {
    var spacing: CGFloat = 16

    var body: some View {
        Canvas { context, size in
            var path = Path()
            var x: CGFloat = 0
            while x <= size.width {
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
                x += spacing
            }
            var y: CGFloat = 0
            while y <= size.height {
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
                y += spacing
            }
            context.stroke(path, with: .color(Theme.hairline.opacity(0.5)), lineWidth: 0.5)
        }
        .allowsHitTesting(false)
    }
}
