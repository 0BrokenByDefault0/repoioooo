import SwiftUI

/// Annotated diagrams of every screen in FL Studio you need to operate.
enum FLMaps {

    static let all: [InterfaceMap] = [
        toolbar, channelRack, playlist, pianoRoll, mixer, browser, pluginWrapper, settings
    ]

    // MARK: - Toolbar / transport

    static let toolbar = InterfaceMap(
        id: "fl-toolbar",
        daw: .fl,
        title: "Toolbar & Transport",
        subtitle: "The top strip: menus, transport, tempo, snap and the hint bar",
        aspect: 3.0,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),

            MapElement("menus", CGRect(x: 0.01, y: 0.05, width: 0.35, height: 0.16), "FILE  EDIT  ADD  PATTERNS  VIEW  OPTIONS  TOOLS  HELP", role: .control, detail: ElementDetail(
                title: "Main menu bar",
                summary: "Eight menus. Most day-to-day work never touches them, but four entries matter.",
                bullets: [
                    "File → Export → WAV/MP3/MIDI is how you render a track.",
                    "Add → inserts a channel (instrument, audio clip, automation clip, layer).",
                    "Patterns → renames, clones, splits by channel, and 'Find first empty slot'.",
                    "Options → Audio/MIDI/General/File settings, plus the crucial 'Multilink to controllers'.",
                    "Tools → Macros holds one-click helpers like 'Switch smart disable for all plugins'."
                ]
            )),

            MapElement("hint", CGRect(x: 0.01, y: 0.24, width: 0.35, height: 0.14), "HINT BAR — describes whatever you hover", role: .highlight, detail: ElementDetail(
                title: "Hint bar",
                summary: "The single most useful thing in FL Studio: hover anything and this strip names it and tells you what it does.",
                bullets: [
                    "It also shows the current value while you drag a knob.",
                    "The small panel on its left shows the parameter's link status to a controller.",
                    "When you're lost, hover — don't guess."
                ]
            )),

            MapElement("transport", CGRect(x: 0.38, y: 0.10, width: 0.10, height: 0.30), "▶ ■ ●", role: .transport, detail: ElementDetail(
                title: "Play / Stop / Record",
                summary: "Standard transport. Space plays and stops.",
                bullets: [
                    "The Record button arms recording; what it records depends on the recording filter (right-click it) — Notes, Automation, Audio.",
                    "Right-click Play to switch between 'Play' and 'Play from start'.",
                    "The countdown/metronome icons sit next to it: metronome, count-in before recording, and blend/overdub recorded notes."
                ],
                shortcuts: [
                    Shortcut("Space", "Play / Pause"),
                    Shortcut("Ctrl+Space", "Play from start"),
                    Shortcut("R", "Toggle record"),
                    Shortcut("Ctrl+M", "Metronome"),
                    Shortcut("Ctrl+P", "Count-in before recording")
                ]
            )),

            MapElement("patsong", CGRect(x: 0.49, y: 0.10, width: 0.09, height: 0.30), "PAT | SONG", role: .highlight, detail: ElementDetail(
                title: "Pattern / Song mode switch",
                summary: "The switch that confuses every newcomer: PAT plays the currently selected pattern on loop; SONG plays the Playlist.",
                bullets: [
                    "Write drums and melodies in PAT mode, then arrange them in SONG mode.",
                    "If you hit play and hear nothing, you are almost certainly in the wrong mode — or the selected pattern is empty.",
                    "L toggles between them."
                ],
                shortcuts: [Shortcut("L", "Toggle Pattern / Song mode")],
                gotcha: "Playlist looks full but plays silence? You're in PAT mode."
            )),

            MapElement("tempo", CGRect(x: 0.59, y: 0.10, width: 0.08, height: 0.30), "130.000", role: .clip, detail: ElementDetail(
                title: "Tempo",
                summary: "Project BPM. Right-click for typed entry, tap tempo and 'Set as default'.",
                bullets: [
                    "Drag up/down to change; hold Ctrl while dragging for fine steps.",
                    "Automate it by right-clicking → Create automation clip.",
                    "The two small buttons beside it halve and double the playback speed for auditioning."
                ]
            )),

            MapElement("timepanel", CGRect(x: 0.68, y: 0.10, width: 0.10, height: 0.30), "TIME PANEL\nBAR : STEP : TICK", role: .control, detail: ElementDetail(
                title: "Time panel",
                summary: "Playback position. Right-click to switch between bars/steps and real time.",
                bullets: ["Also shows the total song length in time mode — handy before an export."]
            )),

            MapElement("cpu", CGRect(x: 0.79, y: 0.10, width: 0.09, height: 0.30), "CPU / MEM", role: .meter, detail: ElementDetail(
                title: "CPU and memory panel",
                summary: "Processing load and RAM use.",
                bullets: [
                    "If CPU is pinned: raise the buffer in Options → Audio settings, or enable Smart Disable (Tools → Macros).",
                    "The small bar underneath shows disk streaming load for audio clips."
                ]
            )),

            MapElement("snap", CGRect(x: 0.89, y: 0.10, width: 0.09, height: 0.30), "SNAP: LINE ▾", role: .highlight, detail: ElementDetail(
                title: "Global snap",
                summary: "The magnet control that decides what everything snaps to when you drag it.",
                bullets: [
                    "'Line' snaps to the visible grid — the default, and usually correct.",
                    "'(none)' lets you place things freely, for off-grid feel.",
                    "Cell, Step, Beat, Bar and the fractional values (1/2, 1/3, 1/4, 1/6, 1/8 step) give exact divisions.",
                    "Piano Roll and Playlist each have their own snap that overrides this one when set."
                ],
                shortcuts: [Shortcut("Alt (held)", "Temporarily bypass snapping")]
            )),

