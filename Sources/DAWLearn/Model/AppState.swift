import SwiftUI
import Combine

/// Preferences and progress, persisted to UserDefaults.
///
/// Deliberately not using `@AppStorage`: inside an `ObservableObject` it does
/// not publish changes, so bound toggles would not refresh the UI.
final class AppState: ObservableObject {

    private enum Key {
        static let daw = "selectedDAW"
        static let completed = "completedIDs"
        static let visited = "visitedMapIDs"
        static let windowsKeys = "useWindowsKeys"
        static let labels = "showDiagramLabels"
    }

    private let defaults: UserDefaults

    @Published private(set) var daw: DAW {
        didSet { defaults.set(daw.rawValue, forKey: Key.daw) }
    }

    @Published private(set) var completed: Set<String> {
        didSet { defaults.set(Array(completed), forKey: Key.completed) }
    }

    @Published private(set) var visitedMaps: Set<String> {
        didSet { defaults.set(Array(visitedMaps), forKey: Key.visited) }
    }

    @Published var useWindowsKeys: Bool {
        didSet { defaults.set(useWindowsKeys, forKey: Key.windowsKeys) }
    }

    @Published var showDiagramLabels: Bool {
        didSet { defaults.set(showDiagramLabels, forKey: Key.labels) }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        daw = DAW(rawValue: defaults.string(forKey: Key.daw) ?? "") ?? .ableton
        completed = Set(defaults.stringArray(forKey: Key.completed) ?? [])
        visitedMaps = Set(defaults.stringArray(forKey: Key.visited) ?? [])
        useWindowsKeys = defaults.bool(forKey: Key.windowsKeys)
        showDiagramLabels = defaults.object(forKey: Key.labels) as? Bool ?? true
    }

    // MARK: DAW

    func select(_ daw: DAW) {
        self.daw = daw
    }

    // MARK: Progress

    func isCompleted(_ id: String) -> Bool { completed.contains(id) }

    func toggleCompleted(_ id: String) {
        if completed.contains(id) {
            completed.remove(id)
        } else {
            completed.insert(id)
        }
    }

    func markVisited(_ mapID: String) {
        guard !visitedMaps.contains(mapID) else { return }
        visitedMaps.insert(mapID)
    }

    func resetProgress() {
        completed = []
        visitedMaps = []
    }

    /// 0...1 across walkthroughs and screens for the selected DAW.
    var progress: Double {
        let walkthroughIDs = Library.walkthroughs(for: daw).map(\.id)
        let mapIDs = Library.maps(for: daw).map(\.id)
        let total = walkthroughIDs.count + mapIDs.count
        guard total > 0 else { return 0 }
        let done = walkthroughIDs.filter(completed.contains).count
            + mapIDs.filter(visitedMaps.contains).count
        return Double(done) / Double(total)
    }

    var completedWalkthroughCount: Int {
        Library.walkthroughs(for: daw).filter { completed.contains($0.id) }.count
    }

    var visitedMapCount: Int {
        Library.maps(for: daw).filter { visitedMaps.contains($0.id) }.count
    }

    // MARK: Key rendering

    /// Rewrites macOS key names for Windows users.
    /// Live's own documentation uses Cmd/Alt; on Windows that is Ctrl/Alt.
    func keys(_ raw: String) -> String {
        guard useWindowsKeys else { return raw }
        return raw
            .replacingOccurrences(of: "Cmd", with: "Ctrl")
            .replacingOccurrences(of: "Option", with: "Alt")
    }
}
