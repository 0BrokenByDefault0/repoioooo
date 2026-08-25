import SwiftUI

// MARK: - DAW

enum DAW: String, CaseIterable, Identifiable, Codable {
    case ableton
    case fl

    var id: String { rawValue }

    var name: String {
        switch self {
        case .ableton: return "Ableton Live"
        case .fl: return "FL Studio"
        }
    }

    var shortName: String {
        switch self {
        case .ableton: return "Live"
        case .fl: return "FL"
        }
    }

    var accent: Color {
        switch self {
        case .ableton: return Theme.amber
        case .fl: return Theme.orange
        }
    }

    var secondaryAccent: Color {
        switch self {
        case .ableton: return Theme.lime
        case .fl: return Theme.magenta
        }
    }

    /// The modifier key naming used in that DAW's own documentation.
    var primaryModifier: String {
        switch self {
        case .ableton: return "Cmd"   // Ctrl on Windows
        case .fl: return "Ctrl"
        }
    }
}

// MARK: - Interface maps (the annotated diagrams)

/// What a region of the interface *is*, which drives its colour on the diagram.
enum ElementRole: String, Codable {
    case surface        // inert background panel
    case control        // buttons, toggles, fields
    case transport      // play / stop / record
    case clip           // audio or MIDI content blocks
    case track          // track / channel headers
    case meter          // level meters, faders
    case browser        // file + preset lists
    case device         // plugins, effects, instruments
    case midi           // MIDI notes / routing
    case audio          // audio routing
    case danger         // record arm, delete
    case highlight      // the thing a walkthrough is pointing at

    var color: Color {
        switch self {
        case .surface: return Theme.panelRaised
        case .control: return Theme.hairlineBright
        case .transport: return Theme.lime
        case .clip: return Theme.amber
        case .track: return Theme.inkFaint
        case .meter: return Theme.cyan
        case .browser: return Theme.violet.opacity(0.55)
        case .device: return Theme.cyan.opacity(0.65)
        case .midi: return Theme.violet
        case .audio: return Theme.cyan
        case .danger: return Theme.red
        case .highlight: return Theme.magenta
        }
    }

    /// Diagram fill is a wash; the stroke carries the hue.
    var fill: Color { color.opacity(self == .surface ? 1 : 0.22) }
    var stroke: Color { self == .surface ? Theme.hairline : color.opacity(0.85) }
    var labelColor: Color { self == .surface ? Theme.inkDim : color }
}

/// One rectangle on an interface diagram. If `detail` is non-nil it is tappable.
struct MapElement: Identifiable {
    let id: String
    /// Normalised frame (0...1) inside the diagram's aspect box.
    let frame: CGRect
    let label: String
    var role: ElementRole = .surface
    /// Drawn but never tappable, e.g. grid lines and decorative clips.
    var decorative: Bool = false
    var detail: ElementDetail?

    init(
        _ id: String,
        _ frame: CGRect,
        _ label: String,
        role: ElementRole = .surface,
        decorative: Bool = false,
        detail: ElementDetail? = nil
    ) {
        self.id = id
        self.frame = frame
        self.label = label
        self.role = role
        self.decorative = decorative
        self.detail = detail
    }

    var isTappable: Bool { detail != nil && !decorative }
}

/// The explainer that opens when you tap a region of a diagram.
struct ElementDetail {
    let title: String
    /// One sentence: what this control is for.
    let summary: String
    /// What each part does / what the options mean.
    var bullets: [String] = []
    /// "Click here to…" style operations.
    var actions: [String] = []
    var shortcuts: [Shortcut] = []
    var gotcha: String?
}

struct InterfaceMap: Identifiable {
    let id: String
    let daw: DAW
    let title: String
    let subtitle: String
    /// width / height of the diagram box.
    let aspect: CGFloat
    let elements: [MapElement]
    /// Shown above the diagram: how you get to this screen.
    var howToOpen: String = ""

    var tappableCount: Int { elements.filter(\.isTappable).count }
}

// MARK: - Reference content

struct Shortcut: Identifiable, Hashable {
    let id = UUID()
    let keys: String
    let what: String
    var note: String?

    init(_ keys: String, _ what: String, note: String? = nil) {
        self.keys = keys
        self.what = what
        self.note = note
    }
}

enum Difficulty: String, CaseIterable {
    case core = "Core"
    case builds = "Builds on core"
    case deep = "Deep cut"

    var color: Color {
        switch self {
        case .core: return Theme.lime
        case .builds: return Theme.amber
        case .deep: return Theme.violet
        }
    }
}

/// A step-by-step "how do I actually do this" walkthrough.
struct Walkthrough: Identifiable {
    let id: String
    let daw: DAW
    let title: String
    let goal: String
    /// Interface map this task happens on, if there is one.
    /// Declared before `difficulty` so call sites can pass them in this order.
    var mapID: String?
    var difficulty: Difficulty = .core
    let steps: [Step]
    var tips: [String] = []
    var shortcuts: [Shortcut] = []

    struct Step: Identifiable {
        let id = UUID()
        let instruction: String
        var detail: String?
        /// Element on the linked map that this step points at.
        var highlights: String?

        init(_ instruction: String, _ detail: String? = nil, highlights: String? = nil) {
            self.instruction = instruction
            self.detail = detail
            self.highlights = highlights
        }
    }
}

/// A page of explanation: settings screens, concepts, signal flow.
struct Topic: Identifiable {
    let id: String
    let daw: DAW?          // nil = applies to both DAWs
    let title: String
    let blurb: String
    var difficulty: Difficulty = .core
    let sections: [Section]

    struct Section: Identifiable {
        let id = UUID()
        let heading: String
        var body: String = ""
        var bullets: [String] = []
        var shortcuts: [Shortcut] = []
        /// Renders an inline signal-flow strip.
        var flow: [String] = []
        var warning: String?
    }
}

struct GlossaryEntry: Identifiable {
    let id = UUID()
    let term: String
    let definition: String
    var alsoCalled: String?
    var daw: DAW?
}

// MARK: - Search

enum SearchHit: Identifiable {
    case map(InterfaceMap)
    case element(InterfaceMap, MapElement)
    case walkthrough(Walkthrough)
    case topic(Topic)
    case shortcut(DAW, Shortcut)
    case glossary(GlossaryEntry)

    var id: String {
        switch self {
        case .map(let m): return "map-\(m.id)"
        case .element(let m, let e): return "el-\(m.id)-\(e.id)"
        case .walkthrough(let w): return "wt-\(w.id)"
        case .topic(let t): return "tp-\(t.id)"
        case .shortcut(let d, let s): return "sc-\(d.rawValue)-\(s.id)"
        case .glossary(let g): return "gl-\(g.id)"
        }
    }

    var kindLabel: String {
        switch self {
        case .map: return "Screen"
        case .element: return "Control"
        case .walkthrough: return "How-to"
        case .topic: return "Guide"
        case .shortcut: return "Shortcut"
        case .glossary: return "Term"
        }
    }

    var daw: DAW? {
        switch self {
        case .map(let m): return m.daw
        case .element(let m, _): return m.daw
        case .walkthrough(let w): return w.daw
        case .topic(let t): return t.daw
        case .shortcut(let d, _): return d
        case .glossary(let g): return g.daw
        }
    }
}