            MapElement("shortcutbar", CGRect(x: 0.38, y: 0.45, width: 0.60, height: 0.22), "TOGGLE PANELS:  Playlist · Piano Roll · Channel Rack · Mixer · Browser · Plugin Picker", role: .control, detail: ElementDetail(
                title: "Panel shortcut buttons",
                summary: "One click each for the five windows you'll spend all your time in.",
                bullets: [
                    "Playlist (F5), Piano Roll (F7), Channel Rack (F6), Mixer (F9), Browser (F8), Plugin Picker (F8 in newer versions / the + icon).",
                    "These are toggles: pressing the same key hides the window again.",
                    "Windows in FL float — arrange them how you like, and Ctrl+Shift+H cycles tidy layouts."
                ],
                shortcuts: [
                    Shortcut("F5", "Playlist"),
                    Shortcut("F6", "Channel Rack"),
                    Shortcut("F7", "Piano Roll"),
                    Shortcut("F8", "Browser / Plugin Picker"),
                    Shortcut("F9", "Mixer"),
                    Shortcut("Ctrl+Shift+H", "Arrange windows")
                ]
            )),

            MapElement("patternsel", CGRect(x: 0.01, y: 0.45, width: 0.35, height: 0.22), "PATTERN SELECTOR  ◀ 1 · Kick ▶", role: .clip, detail: ElementDetail(
                title: "Pattern selector",
                summary: "Which pattern is currently being edited and (in PAT mode) played.",
                bullets: [
                    "Patterns are containers of notes and automation across all channels — not per-instrument.",
                    "A common workflow is one pattern per part (Kick, Hats, Bass, Chords) so the Playlist stays readable.",
                    "Right-click to rename and colour; + creates a new one.",
                    "F4 jumps to the next empty pattern."
                ],
                shortcuts: [
                    Shortcut("F4", "Next empty pattern"),
                    Shortcut("+ / −", "Next / previous pattern")
                ]
            )),

            MapElement("master", CGRect(x: 0.01, y: 0.72, width: 0.20, height: 0.24), "MASTER VOL / PITCH", role: .meter, detail: ElementDetail(
                title: "Master volume and pitch",
                summary: "Global output level and a master pitch shift.",
                bullets: [
                    "This knob is *not* the Master mixer fader — it's a final output trim, and it is not written into automation by default.",
                    "Leave master pitch at zero unless you deliberately want everything detuned."
                ]
            )),

