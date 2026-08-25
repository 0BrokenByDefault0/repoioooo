import SwiftUI

struct LearnView: View {
    @EnvironmentObject private var state: AppState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    DAWSwitcher()

                    VStack(alignment: .leading, spacing: 10) {
                        SectionHeader(text: "Reference", accent: Theme.cyan)
                        NavigationLink {
                            ShortcutsView()
                        } label: {
                            NavRow(
                                title: "Keyboard shortcuts",
                                subtitle: "Everything worth memorising, grouped by what you're doing",
                                accent: Theme.cyan,
                                icon: "keyboard"
                            )
                        }
                        .buttonStyle(.plain)

                        NavigationLink {
                            GlossaryView()
                        } label: {
                            NavRow(
                                title: "Glossary",
                                subtitle: "\(Library.glossary.count) terms in plain language",
                                accent: Theme.violet,
                                icon: "character.book.closed"
                            )
                        }
                        .buttonStyle(.plain)

                        NavigationLink {
                            SettingsView()
                        } label: {
                            NavRow(
                                title: "Settings",
                                subtitle: "Key names, diagram labels, progress",
                                accent: Theme.inkDim,
                                icon: "slider.horizontal.3"
                            )
                        }
                        .buttonStyle(.plain)
                    }

                    let dawTopics = Library.topics.filter { $0.daw == state.daw }
                    if !dawTopics.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            SectionHeader(text: "\(state.daw.name) concepts", accent: state.daw.accent)
                            ForEach(dawTopics) { topic in
                                topicLink(topic, accent: state.daw.accent)
                            }
                        }
                        .padding(.top, 6)
                    }

                    let sharedTopics = Library.topics.filter { $0.daw == nil }
                    VStack(alignment: .leading, spacing: 10) {
                        SectionHeader(text: "Universal — true in any DAW", accent: Theme.lime)
                        ForEach(sharedTopics) { topic in
                            topicLink(topic, accent: Theme.lime)
                        }
                    }
                    .padding(.top, 6)
                }
                .padding(16)
            }
            .screenBackground()
            .navigationTitle("Learn")
        }
    }

    private func topicLink(_ topic: Topic, accent: Color) -> some View {
        NavigationLink {
            TopicDetailView(topic: topic)
        } label: {
            NavRow(
                title: topic.title,
                subtitle: topic.blurb,
                accent: accent,
                icon: "book.pages",
                done: state.isCompleted(topic.id)
            )
        }
        .buttonStyle(.plain)
    }
}

struct TopicDetailView: View {
    @EnvironmentObject private var state: AppState
    let topic: Topic

    private var accent: Color { topic.daw?.accent ?? Theme.lime }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 8) {
                    Chip(text: topic.daw?.shortName ?? "BOTH", color: accent, filled: true)
                    Chip(text: topic.difficulty.rawValue, color: topic.difficulty.color)
                }

                Text(topic.blurb)
                    .font(Theme.text(17))
                    .foregroundColor(Theme.ink)
                    .fixedSize(horizontal: false, vertical: true)

                ForEach(topic.sections) { section in
                    VStack(alignment: .leading, spacing: 10) {
                        SectionHeader(text: section.heading, accent: accent)

                        if !section.body.isEmpty {
                            Text(section.body)
                                .font(Theme.body)
                                .foregroundColor(Theme.ink.opacity(0.92))
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        if !section.flow.isEmpty {
                            FlowStrip(stages: section.flow, tint: accent)
                        }

                        ForEach(Array(section.bullets.enumerated()), id: \.offset) { _, line in
                            BulletLine(text: line, color: accent)
                        }

                        if !section.shortcuts.isEmpty {
                            ForEach(section.shortcuts) { ShortcutRow(shortcut: $0) }
                        }

                        if let warning = section.warning {
                            GotchaBox(text: warning)
                        }
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .panel()
                }

                Button {
                    state.toggleCompleted(topic.id)
                } label: {
                    HStack {
                        Image(systemName: state.isCompleted(topic.id) ? "checkmark.circle.fill" : "circle")
                        Text(state.isCompleted(topic.id) ? "Read" : "Mark as read")
                            .font(Theme.text(15, .semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(14)
                    .background(
                        RoundedRectangle(cornerRadius: Theme.radiusCard, style: .continuous)
                            .fill(state.isCompleted(topic.id) ? Theme.lime : Theme.panelRaised)
                    )
                    .foregroundColor(state.isCompleted(topic.id) ? Theme.void : Theme.ink)
                }
                .buttonStyle(.plain)
            }
            .padding(16)
        }
        .screenBackground()
        .navigationTitle(topic.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ShortcutsView: View {
    @EnvironmentObject private var state: AppState

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                DAWSwitcher()

                Toggle(isOn: $state.useWindowsKeys) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Windows key names")
                            .font(Theme.text(15, .semibold))
                            .foregroundColor(Theme.ink)
                        Text(state.useWindowsKeys ? "Showing Ctrl / Alt" : "Showing Cmd / Alt")
                            .font(Theme.caption)
                            .foregroundColor(Theme.inkDim)
                    }
                }
                .tint(state.daw.accent)
                .padding(14)
                .panel()

                ForEach(Library.shortcutGroups(for: state.daw)) { group in
                    VStack(alignment: .leading, spacing: 8) {
                        SectionHeader(text: group.title, accent: state.daw.accent)
                        ForEach(group.items) { ShortcutRow(shortcut: $0) }
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .panel()
                }
            }
            .padding(16)
        }
        .screenBackground()
        .navigationTitle("Shortcuts")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GlossaryView: View {
    @State private var query: String = ""

    private var entries: [GlossaryEntry] {
        let sorted = Library.glossary.sorted { $0.term.lowercased() < $1.term.lowercased() }
        guard !query.isEmpty else { return sorted }
        let needle = query.lowercased()
        return sorted.filter {
            $0.term.lowercased().contains(needle) || $0.definition.lowercased().contains(needle)
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(entries) { entry in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 8) {
                            Text(entry.term)
                                .font(Theme.text(16, .bold))
                                .foregroundColor(Theme.ink)
                            if let daw = entry.daw {
                                Chip(text: daw.shortName, color: daw.accent)
                            }
                            Spacer(minLength: 0)
                        }
                        Text(entry.definition)
                            .font(Theme.caption)
                            .foregroundColor(Theme.inkDim)
                            .fixedSize(horizontal: false, vertical: true)
                        if let also = entry.alsoCalled {
                            Text("also called: \(also)")
                                .font(Theme.mono(10, .medium))
                                .foregroundColor(Theme.inkFaint)
                        }
                    }
                    .padding(13)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .panel()
                }
            }
            .padding(16)
        }
        .screenBackground()
        .searchable(text: $query, prompt: "Find a term")
        .navigationTitle("Glossary")
        .navigationBarTitleDisplayMode(.inline)
    }
}
