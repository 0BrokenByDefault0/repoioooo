import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var state: AppState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    header
                    DAWSwitcher()
                    progressCard
                    startHere
                    everythingElse
                    stats
                }
                .padding(16)
            }
            .screenBackground()
            .navigationTitle("Deck")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(Theme.inkDim)
                    }
                }
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Learn the room before you play in it")
                .font(Theme.title)
                .foregroundColor(Theme.ink)
            Text("Annotated maps of every screen in Ableton Live and FL Studio, plus step-by-step how-tos for the things you'll actually need to do.")
                .font(Theme.caption)
                .foregroundColor(Theme.inkDim)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("YOUR PROGRESS · \(state.daw.name.uppercased())")
                    .font(Theme.label)
                    .tracking(1.2)
                    .foregroundColor(Theme.inkFaint)
                Spacer()
                Text("\(Int(state.progress * 100))%")
                    .font(Theme.mono(13, .bold))
                    .foregroundColor(state.daw.secondaryAccent)
            }
            MeterBar(value: state.progress, tint: state.daw.secondaryAccent)
            HStack(spacing: 14) {
                Text("\(state.visitedMapCount)/\(Library.maps(for: state.daw).count) screens seen")
                Text("\(state.completedWalkthroughCount)/\(Library.walkthroughs(for: state.daw).count) how-tos done")
            }
            .font(Theme.mono(10, .medium))
            .foregroundColor(Theme.inkDim)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .panel()
    }

    private var startHere: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionHeader(text: "Start here", accent: state.daw.accent)

            ForEach(startingWalkthroughs) { walkthrough in
                NavigationLink {
                    WalkthroughDetailView(walkthrough: walkthrough)
                } label: {
                    NavRow(
                        title: walkthrough.title,
                        subtitle: walkthrough.goal,
                        accent: state.daw.accent,
                        icon: "play.circle",
                        done: state.isCompleted(walkthrough.id)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    /// The first three core how-tos: setup, then making something, then recording.
    private var startingWalkthroughs: [Walkthrough] {
        Array(Library.walkthroughs(for: state.daw).filter { $0.difficulty == .core }.prefix(3))
    }

    private var everythingElse: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionHeader(text: "Jump to", accent: Theme.cyan)

            if let primary = Library.maps(for: state.daw).first {
                NavigationLink {
                    MapDetailView(map: primary)
                } label: {
                    NavRow(
                        title: primary.title,
                        subtitle: "The screen you'll be staring at most",
                        accent: state.daw.accent,
                        icon: "rectangle.split.3x3"
                    )
                }
                .buttonStyle(.plain)
            }

            NavigationLink { ShortcutsView() } label: {
                NavRow(
                    title: "Keyboard shortcuts",
                    subtitle: shortcutCountLabel,
                    accent: Theme.cyan,
                    icon: "keyboard"
                )
            }
            .buttonStyle(.plain)

            NavigationLink { GlossaryView() } label: {
                NavRow(
                    title: "Glossary",
                    subtitle: "\(Library.glossary.count) terms, no jargon-explaining-jargon",
                    accent: Theme.violet,
                    icon: "character.book.closed"
                )
            }
            .buttonStyle(.plain)

            if let translate = Library.topics.first(where: { $0.id == "translate" }) {
                NavigationLink { TopicDetailView(topic: translate) } label: {
                    NavRow(
                        title: translate.title,
                        subtitle: translate.blurb,
                        accent: Theme.lime,
                        icon: "arrow.left.arrow.right"
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var shortcutCountLabel: String {
        let count = Library.shortcutGroups(for: state.daw).reduce(0) { $0 + $1.items.count }
        return "\(count) for \(state.daw.name)"
    }

    private var stats: some View {
        HStack(spacing: 10) {
            statTile(value: "\(Library.maps.count)", label: "screens\nmapped")
            statTile(value: "\(Library.explainedControlCount)", label: "controls\nexplained")
            statTile(value: "\(Library.walkthroughs.count)", label: "how-to\nguides")
        }
    }

    private func statTile(value: String, label: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(Theme.mono(22, .bold))
                .foregroundColor(Theme.ink)
            Text(label)
                .font(Theme.mono(9, .medium))
                .foregroundColor(Theme.inkFaint)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .panel(fill: Theme.panelRaised)
    }
}

struct SettingsView: View {
    @EnvironmentObject private var state: AppState
    @State private var confirmingReset = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    SectionHeader(text: "Default DAW", accent: state.daw.accent)
                    DAWSwitcher()
                }

                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(text: "Display")

                    Toggle(isOn: $state.useWindowsKeys) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Windows key names")
                                .font(Theme.text(15, .semibold))
                                .foregroundColor(Theme.ink)
                            Text("Shows Ctrl instead of Cmd throughout")
                                .font(Theme.caption)
                                .foregroundColor(Theme.inkDim)
                        }
                    }
                    .tint(state.daw.accent)

                    Divider().overlay(Theme.hairline)

                    Toggle(isOn: $state.showDiagramLabels) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Labels on diagrams")
                                .font(Theme.text(15, .semibold))
                                .foregroundColor(Theme.ink)
                            Text("Turn off for a cleaner blank-map view to test yourself")
                                .font(Theme.caption)
                                .foregroundColor(Theme.inkDim)
                        }
                    }
                    .tint(state.daw.accent)
                }
                .padding(14)
                .panel()

                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(text: "Progress", accent: Theme.red)
                    Text("\(state.completed.count) items marked done, \(state.visitedMaps.count) screens visited.")
                        .font(Theme.caption)
                        .foregroundColor(Theme.inkDim)

                    Button(role: .destructive) {
                        confirmingReset = true
                    } label: {
                        Text("Reset all progress")
                            .font(Theme.text(15, .semibold))
                            .foregroundColor(Theme.red)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: Theme.radiusChip, style: .continuous)
                                    .fill(Theme.red.opacity(0.12))
                            )
                    }
                    .buttonStyle(.plain)
                }
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .panel()

                VStack(alignment: .leading, spacing: 8) {
                    SectionHeader(text: "About")
                    Text("A personal reference for learning Ableton Live and FL Studio. All diagrams are original schematic drawings, not screenshots — they show where things are and what they do, at a level of detail that survives version updates.")
                        .font(Theme.caption)
                        .foregroundColor(Theme.inkDim)
                        .fixedSize(horizontal: false, vertical: true)
                    Text("Shortcuts are written for Live 11/12 and FL Studio 21/2024. Ableton keys use Cmd (macOS); switch on Windows key names above for Ctrl.")
                        .font(Theme.caption)
                        .foregroundColor(Theme.inkFaint)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .panel()
            }
            .padding(16)
        }
        .screenBackground()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Reset progress?", isPresented: $confirmingReset) {
            Button("Cancel", role: .cancel) {}
            Button("Reset", role: .destructive) { state.resetProgress() }
        } message: {
            Text("This clears every completed how-to and visited screen. The content itself is unaffected.")
        }
    }
}