            MapElement("meters", CGRect(x: 0.22, y: 0.72, width: 0.30, height: 0.24), "OUTPUT METER + OSCILLOSCOPE", role: .meter, decorative: true),
            MapElement("onlinepanel", CGRect(x: 0.54, y: 0.72, width: 0.44, height: 0.24), "PROJECT PANEL — pickup/typing mode · multilink · step edit", role: .control, detail: ElementDetail(
                title: "Recording / editing toggles",
                summary: "Small but important switches that change how your keyboard and controller behave.",
                bullets: [
                    "Typing keyboard to piano (Ctrl+T) turns your QWERTY keys into a piano — and stops normal shortcuts from working.",
                    "Multilink to controllers records several knob movements at once.",
                    "Step edit mode enters notes one step at a time from a controller.",
                    "Snap-to-grid magnet, and the 'wrap' toggle for the Piano Roll."
                ],
                shortcuts: [Shortcut("Ctrl+T", "Typing keyboard to piano")],
                gotcha: "Shortcuts suddenly typing notes instead of working? Ctrl+T is on."
            ))
        ],
        howToOpen: "Always visible along the top of the FL Studio window."
    )

    // MARK: - Channel Rack

    static let channelRack = InterfaceMap(
        id: "fl-channelrack",
        daw: .fl,
        title: "Channel Rack",
        subtitle: "The step sequencer and the list of every instrument in the project",
        aspect: 1.45,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),

            MapElement("header", CGRect(x: 0.02, y: 0.03, width: 0.96, height: 0.09), "SWING  ·  PATTERN 1  ·  GRAPH EDITOR  ·  KEYBOARD EDITOR", role: .control, detail: ElementDetail(
                title: "Channel Rack toolbar",
                summary: "Swing amount, the pattern being edited, and the two editors that overlay the step grid.",
                bullets: [
                    "Swing shifts every off-beat step late — a global groove control for step-sequenced parts.",
                    "Graph Editor turns the step grid into per-step velocity, pan, pitch, cutoff and resonance bars.",
                    "Keyboard Editor shows a compact piano roll strip inside the rack for quick melodies."
                ]
            )),

            MapElement("chan1", CGRect(x: 0.02, y: 0.15, width: 0.32, height: 0.09), "● Kick", role: .track, detail: ElementDetail(
                title: "Channel button (name)",
                summary: "One row per instrument or sample. Clicking the name opens that channel's plugin/sampler window.",
                bullets: [
                    "The LED on the far left mutes/unmutes; right-click it to solo.",
                    "Right-click the name for: Rename/colour, Clone, Delete, Piano roll, Cut itself (choke groups), Fill each 2/4 steps, and 'Insert' / 'Replace'.",
                    "Drag the name onto a Mixer insert number to route it there.",
                    "Alt+drag reorders channels."
                ],
                actions: [
                    "Right-click → 'Piano roll' turns a step-sequenced channel into a full melodic one."
                ],
                shortcuts: [
                    Shortcut("Ctrl+C / Ctrl+V", "Copy / paste steps"),
                    Shortcut("Alt+G", "Group selected channels into a filter group")
                ]
            )),
            MapElement("knobs1", CGRect(x: 0.35, y: 0.15, width: 0.10, height: 0.09), "PAN VOL", role: .meter, detail: ElementDetail(
                title: "Channel pan and volume knobs",
                summary: "Per-channel trim before the mixer.",
                bullets: [
                    "Right-click a knob → 'Create automation clip' to automate it, or 'Link to controller' to bind hardware.",
                    "Alt+click resets a knob to default.",
                    "These are pre-mixer: they set how hot the channel hits its insert."
                ]
            )),
            MapElement("fx1", CGRect(x: 0.46, y: 0.15, width: 0.06, height: 0.09), "FX 1", role: .audio, detail: ElementDetail(
                title: "Mixer insert (FX) number",
                summary: "Which mixer insert this channel is routed to. 0 = straight to Master.",
                bullets: [
                    "Set it by dragging the number, or by dragging the channel onto an insert in the Mixer.",
                    "Give every sound its own insert so you can process them separately.",
                    "Ctrl+L with channels selected auto-assigns them to consecutive free inserts."
                ],
                shortcuts: [Shortcut("Ctrl+L", "Auto-route selected channels to free mixer inserts")]
            )),
            MapElement("steps1", CGRect(x: 0.53, y: 0.15, width: 0.45, height: 0.09), "■□□□ ■□□□ ■□□□ ■□□□", role: .clip, detail: ElementDetail(
                title: "Step sequencer grid",
                summary: "16 steps per bar by default. Click a step to place a hit; right-click to erase.",
                bullets: [
                    "Each block of four is one beat — the colour bands make counting easy.",
                    "Shift+drag across steps paints them; right-click-drag erases a run.",
                    "The Graph Editor button turns these into velocity/pitch bars for the same steps.",
                    "The step count is set by the pattern length control (right-click the grid area) — 16, 32, 64 steps."
                ],
                gotcha: "Steps and Piano Roll notes for the same channel are the same data — opening the Piano Roll on a stepped channel shows those hits as notes."
            )),

            MapElement("chan2", CGRect(x: 0.02, y: 0.26, width: 0.32, height: 0.09), "● Clap", role: .track, decorative: true),
            MapElement("knobs2", CGRect(x: 0.35, y: 0.26, width: 0.10, height: 0.09), "", role: .meter, decorative: true),
            MapElement("fx2", CGRect(x: 0.46, y: 0.26, width: 0.06, height: 0.09), "FX 2", role: .audio, decorative: true),
            MapElement("steps2", CGRect(x: 0.53, y: 0.26, width: 0.45, height: 0.09), "□□□□ ■□□□ □□□□ ■□□□", role: .clip, decorative: true),

            MapElement("chan3", CGRect(x: 0.02, y: 0.37, width: 0.32, height: 0.09), "● Hats", role: .track, decorative: true),
            MapElement("knobs3", CGRect(x: 0.35, y: 0.37, width: 0.10, height: 0.09), "", role: .meter, decorative: true),
            MapElement("fx3", CGRect(x: 0.46, y: 0.37, width: 0.06, height: 0.09), "FX 3", role: .audio, decorative: true),
            MapElement("steps3", CGRect(x: 0.53, y: 0.37, width: 0.45, height: 0.09), "■□■□ ■□■□ ■□■□ ■□■■", role: .clip, decorative: true),

            MapElement("chan4", CGRect(x: 0.02, y: 0.48, width: 0.32, height: 0.09), "● Bass (piano roll)", role: .midi, detail: ElementDetail(
                title: "A melodic channel",
                summary: "Any channel can hold piano-roll notes instead of steps — the rack row then shows a small note preview.",
                bullets: [
                    "Right-click the channel name → Piano roll (or F7 with it selected) to edit notes.",
                    "Channels holding piano roll data still respond to the pan/volume knobs and the FX routing."
                ]
            )),
            MapElement("knobs4", CGRect(x: 0.35, y: 0.48, width: 0.10, height: 0.09), "", role: .meter, decorative: true),
            MapElement("fx4", CGRect(x: 0.46, y: 0.48, width: 0.06, height: 0.09), "FX 4", role: .audio, decorative: true),
            MapElement("steps4", CGRect(x: 0.53, y: 0.48, width: 0.45, height: 0.09), "▬▬▬  ▬▬  ▬▬▬▬", role: .midi, decorative: true),

            MapElement("graph", CGRect(x: 0.53, y: 0.60, width: 0.45, height: 0.16), "GRAPH EDITOR — velocity per step", role: .highlight, detail: ElementDetail(
                title: "Graph Editor",
                summary: "Per-step control of velocity, pan, pitch (fine), cutoff, resonance and shift.",
                bullets: [
                    "Pick the parameter from the small selector on the left of the editor.",
                    "Drag bars to shape a groove — dropping the velocity of the off-beat hats is the classic move.",
                    "Right-click a bar to reset it."
                ]
            )),

            MapElement("plus", CGRect(x: 0.02, y: 0.80, width: 0.30, height: 0.09), "+  ADD CHANNEL", role: .control, detail: ElementDetail(
                title: "Add channel (+)",
                summary: "Inserts a new instrument, sample player, layer or automation clip.",
                bullets: [
                    "The Plugin Picker (also on the + icon) is the searchable grid of every plugin you own.",
                    "Drag a sample from the Browser straight into the rack to make a sampler channel.",
                    "'Layer' channel plays several channels from one — for stacked sounds."
                ]
            )),
            MapElement("filtergroups", CGRect(x: 0.34, y: 0.80, width: 0.30, height: 0.09), "FILTER GROUPS  ▾", role: .browser, detail: ElementDetail(
                title: "Channel filter groups",
                summary: "The dropdown at the top of the rack that shows only some channels — like folders for a big project.",
                bullets: [
                    "Select channels → Alt+G to make a group.",
                    "'All' shows everything; 'Unsorted' shows anything not yet grouped.",
                    "Groups are a view filter only — they do not affect routing or sound."
                ]
            ))
        ],
        howToOpen: "F6, or the Channel Rack icon in the toolbar."
    )

    // MARK: - Playlist

    static let playlist = InterfaceMap(
        id: "fl-playlist",
        daw: .fl,
        title: "Playlist",
        subtitle: "The arrangement timeline: pattern clips, audio clips, automation clips",
        aspect: 1.7,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),
            MapElement("tools", CGRect(x: 0.01, y: 0.02, width: 0.60, height: 0.09), "▲ DRAW  ✎ PAINT  ✂ SLICE  ⌫ DELETE  🔇 MUTE  ⇔ SELECT  🔍 ZOOM  ▶ PLAY", role: .control, detail: ElementDetail(
                title: "Tool bar",
                summary: "The mouse tools shared by the Playlist and Piano Roll.",
                bullets: [
                    "Draw (pencil) places one clip; Paint (brush) places repeatedly as you drag.",
                    "Slice cuts clips along a drawn line; Delete removes what you drag over.",
                    "Mute silences a clip without removing it; Select makes rectangular selections.",
                    "Zoom drags a rectangle to zoom into it; Playback auditions from a click point.",
                    "Right-click always deletes, whatever tool is active — so you rarely need the delete tool."
                ],
                shortcuts: [
                    Shortcut("B", "Paint tool"),
                    Shortcut("P", "Draw / pencil"),
                    Shortcut("E", "Select"),
                    Shortcut("C", "Slice"),
                    Shortcut("D", "Delete"),
                    Shortcut("T", "Mute"),
                    Shortcut("Z", "Zoom")
                ]
            )),
            MapElement("snap", CGRect(x: 0.62, y: 0.02, width: 0.16, height: 0.09), "SNAP ▾", role: .highlight, decorative: true),
            MapElement("menu", CGRect(x: 0.79, y: 0.02, width: 0.20, height: 0.09), "▾ PLAYLIST MENU", role: .control, detail: ElementDetail(
                title: "Playlist options menu",
                summary: "The small triangle at the top-left of the window.",
                bullets: [
                    "Tools → 'Consolidate' renders a selection (or a whole track) to a single audio clip.",
                    "'Quick quantize', 'Chop', and 'Riff machine' live in the same menu on the Piano Roll.",
                    "'Performance mode' turns the Playlist into a live clip-launcher, like Ableton's Session View.",
                    "'Detached' / 'Time markers' / 'Grid colour' change how the timeline is displayed."
                ]
            )),

            MapElement("ruler", CGRect(x: 0.14, y: 0.12, width: 0.85, height: 0.05), "TIMELINE  1 · · · 5 · · · 9 · · · 13", role: .highlight, detail: ElementDetail(
                title: "Timeline ruler",
                summary: "Click to move the playhead; drag to scrub.",
                bullets: [
                    "Right-click the ruler → 'Add time marker' (Ctrl+T when the Playlist has focus) names a section: Intro, Drop, Outro.",
                    "Ctrl+drag on the ruler defines a loop region for playback.",
                    "Double-click a time marker to rename it."
                ]
            )),

            MapElement("track1head", CGRect(x: 0.01, y: 0.18, width: 0.13, height: 0.08), "Track 1  ● S", role: .track, detail: ElementDetail(
                title: "Playlist track header",
                summary: "Playlist tracks are lanes, not instruments — any clip can go on any track.",
                bullets: [
                    "The LED mutes the track; right-click it to solo.",
                    "Right-click the name for rename/colour, 'Merge pattern clips', track height, and grouping.",
                    "Assign a track to a Performance-mode controller row from the same menu.",
                    "Because tracks are just lanes, keep a convention: drums at the top, automation at the bottom."
                ]
            )),
            MapElement("track1", CGRect(x: 0.14, y: 0.18, width: 0.85, height: 0.08), "", role: .surface, decorative: true),
            MapElement("clip1", CGRect(x: 0.15, y: 0.185, width: 0.20, height: 0.07), "Kick", role: .clip, detail: ElementDetail(
                title: "Pattern clip",
                summary: "A reference to a pattern placed at a point in time. Editing the pattern changes every copy of it.",
                bullets: [
                    "Paint with the brush (B) to repeat it across bars.",
                    "Drag the right edge to loop it longer; drag the left edge to trim.",
                    "Right-click → 'Make unique' when you want one copy to diverge from the rest.",
                    "Alt+drag makes a copy; Ctrl+B duplicates the selection to the right."
                ],
                shortcuts: [
                    Shortcut("Ctrl+B", "Duplicate selection"),
                    Shortcut("Alt+drag", "Copy clip"),
                    Shortcut("Ctrl+X/C/V", "Cut / copy / paste")
                ]
            )),
            MapElement("clip1b", CGRect(x: 0.36, y: 0.185, width: 0.20, height: 0.07), "Kick", role: .clip, decorative: true),

            MapElement("track2head", CGRect(x: 0.01, y: 0.27, width: 0.13, height: 0.08), "Track 2  ● S", role: .track, decorative: true),
            MapElement("track2", CGRect(x: 0.14, y: 0.27, width: 0.85, height: 0.08), "", role: .surface, decorative: true),
            MapElement("audioclip", CGRect(x: 0.20, y: 0.275, width: 0.42, height: 0.07), "▁▃▅▇▅▃▁ Vocal.wav", role: .audio, detail: ElementDetail(
                title: "Audio clip",
                summary: "A waveform placed directly on the timeline.",
                bullets: [
                    "Drag audio from the Browser or your desktop straight onto a track.",
                    "Right-click → 'Edit in Edison' for destructive editing; 'Chop' slices at transients.",
                    "The clip's channel settings (double-click) hold time stretching, pitch, and the stretch mode (Auto, Resample, Stretch, e3 Generic…).",
                    "Set the project tempo *before* dropping loops in, or use Time stretching to conform them."
                ]
            )),

            MapElement("track3head", CGRect(x: 0.01, y: 0.36, width: 0.13, height: 0.08), "Automation", role: .track, decorative: true),
            MapElement("track3", CGRect(x: 0.14, y: 0.36, width: 0.85, height: 0.08), "", role: .surface, decorative: true),
            MapElement("autoclip", CGRect(x: 0.15, y: 0.365, width: 0.55, height: 0.07), "╱‾‾╲__ Filter Cutoff", role: .highlight, detail: ElementDetail(
                title: "Automation clip",
                summary: "FL's way of automating anything: a clip on the Playlist that draws a parameter over time.",
                bullets: [
                    "Create one by right-clicking any knob or slider → 'Create automation clip'.",
                    "Right-click a control point for curve types: single curve, hold, stairs, smooth stairs, pulse, wave.",
                    "Drag the small diamond between two points to bend the curve.",
                    "Double-click a point to delete it; Alt+drag a point for fine control.",
                    "Automation clips can be looped, muted and moved like any other clip."
                ],
                gotcha: "An automation clip only plays where it sits on the timeline. Outside it, the knob holds whatever value it had — a common cause of 'my filter is stuck closed'."
            )),

            MapElement("perf", CGRect(x: 0.79, y: 0.47, width: 0.20, height: 0.07), "PERFORMANCE MODE", role: .transport, detail: ElementDetail(
                title: "Performance mode",
                summary: "Turns Playlist tracks into launchable clip rows for live use.",
                bullets: [
                    "Enable from the Playlist menu → Performance mode.",
                    "Each track becomes a row of triggerable blocks; a controller (or the keyboard) fires them.",
                    "Track properties set the trigger sync (1 beat, 1 bar, instant) and whether a clip loops or plays once."
                ]
            ))
        ],
        howToOpen: "F5, or the Playlist icon in the toolbar."
    )

    // MARK: - Piano Roll

    static let pianoRoll = InterfaceMap(
        id: "fl-pianoroll",
        daw: .fl,
        title: "Piano Roll",
        subtitle: "FL's melody editor — widely considered the best in any DAW",
        aspect: 1.85,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),
            MapElement("tools", CGRect(x: 0.01, y: 0.02, width: 0.55, height: 0.08), "▾ MENU  ▲ ✎ ✂ ⌫ 🔇 ⇔ 🔍 ▶   SNAP ▾", role: .control, detail: ElementDetail(
                title: "Piano Roll toolbar",
                summary: "Same tool set as the Playlist, plus the Piano Roll's own snap and the options menu.",
                bullets: [
                    "The ▾ menu holds Edit, Tools, View, Helpers, Snap, File and Target-channel.",
                    "Tools → Quick quantize (Ctrl+Q), Quick legato (Ctrl+L), Chop, Arpeggiate, Strum, Flam, Claw machine, Limit, Riff machine.",
                    "Helpers → Ghost channels, scale highlighting, and the stamp/chord tool."
                ]
            )),
            MapElement("stamp", CGRect(x: 0.57, y: 0.02, width: 0.20, height: 0.08), "STAMP: chords / scales", role: .clip, detail: ElementDetail(
                title: "Stamp tool (chords & scales)",
                summary: "A drop-down of ready-made chord shapes and scale markers you can stamp straight onto the grid.",
                bullets: [
                    "Pick a chord (maj7, min9, sus4…) and click on the grid to place the whole voicing.",
                    "The scale section highlights the notes of a key so out-of-key rows are dimmed.",
                    "Combine with Ghost channels to write parts that fit what's already there."
                ]
            )),
            MapElement("scale", CGRect(x: 0.78, y: 0.02, width: 0.21, height: 0.08), "SCALE HIGHLIGHT: C min", role: .highlight, detail: ElementDetail(
                title: "Scale highlighting",
                summary: "Helpers → Scale highlighting shades the rows that belong to a chosen key.",
                bullets: [
                    "It is a visual guide only — you can still play out-of-key notes deliberately.",
                    "Tools → Limit can force existing notes into the highlighted scale."
                ]
            )),

            MapElement("keys", CGRect(x: 0.01, y: 0.11, width: 0.07, height: 0.62), "PIANO KEYS", role: .midi, detail: ElementDetail(
                title: "Keyboard strip",
                summary: "Click to audition a pitch; right-click a key for per-key options in drum kits.",
                bullets: [
                    "Drag vertically to scroll the pitch range; Ctrl+scroll zooms.",
                    "For a sliced drum kit, the key names show the slice names."
                ]
            )),
            MapElement("grid", CGRect(x: 0.085, y: 0.11, width: 0.905, height: 0.62), "NOTE GRID", role: .midi, detail: ElementDetail(
                title: "Note grid",
                summary: "Left-click to place a note, right-click to delete, drag to move, drag the right edge to resize.",
                bullets: [
                    "New notes take the length of the last note you drew — set one length and paint the rest.",
                    "Ctrl+drag makes a rectangular selection; then move, transpose (↑/↓) or nudge (Ctrl+←/→).",
                    "Alt+drag a note ignores snapping for micro-timing.",
                    "Shift+drag a selection copies it.",
                    "Double-click a note opens its properties: pitch, velocity, pan, release, fine pitch, mod x/y.",
                    "Slide notes (the flag icon) glide the pitch of the note before them — the 303 bassline sound."
                ],
                shortcuts: [
                    Shortcut("Ctrl+Q", "Quick quantise"),
                    Shortcut("Ctrl+L", "Quick legato"),
                    Shortcut("Ctrl+A", "Select all"),
                    Shortcut("Ctrl+B", "Duplicate selection to the right"),
                    Shortcut("Alt+↑ / ↓", "Transpose by semitone"),
                    Shortcut("Ctrl+↑ / ↓", "Transpose by octave")
                ]
            )),
            MapElement("velolane", CGRect(x: 0.085, y: 0.75, width: 0.905, height: 0.22), "CONTROL LANE — velocity / pan / mod X / mod Y / pitch", role: .highlight, detail: ElementDetail(
                title: "Control (event) lane",
                summary: "The strip under the notes. The selector on its left picks which property you're editing.",
                bullets: [
                    "Velocity — how hard each note hits. Draw a line across several stems to make a ramp.",
                    "Pan, Release, Mod X (usually filter cutoff), Mod Y (resonance), Fine pitch.",
                    "Right-click-drag draws freehand; Alt+drag draws a straight line between two points.",
                    "The same lane also edits automation events for the channel when 'Note events' is switched to a controller."
                ]
            ))
        ],
        howToOpen: "F7 with a channel selected, or right-click a channel name → Piano roll."
    )

    // MARK: - Mixer

    static let mixer = InterfaceMap(
        id: "fl-mixer",
        daw: .fl,
        title: "Mixer",
        subtitle: "Inserts, effects slots and routing",
        aspect: 1.5,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),

            MapElement("masterstrip", CGRect(x: 0.02, y: 0.08, width: 0.09, height: 0.70), "MASTER", role: .meter, detail: ElementDetail(
                title: "Master insert",
                summary: "Everything ends here, and this is the level that gets exported.",
                bullets: [
                    "Keep peaks around −6 dB while producing; leave headroom for mastering.",
                    "Put a limiter (Fruity Limiter or Maximus) here last if you need loudness — after any EQ.",
                    "The Master's own FX slots process the entire mix."
                ]
            )),
            MapElement("ins1", CGRect(x: 0.12, y: 0.08, width: 0.08, height: 0.70), "INS 1\nKick", role: .track, detail: ElementDetail(
                title: "Insert track",
                summary: "One channel strip. Channels from the rack are routed here by their FX number.",
                bullets: [
                    "Name and colour it (F2 with the insert selected) so the mixer stays readable.",
                    "Fader = level, knob at the top = pan, and the small knob beside it = stereo separation.",
                    "The two arrows at the bottom-left arm the insert for audio recording and set its input.",
                    "The small triangle at the bottom of the strip is the routing arrow — it lights when the insert sends to Master."
                ],
                shortcuts: [
                    Shortcut("F2", "Rename insert"),
                    Shortcut("Ctrl+L", "Link selected channels to free inserts"),
                    Shortcut("Alt+click fader", "Reset to 0 dB")
                ]
            )),
            MapElement("ins2", CGRect(x: 0.21, y: 0.08, width: 0.08, height: 0.70), "INS 2\nBass", role: .track, decorative: true),
            MapElement("ins3", CGRect(x: 0.30, y: 0.08, width: 0.08, height: 0.70), "INS 3\nVox", role: .track, decorative: true),
            MapElement("bus", CGRect(x: 0.39, y: 0.08, width: 0.08, height: 0.70), "INS 4\nREVERB BUS", role: .audio, detail: ElementDetail(
                title: "Using an insert as a send/bus",
                summary: "There are no dedicated 'return' tracks in FL — any insert can be one.",
                bullets: [
                    "Select the source insert, then click the send arrow at the bottom of the destination insert to open a send.",
                    "A small knob appears under the destination showing send level.",
                    "Switch off the source's direct routing to Master if you want it to be heard *only* through the bus.",
                    "The same mechanism builds drum buses: route several inserts into one, then process that one."
                ],
                gotcha: "Routing is directional and easy to loop by accident. FL will refuse feedback loops and grey out the arrow."
            )),

            MapElement("fxslots", CGRect(x: 0.50, y: 0.08, width: 0.30, height: 0.60), "EFFECT SLOTS  (10)\n\n1  Fruity Parametric EQ 2\n2  Fruity Compressor\n3  ---\n…", role: .device, detail: ElementDetail(
                title: "Effect slots",
                summary: "Ten slots per insert, processed top to bottom.",
                bullets: [
                    "Click an empty slot to browse plugins; click a loaded one's name to open its editor.",
                    "The LED left of each slot bypasses it; the knob on the right is that effect's dry/wet mix.",
                    "Right-click a slot for Replace, Move up/down, Save preset, and 'Make bridged'.",
                    "Drag a slot to reorder — order changes the sound.",
                    "The whole chain can be saved: right-click the insert name → Save mixer track state."
                ]
            )),
            MapElement("sendknobs", CGRect(x: 0.82, y: 0.08, width: 0.16, height: 0.26), "SEND KNOBS + ROUTING ARROWS", role: .audio, detail: ElementDetail(
                title: "Routing arrows",
                summary: "The row of small triangles under the inserts sets where each insert's audio goes.",
                bullets: [
                    "Select an insert; the arrows under other inserts show whether it feeds them.",
                    "Click an arrow to open/close the route; the knob above it sets the amount.",
                    "Right-click an arrow for pre/post-fader and for 'sidechain to this track' — that's how you feed a compressor's sidechain input."
                ]
            )),
            MapElement("io", CGRect(x: 0.82, y: 0.36, width: 0.16, height: 0.32), "IN ▾ / OUT ▾", role: .control, detail: ElementDetail(
                title: "Insert input and output",
                summary: "Hardware in and out for that insert.",
                bullets: [
                    "IN picks an input from your audio interface, so you can record onto that insert.",
                    "OUT can send the insert to a different physical output pair.",
                    "Set the recording file location with the disk icon at the top of the mixer."
                ]
            )),
            MapElement("recarm", CGRect(x: 0.12, y: 0.80, width: 0.35, height: 0.10), "● ARM FOR AUDIO RECORDING", role: .danger, detail: ElementDetail(
                title: "Record arm",
                summary: "The circle on an insert with an input assigned. Arm it, then hit the transport record button.",
                bullets: [
                    "FL asks what to record (audio into the playlist, or into Edison).",
                    "The recorded file lands in the project folder; the clip appears on the Playlist.",
                    "Set your input latency compensation in Options → Audio settings if takes land early or late."
                ]
            ))
        ],
        howToOpen: "F9, or the Mixer icon in the toolbar."
    )

    // MARK: - Browser

    static let browser = InterfaceMap(
        id: "fl-browser",
        daw: .fl,
        title: "Browser",
        subtitle: "Samples, presets, plugin database and the project's own content",
        aspect: 0.6,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),
            MapElement("search", CGRect(x: 0.04, y: 0.02, width: 0.92, height: 0.05), "SEARCH", role: .highlight, detail: ElementDetail(
                title: "Browser search",
                summary: "Filters the whole tree as you type.",
                bullets: ["Ctrl+F focuses it when the Browser has focus.", "Results respect the currently selected browser tab."]
            )),
            MapElement("tabs", CGRect(x: 0.04, y: 0.08, width: 0.92, height: 0.06), "TABS: ALL · PLUGINS · SAMPLES · PROJECTS", role: .control, detail: ElementDetail(
                title: "Browser tabs",
                summary: "Saved views of the tree so you're not scrolling past everything.",
                bullets: ["Right-click the tab strip to add, remove and configure tabs.", "Each tab remembers its own scroll position and filter."]
            )),
            MapElement("tree", CGRect(x: 0.04, y: 0.15, width: 0.92, height: 0.62), "Channel presets\nClipboard files\nCurrent project\nEffects\nGenerators\nMixer presets\nPacks\nPlugin database\nProjects\nRecorded\nScores\nSpeech\nTemplates", role: .browser, detail: ElementDetail(
                title: "The folder tree",
                summary: "FL's browser is a view of real folders on disk plus a few virtual ones.",
                bullets: [
                    "Current project — every sample and plugin used in this project. Invaluable for finding a sound you loaded and lost.",
                    "Plugin database — your VSTs, sorted into folders you control (right-click a plugin → add to database).",
                    "Packs — the bundled sample packs.",
                    "Recorded — audio you have recorded in this project.",
                    "Scores — MIDI patterns, including the ones FL ships with.",
                    "Templates — project starting points; File → New from template."
                ],
                actions: [
                    "Add your own sample folders: Options → File settings → Browser extra search folders.",
                    "Drag anything from here into the Channel Rack, Playlist or a mixer slot."
                ]
            )),
            MapElement("preview", CGRect(x: 0.04, y: 0.79, width: 0.92, height: 0.08), "PREVIEW  ▶  loop  ·  tempo-sync", role: .audio, detail: ElementDetail(
                title: "Sample preview",
                summary: "Click a sample to hear it without loading it.",
                bullets: [
                    "The metronome-ish icon at the top of the browser makes previews play in time with the project.",
                    "Preview volume is set by the small knob beside it."
                ]
            )),
            MapElement("menu", CGRect(x: 0.04, y: 0.89, width: 0.92, height: 0.08), "▾ BROWSER MENU — extra folders, sort, refresh", role: .control, decorative: true)
        ],
        howToOpen: "F8, or the Browser icon in the toolbar."
    )

    // MARK: - Plugin wrapper

    static let pluginWrapper = InterfaceMap(
        id: "fl-plugin-wrapper",
        daw: .fl,
        title: "Plugin Wrapper",
        subtitle: "The frame FL puts around every plugin — and the settings hidden in it",
        aspect: 2.0,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),
            MapElement("titlebar", CGRect(x: 0.02, y: 0.05, width: 0.96, height: 0.14), "▾  Serum  ◀ preset ▶   ⚙   ✕", role: .control, detail: ElementDetail(
                title: "Wrapper title bar",
                summary: "Preset arrows, the wrapper settings cog, and the plugin's own name.",
                bullets: [
                    "The ◀ ▶ arrows step through the plugin's presets without opening its browser.",
                    "The ▾ menu on the left has Save preset, Randomize, and 'Detach' (float the window).",
                    "The cog opens the wrapper settings pages below."
                ]
            )),
            MapElement("settingspages", CGRect(x: 0.02, y: 0.22, width: 0.30, height: 0.70), "WRAPPER PAGES\n\nPlugin\nProcessing\nTroubleshooting\nVST wrapper", role: .browser, detail: ElementDetail(
                title: "Wrapper settings pages",
                summary: "Four pages of options that live outside the plugin itself.",
                bullets: []
            )),
            MapElement("processing", CGRect(x: 0.34, y: 0.22, width: 0.31, height: 0.70), "PROCESSING\n\nSmart disable\nFixed size buffers\nNotify about rendering\nAllow threaded processing\nPDC / extra latency", role: .device, detail: ElementDetail(
                title: "Processing page",
                summary: "Where CPU problems get solved.",
                bullets: [
                    "Smart disable — the plugin idles when it isn't making sound. Huge CPU saving; switch it on for everything via Tools → Macros.",
                    "Allow threaded processing — keep on unless a plugin misbehaves.",
                    "Fixed size buffers — needed by a few older plugins that glitch otherwise.",
                    "Notify about rendering — lets the plugin know it's an offline export so it can render at full quality.",
                    "Extra latency / PDC — manual delay compensation when a plugin reports its latency wrongly."
                ]
            )),
            MapElement("vstpage", CGRect(x: 0.67, y: 0.22, width: 0.31, height: 0.70), "VST WRAPPER\n\nMIDI input port\nMIDI output port\nSend loop position\nUse fixed size buffers\nBridge / 32-bit", role: .midi, detail: ElementDetail(
                title: "VST wrapper page",
                summary: "MIDI ports and bridging.",
                bullets: [
                    "MIDI input port number lets another channel send notes to this plugin — the standard way to drive multi-timbral instruments and vocoders.",
                    "'Send loop position' is needed by plugins that sync to song position (arpeggiators, some samplers).",
                    "Bridged mode runs the plugin in a separate process — the fix for 32-bit plugins and for crashy ones."
                ]
            ))
        ],
        howToOpen: "Open any plugin, then click the cog in its title bar."
    )

    // MARK: - Settings

    static let settings = InterfaceMap(
        id: "fl-settings",
        daw: .fl,
        title: "Settings",
        subtitle: "Options → the six tabs, and what to change in each",
        aspect: 1.4,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),
            MapElement("tabs", CGRect(x: 0.02, y: 0.04, width: 0.22, height: 0.90), "MIDI\nAUDIO\nGENERAL\nFILE\nPROJECT\nINFO\nDEBUG", role: .browser, detail: ElementDetail(
                title: "Settings tabs",
                summary: "Reached from the Options menu (or F10).",
                bullets: [],
                shortcuts: [Shortcut("F10", "Open Settings")]
            )),
            MapElement("audio", CGRect(x: 0.26, y: 0.04, width: 0.72, height: 0.40), "AUDIO\n\nDevice (ASIO)\nBuffer length\nSample rate\nPriority · Safe overloads\nTriple buffer\nMixer: resampling quality", role: .audio, detail: ElementDetail(
                title: "Audio settings",
                summary: "Set this first, on a new install and on every new machine.",
                bullets: [
                    "Device: use FL Studio ASIO or your interface's own ASIO driver on Windows; CoreAudio on macOS. Avoid 'Primary Sound Driver'.",
                    "Buffer length: ~10 ms (441–512 samples) for playing in; larger when mixing a heavy project.",
                    "Sample rate 44.1 or 48 kHz; higher only if you have a reason.",
                    "Safe overloads: on. Triple buffer: on if you get dropouts.",
                    "Resampling quality: 'Sinc' variants for export quality; the render dialog has its own setting too.",
                    "'Auto close device' lets other apps use the interface when FL is in the background."
                ],
                gotcha: "Latency you can feel while playing = buffer length. Crackles = buffer too small (or CPU pinned)."
            )),
            MapElement("midi", CGRect(x: 0.26, y: 0.46, width: 0.35, height: 0.24), "MIDI\n\nInput ports\nOutput ports\nEnable · Port number\nController type\nAuto-accept detected", role: .midi, detail: ElementDetail(
                title: "MIDI settings",
                summary: "Where controllers get switched on.",
                bullets: [
                    "Select your device in Input, then click 'Enable'. Without that it does nothing.",
                    "Give it a port number if you want to address it from a specific channel.",
                    "Pick a controller type to load FL's own mapping for known hardware.",
                    "'Auto accept detected controller' saves time when plugging in new gear.",
                    "'Link note on velocity to' and 'Link release velocity to' route velocity to a parameter."
                ]
            )),
            MapElement("general", CGRect(x: 0.63, y: 0.46, width: 0.35, height: 0.24), "GENERAL\n\nUndo history\nAuto-save\nUI scaling\nRendering\nMouse wheel", role: .control, detail: ElementDetail(
                title: "General settings",
                summary: "Interface and safety behaviour.",
                bullets: [
                    "Undo history length — raise it; the default is conservative.",
                    "'Undo knob tweaks' decides whether knob moves fill your undo stack.",
                    "Auto-save / backup interval: on, always. FL keeps backups in the project's Backup folder.",
                    "UI scaling and 'Use system scaling' for high-DPI screens.",
                    "'Reset automated controls on song start' avoids stuck parameters."
                ]
            )),
            MapElement("file", CGRect(x: 0.26, y: 0.72, width: 0.35, height: 0.24), "FILE\n\nBrowser extra search folders\nVST plugin search paths\nProject data folder\nManage plugins → Find installed", role: .browser, detail: ElementDetail(
                title: "File settings",
                summary: "Where FL looks for your samples and plugins.",
                bullets: [
                    "Browser extra search folders: point these at your sample library and it appears in the Browser tree.",
                    "VST plugin extra search folder: add your VST2/VST3 directories.",
                    "'Manage plugins' → 'Find installed plugins' scans and can 'Verify' each one; scan results feed the Plugin Picker.",
                    "Project data folder is where recordings and rendered files default to."
                ]
            )),
            MapElement("project", CGRect(x: 0.63, y: 0.72, width: 0.35, height: 0.24), "PROJECT\n\nTitle · Genre · Comments\nTempo · Time signature\nPPQ resolution", role: .control, detail: ElementDetail(
                title: "Project settings",
                summary: "Per-project metadata and timing resolution.",
                bullets: [
                    "PPQ (ticks per beat) sets timing resolution — 96 is default, higher for very fine micro-timing. Set it before you start, not after.",
                    "Comments here travel with the project file.",
                    "Time signature affects the ruler and metronome, not the audio."
                ]
            ))
        ],
        howToOpen: "F10, or Options → (any) settings."
    )
}
