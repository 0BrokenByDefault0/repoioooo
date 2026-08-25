import Foundation

/// Single access point for all content, plus search.
enum Library {

    static let maps: [InterfaceMap] = AbletonMaps.all + FLMaps.all
    static let walkthroughs: [Walkthrough] = Walkthroughs.all
    static let topics: [Topic] = Topics.all
    static let shortcutGroups: [ShortcutGroup] = Reference.shortcutGroups
    static let glossary: [GlossaryEntry] = Reference.glossary

    static func maps(for daw: DAW) -> [InterfaceMap] {
        maps.filter { $0.daw == daw }
    }

    static func walkthroughs(for daw: DAW) -> [Walkthrough] {
        walkthroughs.filter { $0.daw == daw }
    }

    /// Topics for a DAW, with the DAW-agnostic ones appended.
    static func topics(for daw: DAW) -> [Topic] {
        topics.filter { $0.daw == daw } + topics.filter { $0.daw == nil }
    }

    static func shortcutGroups(for daw: DAW) -> [ShortcutGroup] {
        shortcutGroups.filter { $0.daw == daw }
    }

    static func map(id: String) -> InterfaceMap? {
        maps.first { $0.id == id }
    }

    /// Total number of individually-explained controls across every diagram.
    static var explainedControlCount: Int {
        maps.reduce(0) { $0 + $1.tappableCount }
    }

    // MARK: - Search

    static func search(_ rawQuery: String, daw: DAW?) -> [SearchHit] {
        let query = rawQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard query.count >= 2 else { return [] }
        let terms = query.split(separator: " ").map(String.init)

        func matches(_ haystack: [String]) -> Bool {
            let joined = haystack.joined(separator: " ").lowercased()
            return terms.allSatisfy { joined.contains($0) }
        }

        var hits: [SearchHit] = []

        for map in maps where daw == nil || map.daw == daw {
            if matches([map.title, map.subtitle, map.daw.name]) {
                hits.append(.map(map))
            }
            for element in map.elements where element.isTappable {
                guard let detail = element.detail else { continue }
                var hay: [String] = [element.label, detail.title, detail.summary]
                hay.append(contentsOf: detail.bullets)
                hay.append(contentsOf: detail.actions)
                hay.append(detail.gotcha ?? "")
                for shortcut in detail.shortcuts {
                    hay.append(shortcut.keys)
                    hay.append(shortcut.what)
                }
                if matches(hay) {
                    hits.append(.element(map, element))
                }
            }
        }

        for wt in walkthroughs where daw == nil || wt.daw == daw {
            var hay: [String] = [wt.title, wt.goal]
            for step in wt.steps {
                hay.append(step.instruction)
                hay.append(step.detail ?? "")
            }
            hay.append(contentsOf: wt.tips)
            if matches(hay) { hits.append(.walkthrough(wt)) }
        }

        for topic in topics where daw == nil || topic.daw == daw || topic.daw == nil {
            var hay: [String] = [topic.title, topic.blurb]
            for section in topic.sections {
                hay.append(section.heading)
                hay.append(section.body)
                hay.append(contentsOf: section.bullets)
            }
            if matches(hay) { hits.append(.topic(topic)) }
        }

        for group in shortcutGroups where daw == nil || group.daw == daw {
            for shortcut in group.items where matches([shortcut.keys, shortcut.what, shortcut.note ?? ""]) {
                hits.append(.shortcut(group.daw, shortcut))
            }
        }

        for entry in glossary where daw == nil || entry.daw == daw || entry.daw == nil {
            if matches([entry.term, entry.definition, entry.alsoCalled ?? ""]) {
                hits.append(.glossary(entry))
            }
        }

        return hits
    }
}
