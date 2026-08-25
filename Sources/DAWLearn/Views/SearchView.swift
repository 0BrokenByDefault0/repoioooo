import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var state: AppState
    @State private var query: String = ""
    @State private var searchBothDAWs: Bool = false

    private var results: [SearchHit] {
        Library.search(query, daw: searchBothDAWs ? nil : state.daw)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    Toggle(isOn: $searchBothDAWs) {
                        Text(searchBothDAWs ? "Searching both DAWs" : "Searching \(state.daw.name) only")
                            .font(Theme.text(14, .semibold))
                            .foregroundColor(Theme.ink)
                    }
                    .tint(state.daw.accent)
                    .padding(12)
                    .panel()

                    if query.count < 2 {
                        suggestions
                    } else if results.isEmpty {
                        VStack(spacing: 8) {
                            Image(systemName: "questionmark.folder")
                                .font(.system(size: 26))
                                .foregroundColor(Theme.inkFaint)
                            Text("Nothing matched “\(query)”.")
                                .font(Theme.body)
                                .foregroundColor(Theme.inkDim)
                            Text("Try a control name (“send”, “warp”, “sidechain”) or a task (“export”, “record”).")
                                .font(Theme.caption)
                                .foregroundColor(Theme.inkFaint)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 40)
                    } else {
                        HStack {
                            Text("\(results.count) result\(results.count == 1 ? "" : "s")")
                                .font(Theme.mono(11, .semibold))
                                .foregroundColor(Theme.inkFaint)
                            Spacer()
                        }
                        ForEach(results) { hit in
                            resultRow(hit)
                        }
                    }
                }
                .padding(16)
            }
            .screenBackground()
            .searchable(text: $query, prompt: "Search every button, task and term")
            .navigationTitle("Search")
        }
    }

    private var suggestions: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionHeader(text: "Try searching for")
            ForEach(["sidechain", "export", "quantise", "warp", "automation", "latency", "reverb send", "record audio", "shortcut"], id: \.self) { term in
                Button {
                    query = term
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 12))
                            .foregroundColor(Theme.inkFaint)
                        Text(term)
                            .font(Theme.body)
                            .foregroundColor(Theme.ink)
                        Spacer()
                    }
                    .padding(12)
                    .panel()
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
    }

    @ViewBuilder
    private func resultRow(_ hit: SearchHit) -> some View {
        switch hit {
        case .map(let map):
            NavigationLink { MapDetailView(map: map) } label: {
                hitRow(kind: hit.kindLabel, title: map.title, subtitle: map.subtitle, accent: map.daw.accent)
            }
            .buttonStyle(.plain)

        case .element(let map, let element):
            NavigationLink { MapDetailView(map: map, highlightedID: element.id) } label: {
                hitRow(
                    kind: hit.kindLabel,
                    title: element.detail?.title ?? element.label,
                    subtitle: "\(map.title) — \(element.detail?.summary ?? "")",
                    accent: element.role.color
                )
            }
            .buttonStyle(.plain)

        case .walkthrough(let walkthrough):
            NavigationLink { WalkthroughDetailView(walkthrough: walkthrough) } label: {
                hitRow(kind: hit.kindLabel, title: walkthrough.title, subtitle: walkthrough.goal, accent: Theme.lime)
            }
            .buttonStyle(.plain)

        case .topic(let topic):
            NavigationLink { TopicDetailView(topic: topic) } label: {
                hitRow(kind: hit.kindLabel, title: topic.title, subtitle: topic.blurb, accent: topic.daw?.accent ?? Theme.lime)
            }
            .buttonStyle(.plain)

        case .shortcut(let daw, let shortcut):
            HStack(spacing: 12) {
                KeyCap(keys: state.keys(shortcut.keys))
                VStack(alignment: .leading, spacing: 3) {
                    Text(shortcut.what)
                        .font(Theme.text(15, .semibold))
                        .foregroundColor(Theme.ink)
                        .multilineTextAlignment(.leading)
                    Text(daw.name)
                        .font(Theme.mono(10, .medium))
                        .foregroundColor(Theme.inkFaint)
                }
                Spacer(minLength: 0)
            }
            .padding(13)
            .frame(maxWidth: .infinity, alignment: .leading)
            .panel()

        case .glossary(let entry):
            VStack(alignment: .leading, spacing: 5) {
                Text(entry.term)
                    .font(Theme.text(15, .bold))
                    .foregroundColor(Theme.ink)
                Text(entry.definition)
                    .font(Theme.caption)
                    .foregroundColor(Theme.inkDim)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(13)
            .frame(maxWidth: .infinity, alignment: .leading)
            .panel()
        }
    }

    private func hitRow(kind: String, title: String, subtitle: String, accent: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Chip(text: kind.uppercased(), color: accent)
                Spacer(minLength: 0)
                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Theme.inkFaint)
            }
            Text(title)
                .font(Theme.text(15, .semibold))
                .foregroundColor(Theme.ink)
                .multilineTextAlignment(.leading)
            if !subtitle.isEmpty {
                Text(subtitle)
                    .font(Theme.caption)
                    .foregroundColor(Theme.inkDim)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(13)
        .frame(maxWidth: .infinity, alignment: .leading)
        .panel()
        .contentShape(Rectangle())
    }
}
