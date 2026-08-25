import SwiftUI

/// Annotated diagrams of every screen in Ableton Live you need to operate.
/// Coordinates are normalised (0...1) inside each map's aspect box.
enum AbletonMaps {

    static let all: [InterfaceMap] = [
        session, arrangement, controlBar, browser, mixer, midiEditor, deviceChain, preferences
    ]

    // MARK: - Session View

    static let session = InterfaceMap(
        id: "live-session",
        daw: .ableton,
        title: "Session View",
        subtitle: "The clip-launching grid — where ideas get built and jammed",
        aspect: 1.55,
        elements: [
            // Chrome
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),

            MapElement("controlbar", CGRect(x: 0, y: 0, width: 1, height: 0.075), "CONTROL BAR", role: .control, detail: ElementDetail(
                title: "Control Bar",
                summary: "The always-visible strip across the top holding tempo, transport, metronome, quantisation and the view switch.",
                bullets: [
                    "Left third: Link / Tap tempo / tempo field / time signature / metronome.",
                    "Middle: transport — play, stop, record, arrangement position, loop.",
                    "Right: MIDI + key mapping, MIDI/audio activity LEDs, CPU meter, view switch.",
                    "Every field here is draggable: click and drag up/down instead of typing."
                ],
                actions: ["Tap the Control Bar section in this app for a blown-up map of every field."],
                shortcuts: [Shortcut("Tab", "Switch Session ⇄ Arrangement")]
            )),

            MapElement("browser", CGRect(x: 0, y: 0.075, width: 0.175, height: 0.925), "BROWSER", role: .browser, detail: ElementDetail(
                title: "Browser",
                summary: "The left sidebar: sounds, drums, instruments, effects, samples, plug-ins and your own folders.",
                bullets: [
                    "Top group (Collections) — the coloured labels you assign to favourites.",
                    "Middle group (Library) — Sounds, Drums, Instruments, Audio Effects, MIDI Effects, Max for Live, Plug-Ins, Clips, Samples.",
                    "Bottom group (Places) — Packs, User Library, Current Project, plus any folder you add.",
                    "Preview speaker icon at the bottom auditions a file before you load it; the headphone toggle plays it in time with your set."
                ],
                actions: [
                    "Double-click an instrument to drop it on the selected track.",
                    "Drag a sample onto an empty clip slot to create a clip.",
                    "Right-click a folder → Add Folder to keep your own sample library here."
                ],
                shortcuts: [
                    Shortcut("Cmd+Alt+B", "Show/hide Browser"),
                    Shortcut("Cmd+F", "Search the Browser"),
                    Shortcut("Enter", "Load the highlighted item")
                ]
            )),

            // Track headers
            MapElement("trackhead1", CGRect(x: 0.185, y: 0.09, width: 0.13, height: 0.045), "1 Drums", role: .track, detail: ElementDetail(
                title: "Track Header (title bar)",
                summary: "Names the track and selects it; every track in Live is either MIDI, Audio, Return or Master.",
                bullets: [
                    "Double-click the name to rename. Ctrl/Cmd-click → Rename, Duplicate, Delete, Group, Freeze, Flatten.",
                    "The colour you set here follows through to the clips and the Arrangement.",
                    "Drag the right edge to widen the track; drag the header itself to reorder."
                ],
                actions: [
                    "Cmd+G groups selected tracks into a Group Track (a folder with its own mixer strip).",
                    "Right-click → Freeze Track when a plug-in is eating CPU; Flatten renders it to audio."
                ],
                shortcuts: [
                    Shortcut("Cmd+T", "Insert Audio Track"),
                    Shortcut("Cmd+Shift+T", "Insert MIDI Track"),
                    Shortcut("Cmd+Alt+T", "Insert Return Track"),
                    Shortcut("Cmd+G", "Group tracks"),
                    Shortcut("Cmd+R", "Rename")
                ]
            )),
            MapElement("trackhead2", CGRect(x: 0.320, y: 0.09, width: 0.13, height: 0.045), "2 Bass", role: .track, detail: ElementDetail(
                title: "MIDI Track",
                summary: "Holds MIDI clips and an instrument; outputs audio once an instrument is loaded.",
                bullets: [
                    "A MIDI track with no instrument still records notes — it just makes no sound.",
                    "Its device chain reads: MIDI effects → Instrument → Audio effects.",
                    "MIDI From / MIDI To selectors in the mixer decide what plays it and where its notes go."
                ]
            )),
            MapElement("trackhead3", CGRect(x: 0.455, y: 0.09, width: 0.13, height: 0.045), "3 Vox", role: .track, detail: ElementDetail(
                title: "Audio Track",
                summary: "Holds audio clips (samples, recordings) and audio effects only.",
                bullets: [
                    "Audio From picks the input (an interface channel, or Resampling, or another track).",
                    "Monitor In/Auto/Off decides when you hear the live input — Auto is right for nearly everything.",
                    "Dropping a sample here creates an audio clip that Live warps to your project tempo."
                ]
            )),
            MapElement("trackhead4", CGRect(x: 0.590, y: 0.09, width: 0.12, height: 0.045), "A Reverb", role: .track, detail: ElementDetail(
                title: "Return Track",
                summary: "A shared effect bus. Tracks feed it with their Send knobs instead of each loading its own reverb.",
                bullets: [
                    "Named with letters (A, B, C…) rather than numbers.",
                    "Put the effect here with its Dry/Wet at 100% — the Send knob controls how much you hear.",
                    "Pre/Post toggle at the bottom of the return decides whether sends are taken before or after the track fader."
                ],
                shortcuts: [Shortcut("Cmd+Alt+T", "Insert Return Track")]
            )),

            // Clip grid
            MapElement("clip-r1c1", CGRect(x: 0.185, y: 0.145, width: 0.13, height: 0.055), "▶ Loop A", role: .clip, detail: ElementDetail(
                title: "Clip Slot (with a clip in it)",
                summary: "A container for a loop of audio or MIDI. Clicking it launches the clip; it is the single most-used control in Live.",
                bullets: [
                    "The triangle on the left is the launch button. It turns into a square when playing.",
                    "Clips only start on the next Global Quantisation boundary (the '1 Bar' field in the Control Bar).",
                    "A clip's Launch Mode (Trigger, Gate, Toggle, Repeat) is set in the Clip View's Launch box.",
                    "Right-click for Copy/Paste, Delete, Duplicate, Edit MIDI, and 'Consolidate Time to New Scene'."
                ],
                actions: [
                    "Click = launch. Click again does nothing — use the Stop button or the Clip Stop button in the same slot.",
                    "Drag a clip to another slot to move it; Alt-drag to copy.",
                    "Cmd/Ctrl+click a MIDI clip and hit Shift+Tab to open its notes."
                ],
                shortcuts: [
                    Shortcut("Enter", "Launch selected clip"),
                    Shortcut("Cmd+D", "Duplicate clip"),
                    Shortcut("Shift+Tab", "Toggle Clip / Device view")
                ],
                gotcha: "If a clip won't start immediately, that's Global Quantisation doing its job, not a bug. Set it to 'None' to launch instantly."
            )),
            MapElement("clip-r1c2", CGRect(x: 0.320, y: 0.145, width: 0.13, height: 0.055), "▶ Sub", role: .clip, decorative: true),
            MapElement("clip-r1c3", CGRect(x: 0.455, y: 0.145, width: 0.13, height: 0.055), "", role: .control, detail: ElementDetail(
                title: "Empty Clip Slot",
                summary: "An empty slot is not nothing — clicking it stops whatever that track was playing.",
                bullets: [
                    "Empty slots on an armed track are where you record: click the slot's record button to capture MIDI or audio into it.",
                    "The small square in an empty slot is the Clip Stop button; you can delete it (right-click → Remove Stop Button) so the track keeps playing through that scene."
                ]
            )),
            MapElement("clip-r2c1", CGRect(x: 0.185, y: 0.205, width: 0.13, height: 0.055), "▶ Fill", role: .clip, decorative: true),
            MapElement("clip-r2c2", CGRect(x: 0.320, y: 0.205, width: 0.13, height: 0.055), "▶ Bass B", role: .clip, decorative: true),
            MapElement("clip-r2c3", CGRect(x: 0.455, y: 0.205, width: 0.13, height: 0.055), "● REC", role: .danger, detail: ElementDetail(
                title: "Slot Record Button",
                summary: "Appears in an empty slot when the track is armed. Starts recording a new clip in that slot.",
                bullets: [
                    "For MIDI: records what you play on your controller into a new MIDI clip.",
                    "For audio: records the track's input, respecting the Record Quantisation setting.",
                    "Recording keeps looping and extending until you press the slot again (which stops recording and starts playback of what you just made)."
                ],
                shortcuts: [Shortcut("F9", "Toggle session record")]
            )),
            MapElement("clip-r3c1", CGRect(x: 0.185, y: 0.265, width: 0.13, height: 0.055), "", role: .control, decorative: true),
            MapElement("clip-r3c2", CGRect(x: 0.320, y: 0.265, width: 0.13, height: 0.055), "", role: .control, decorative: true),
            MapElement("clip-r3c3", CGRect(x: 0.455, y: 0.265, width: 0.13, height: 0.055), "", role: .control, decorative: true),

            MapElement("stoprow", CGRect(x: 0.185, y: 0.325, width: 0.385, height: 0.04), "■ CLIP STOP ROW", role: .control, detail: ElementDetail(
                title: "Track Stop Buttons",
                summary: "One square per track that stops that track's playing clip at the next quantisation point.",
                bullets: [
                    "Stops the clip, not the transport — the song keeps running.",
                    "The row under the grid stops the whole track; the square inside a scene stops that track when that scene fires."
                ]
            )),

            // Scenes
            MapElement("scene1", CGRect(x: 0.720, y: 0.145, width: 0.10, height: 0.055), "▶ Verse", role: .transport, detail: ElementDetail(
                title: "Scene Launch",
                summary: "A scene is a horizontal row. Launching it fires every clip in that row at once — that is how you arrange a song live.",
                bullets: [
                    "Rename scenes (Cmd+R) to Intro / Verse / Drop so the column becomes a song form.",
                    "Type a number into a scene name (e.g. '128') and the scene sets the tempo when launched; add a time signature like '4/4' too.",
                    "Right-click → Capture and Insert Scene grabs whatever is currently playing into a new scene."
                ],
                actions: [
                    "Select Next/Previous scene with the arrow keys, then Enter to fire it — no mouse needed."
                ],
                shortcuts: [
                    Shortcut("Enter", "Launch selected scene"),
                    Shortcut("↑ / ↓", "Move scene selection"),
                    Shortcut("Cmd+Shift+I", "Insert Scene"),
                    Shortcut("Cmd+Shift+C", "Capture and Insert Scene")
                ]
            )),
            MapElement("scene2", CGRect(x: 0.720, y: 0.205, width: 0.10, height: 0.055), "▶ Drop", role: .transport, decorative: true),
            MapElement("scene3", CGRect(x: 0.720, y: 0.265, width: 0.10, height: 0.055), "▶ Break", role: .transport, decorative: true),
            MapElement("scenestop", CGRect(x: 0.720, y: 0.325, width: 0.10, height: 0.04), "■ STOP ALL", role: .danger, detail: ElementDetail(
                title: "Stop All Clips",
                summary: "Stops every playing clip in the Session at the next quantisation point.",
                bullets: ["The transport keeps rolling — use the Control Bar's Stop button to halt time itself."]
            )),

            // Master
            MapElement("master", CGRect(x: 0.83, y: 0.09, width: 0.16, height: 0.60), "MASTER", role: .meter, detail: ElementDetail(
                title: "Master Track",
                summary: "Everything ends up here. Its meter is the one that must not go into the red.",
                bullets: [
                    "The Master's clip slots hold scenes only — you cannot put clips on it.",
                    "Master output routing (Master Out) picks the physical outputs of your interface.",
                    "The crossfader lives at the bottom of the Master strip; tracks are assigned A or B with the small buttons in their mixer strips.",
                    "Preview/Cue volume next to it controls the Browser preview and cue output, not the mix."
                ],
                gotcha: "Aim for peaks around −6 dB on the Master while you work. Anything clipping here (meter turning red) will distort in the export."
            )),

            // Mixer strip area
            MapElement("mixer", CGRect(x: 0.185, y: 0.375, width: 0.525, height: 0.30), "MIXER STRIPS — volume / pan / sends / IO / arm", role: .meter, detail: ElementDetail(
                title: "Session Mixer",
                summary: "Per-track volume fader, pan, sends, activator, solo, arm and input/output routing.",
                bullets: [
                    "Toggle each row of controls with the small circular buttons on the far right edge of the Session View.",
                    "Track Activator (the numbered square) mutes the track; Solo (S) silences everything else; Arm (○) enables recording.",
                    "Cmd/Ctrl-click Solo to solo more than one track at a time.",
                    "Shift-drag any fader for fine resolution; Delete on a control resets it to default."
                ],
                shortcuts: [
                    Shortcut("Cmd+Alt+M", "Show/hide Mixer section"),
                    Shortcut("Delete on a control", "Reset to default")
                ]
            )),

            MapElement("detailview", CGRect(x: 0.185, y: 0.69, width: 0.805, height: 0.30), "DETAIL VIEW — Clip View / Device View", role: .device, detail: ElementDetail(
                title: "Detail View",
                summary: "The bottom pane. It shows either the selected clip's settings (Clip View) or the selected track's devices (Device View).",
                bullets: [
                    "Shift+Tab flips between the two.",
                    "Clip View for audio: Sample box (warp, transpose, gain), Envelopes, Launch box, Notes box.",
                    "Clip View for MIDI: the piano roll editor plus the same Launch and Envelope boxes.",
                    "Device View: the horizontal chain of instruments and effects on the selected track."
                ],
                shortcuts: [
                    Shortcut("Shift+Tab", "Clip View ⇄ Device View"),
                    Shortcut("Cmd+Alt+L", "Show/hide Detail View")
                ]
            )),

            MapElement("viewswitch", CGRect(x: 0.875, y: 0.008, width: 0.115, height: 0.058), "SESS/ARR", role: .highlight, detail: ElementDetail(
                title: "Session / Arrangement Switch",
                summary: "Live has two views of the same set: the Session grid for jamming and the Arrangement timeline for finished songs.",
                bullets: [
                    "Same tracks, same devices — only the way clips are laid out in time differs.",
                    "Record from Session into Arrangement by pressing the global Record button while launching clips.",
                    "Once you touch the Arrangement, the 'Back to Arrangement' button lights up orange; press it to hand control back to the timeline."
                ],
                shortcuts: [Shortcut("Tab", "Switch views")]
            ))
        ],
        howToOpen: "Press Tab from Arrangement View, or click the round switch at the top-right of the window."
    )

    // MARK: - Arrangement View

    static let arrangement = InterfaceMap(
        id: "live-arrangement",
        daw: .ableton,
        title: "Arrangement View",
        subtitle: "The linear timeline — where a jam becomes a finished song",
        aspect: 1.7,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),
            MapElement("controlbar", CGRect(x: 0, y: 0, width: 1, height: 0.07), "CONTROL BAR", role: .control, decorative: true),

            MapElement("ruler", CGRect(x: 0.18, y: 0.095, width: 0.81, height: 0.04), "BEAT TIME RULER  1 · 5 · 9 · 13 · 17", role: .highlight, detail: ElementDetail(
                title: "Beat Time Ruler",
                summary: "The bars-and-beats scale across the top. Clicking it moves the insert marker; dragging it scrubs.",
                bullets: [
                    "Zoom by dragging up/down on the ruler, or with + / − keys.",
                    "Right-click the ruler to switch the time format between bars:beats:sixteenths and real time.",
                    "The thin strip above it is the Arrangement Loop brace."
                ],
                shortcuts: [
                    Shortcut("+ / −", "Zoom in / out"),
                    Shortcut("Cmd+E", "Split clip at insert marker"),
                    Shortcut("Cmd+J", "Consolidate selection into one clip")
                ]
            )),

            MapElement("loopbrace", CGRect(x: 0.34, y: 0.072, width: 0.30, height: 0.018), "LOOP BRACE", role: .transport, detail: ElementDetail(
                title: "Arrangement Loop Brace",
                summary: "The yellow bar that marks the looped region of the timeline.",
                bullets: [
                    "Drag its ends to resize, drag the middle to move it.",
                    "Select a range of clips and press Cmd+L to set the loop to that selection.",
                    "The Loop switch in the Control Bar turns looping on and off; the brace stays put either way."
                ],
                shortcuts: [
                    Shortcut("Cmd+L", "Loop selection"),
                    Shortcut("Cmd+Shift+L", "Toggle Loop on/off")
                ]
            )),

            // Track lanes
            MapElement("lane1head", CGRect(x: 0, y: 0.145, width: 0.175, height: 0.125), "1 Drums  ⊞ ○ S", role: .track, detail: ElementDetail(
                title: "Arrangement Track Header",
                summary: "Name, unfold triangle, activator, solo, arm — plus the track's height.",
                bullets: [
                    "The ⊞ triangle unfolds the track to reveal automation lanes underneath it.",
                    "Alt+click the unfold triangle to unfold every track at once.",
                    "Drag the bottom edge of a header to resize; Shift-drag resizes all tracks together."
                ],
                shortcuts: [
                    Shortcut("Alt+U", "Unfold selected tracks"),
                    Shortcut("Cmd+Alt+U", "Optimize track height")
                ]
            )),
            MapElement("lane1", CGRect(x: 0.18, y: 0.14, width: 0.81, height: 0.13), "", role: .surface, decorative: true),
            MapElement("clipA", CGRect(x: 0.19, y: 0.15, width: 0.24, height: 0.11), "Drums Loop", role: .clip, detail: ElementDetail(
                title: "Arrangement Clip",
                summary: "A block of audio or MIDI placed at a fixed point in time.",
                bullets: [
                    "Drag the left/right edge to trim; drag the middle to move (it snaps to the grid).",
                    "The top half is the drag strip, the lower half selects content.",
                    "Fade handles appear at the top corners — drag them to fade in/out; the middle handle bends the curve.",
                    "Cmd+E splits at the insert marker; Cmd+J consolidates a selection into a single clip."
                ],
                actions: [
                    "Alt-drag = duplicate. Cmd+D = duplicate to the right by the clip's own length.",
                    "Right-click → Consolidate Time to New Scene sends the section back to Session View."
                ],
                shortcuts: [
                    Shortcut("Cmd+E", "Split"),
                    Shortcut("Cmd+J", "Consolidate"),
                    Shortcut("Cmd+D", "Duplicate"),
                    Shortcut("Cmd+0", "Deactivate (mute) clip")
                ]
            )),
            MapElement("clipA2", CGRect(x: 0.45, y: 0.15, width: 0.24, height: 0.11), "Drums Loop", role: .clip, decorative: true),

            MapElement("lane2head", CGRect(x: 0, y: 0.28, width: 0.175, height: 0.13), "2 Bass  ⊞ ○ S", role: .track, decorative: true),
            MapElement("lane2", CGRect(x: 0.18, y: 0.28, width: 0.81, height: 0.13), "", role: .surface, decorative: true),
            MapElement("clipB", CGRect(x: 0.30, y: 0.29, width: 0.34, height: 0.11), "Bass MIDI", role: .midi, detail: ElementDetail(
                title: "MIDI Clip in the Arrangement",
                summary: "Shows a miniature of the notes inside. Double-click to open it in the MIDI editor below.",
                bullets: [
                    "Looping a MIDI clip in Arrangement: open it and switch on Loop in the Clip View's Sample/Notes box.",
                    "Notes can be edited in place by dragging the clip taller (unfold the track)."
                ]
            )),

            MapElement("autolane", CGRect(x: 0.18, y: 0.42, width: 0.81, height: 0.10), "AUTOMATION LANE — filter cutoff", role: .highlight, detail: ElementDetail(
                title: "Automation Lane",
                summary: "A breakpoint envelope for one parameter over time. This is how anything moves by itself.",
                bullets: [
                    "Press A to toggle Automation Mode — clip areas dim and every automatable parameter becomes drawable.",
                    "Click a line to add a breakpoint; drag it to move; double-click a breakpoint to delete it.",
                    "Alt+drag a segment to curve it. Cmd/Ctrl+drag for fine adjustment.",
                    "The lane's chooser (two small dropdowns in the track header) picks device and parameter.",
                    "Red automation values mean an automated parameter has been overridden — press 'Back to Arrangement' to restore."
                ],
                actions: [
                    "With Draw Mode on (B), automation is drawn in grid-sized steps instead of breakpoints."
                ],
                shortcuts: [
                    Shortcut("A", "Automation Mode"),
                    Shortcut("B", "Draw Mode"),
                    Shortcut("Alt+drag", "Curve a segment")
                ]
            )),

            MapElement("mastertrack", CGRect(x: 0, y: 0.53, width: 0.99, height: 0.09), "MASTER TRACK", role: .meter, decorative: true),

            MapElement("punch", CGRect(x: 0.02, y: 0.005, width: 0.13, height: 0.055), "PUNCH IN/OUT", role: .danger, detail: ElementDetail(
                title: "Punch In / Punch Out",
                summary: "Restricts recording to the loop brace so you don't overwrite what's outside it.",
                bullets: [
                    "Punch-In: recording only starts when the playhead reaches the loop start.",
                    "Punch-Out: recording stops at the loop end.",
                    "Use both when re-recording one section of a take."
                ]
            )),

            MapElement("backtoarr", CGRect(x: 0.83, y: 0.005, width: 0.16, height: 0.055), "BACK TO ARRANGEMENT", role: .clip, detail: ElementDetail(
                title: "Back to Arrangement",
                summary: "Lights orange whenever Session clips or manual moves are overriding the timeline. Press it to give control back to the Arrangement.",
                bullets: [
                    "It does not undo anything — it just stops Session clips from taking over playback.",
                    "Also clears overridden automation so the written automation is heard again."
                ]
            )),

            MapElement("detail", CGRect(x: 0, y: 0.63, width: 0.99, height: 0.36), "DETAIL VIEW — device chain / clip editor", role: .device, decorative: true)
        ],
        howToOpen: "Press Tab from Session View."
    )

    // MARK: - Control Bar (zoomed)

    static let controlBar = InterfaceMap(
        id: "live-controlbar",
        daw: .ableton,
        title: "Control Bar",
        subtitle: "Every field in the top strip, left to right",
        aspect: 3.2,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),

            MapElement("link", CGRect(x: 0.01, y: 0.30, width: 0.07, height: 0.40), "LINK", role: .control, detail: ElementDetail(
                title: "Link / Tempo Follower",
                summary: "Ableton Link syncs tempo and phase with other apps and devices on the same network.",
                bullets: [
                    "Turn it on and any other Link-enabled app (including on a phone) shares your tempo.",
                    "The number next to it shows how many peers are connected.",
                    "Tempo Follower (in Live 11+) makes Live's tempo follow an incoming audio signal instead."
                ]
            )),
            MapElement("tap", CGRect(x: 0.09, y: 0.30, width: 0.055, height: 0.40), "TAP", role: .control, detail: ElementDetail(
                title: "Tap Tempo",
                summary: "Click in time four times and Live sets the tempo to your tapping.",
                bullets: ["Map it to a key or MIDI pad and it becomes a live tempo control.", "Tapping while stopped also starts playback in tempo."]
            )),
            MapElement("tempo", CGRect(x: 0.155, y: 0.30, width: 0.08, height: 0.40), "120.00", role: .highlight, detail: ElementDetail(
                title: "Tempo Field",
                summary: "The project tempo in BPM.",
                bullets: [
                    "Drag up/down to change; Shift-drag for decimals; double-click to type.",
                    "Automate it by choosing Master track → Mixer → Song Tempo in an automation lane.",
                    "Scene names containing a number override the tempo when that scene is launched."
                ]
            )),
            MapElement("timesig", CGRect(x: 0.245, y: 0.30, width: 0.06, height: 0.40), "4 / 4", role: .control, detail: ElementDetail(
                title: "Time Signature",
                summary: "Sets the metre used by the metronome, the grid and the ruler.",
                bullets: ["Automatable from the Master track.", "Changing it mid-song is done with time-signature markers in the Arrangement ruler."]
            )),
            MapElement("metro", CGRect(x: 0.315, y: 0.30, width: 0.055, height: 0.40), "MET", role: .control, detail: ElementDetail(
                title: "Metronome",
                summary: "Click track, heard only by you (it never appears in the export).",
                bullets: [
                    "The small arrow next to it opens count-in options: none, 1, 2 or 4 bars before recording starts.",
                    "Also holds Metronome Sound and Rhythm (which subdivision it clicks)."
                ],
                shortcuts: [Shortcut("Cmd+Shift+E", "Toggle metronome (varies by version)")]
            )),

            MapElement("transport", CGRect(x: 0.385, y: 0.25, width: 0.13, height: 0.50), "▶  ■  ●", role: .transport, detail: ElementDetail(
                title: "Transport: Play / Stop / Record",
                summary: "Play starts from the insert marker; Stop halts; Record (the circle) arms global recording.",
                bullets: [
                    "Space bar plays/stops. Pressing Stop twice returns the playhead to the start.",
                    "Shift+Space plays from the last stop position (continue).",
                    "The global Record button in Session View records what you launch into the Arrangement.",
                    "Arrangement Record in Arrangement View records onto armed tracks along the timeline."
                ],
                shortcuts: [
                    Shortcut("Space", "Play / Stop"),
                    Shortcut("F9", "Session Record"),
                    Shortcut("Home", "Playhead to start")
                ]
            )),

            MapElement("position", CGRect(x: 0.525, y: 0.30, width: 0.085, height: 0.40), "1.1.1", role: .control, detail: ElementDetail(
                title: "Arrangement Position",
                summary: "Bar . beat . sixteenth of the playhead. Type into it to jump.",
                bullets: ["The fields to the right are the loop start and loop length in the same format."]
            )),
            MapElement("loopctl", CGRect(x: 0.62, y: 0.30, width: 0.10, height: 0.40), "LOOP  ⟲  1.1.1  4.0.0", role: .transport, detail: ElementDetail(
                title: "Loop Switch + Loop Position/Length",
                summary: "Turns Arrangement looping on, and sets exactly where the loop starts and how long it is.",
                bullets: ["Numeric entry here is more precise than dragging the brace."],
                shortcuts: [Shortcut("Cmd+Shift+L", "Loop on/off")]
            )),
            MapElement("punch", CGRect(x: 0.73, y: 0.30, width: 0.055, height: 0.40), "P.IN/OUT", role: .danger, decorative: true),

            MapElement("quant", CGRect(x: 0.795, y: 0.30, width: 0.07, height: 0.40), "1 BAR", role: .highlight, detail: ElementDetail(
                title: "Global Quantisation",
                summary: "The single most misunderstood control in Live: it decides when a launched clip or scene actually starts.",
                bullets: [
                    "Options: None, 8 / 4 / 2 / 1 Bar, 1/2, 1/4, 1/8, 1/16, plus triplet variants.",
                    "'1 Bar' means clips wait for the next bar line, which is why they feel 'late' when you first use Live.",
                    "Set it to None for instant, sloppy, hands-on launching; set it to 1 Bar for a tidy set."
                ],
                gotcha: "This is separate from Record Quantisation (Edit menu) and from a clip's own Launch Quantisation in Clip View."
            )),
            MapElement("midimap", CGRect(x: 0.875, y: 0.30, width: 0.06, height: 0.40), "MIDI / KEY", role: .midi, detail: ElementDetail(
                title: "MIDI Map and Key Map Mode",
                summary: "Turn either on, click a control in Live, then move a knob (MIDI) or press a key (KEY) to bind it.",
                bullets: [
                    "Mapped controls show a blue (MIDI) or orange (KEY) badge.",
                    "The mapping browser on the left lists everything you've mapped; delete entries there.",
                    "Turn the mode off again to play — while it's on, your keyboard only assigns."
                ],
                shortcuts: [
                    Shortcut("Cmd+M", "MIDI Map Mode"),
                    Shortcut("Cmd+K", "Key Map Mode")
                ]
            )),
            MapElement("cpu", CGRect(x: 0.945, y: 0.30, width: 0.048, height: 0.40), "CPU", role: .meter, detail: ElementDetail(
                title: "CPU Load Meter + Activity LEDs",
                summary: "Live's own processing load, plus MIDI in/out and audio activity indicators.",
                bullets: [
                    "If it climbs past ~70% you'll hear crackles: raise the buffer size in Preferences → Audio, or Freeze tracks.",
                    "The small LEDs flash when MIDI arrives — the fastest way to check a controller is connected.",
                    "The disk-overload light next to it means your drive can't stream samples fast enough."
                ]
            ))
        ],
        howToOpen: "Always visible along the top of the Live window."
    )

    // MARK: - Browser

    static let browser = InterfaceMap(
        id: "live-browser",
        daw: .ableton,
        title: "Browser",
        subtitle: "Where every sound, device and file lives",
        aspect: 0.62,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),
            MapElement("search", CGRect(x: 0.04, y: 0.02, width: 0.92, height: 0.05), "SEARCH  ⌘F", role: .highlight, detail: ElementDetail(
                title: "Browser Search",
                summary: "Types-to-filter across everything Live has indexed.",
                bullets: [
                    "Results are ranked; press ↓ to walk them and Enter to load.",
                    "Search terms are matched against name, tags and folder — 'kick 808' works.",
                    "Esc clears the search and returns to the tree."
                ],
                shortcuts: [Shortcut("Cmd+F", "Focus search")]
            )),
            MapElement("collections", CGRect(x: 0.04, y: 0.09, width: 0.92, height: 0.13), "COLLECTIONS (colour labels)", role: .browser, detail: ElementDetail(
                title: "Collections",
                summary: "Seven colour-coded favourites lists. Right-click any item anywhere → Add to Collection.",
                bullets: [
                    "Rename them (right-click) to things like 'Go-to drums', 'Mix chain', 'Sound design'.",
                    "Number keys 1–7 assign the selected item to a collection instantly."
                ]
            )),
            MapElement("library", CGRect(x: 0.04, y: 0.24, width: 0.92, height: 0.40), "LIBRARY\n\nSounds\nDrums\nInstruments\nAudio Effects\nMIDI Effects\nMax for Live\nPlug-Ins\nClips\nSamples", role: .browser, detail: ElementDetail(
                title: "Library categories",
                summary: "Live's built-in content, sorted by what it does rather than where it lives on disk.",
                bullets: [
                    "Sounds — full instrument presets ready to play.",
                    "Drums — Drum Racks and individual hits.",
                    "Instruments — the raw devices (Operator, Wavetable, Simpler, Drift…), each with presets underneath.",
                    "Audio Effects — EQ, compression, reverb, delay, saturation and the rest.",
                    "MIDI Effects — Arpeggiator, Chord, Scale, Velocity, Note Length: these process notes before the instrument.",
                    "Max for Live — extra devices built in Max (Suite only).",
                    "Plug-Ins — your third-party VST/AU instruments and effects.",
                    "Clips — saved Live clips including their warp and device settings.",
                    "Samples — raw audio files in the library."
                ],
                gotcha: "Third-party plug-ins missing? Preferences → Plug-Ins → rescan, and check the VST folder paths are switched on."
            )),
            MapElement("places", CGRect(x: 0.04, y: 0.66, width: 0.92, height: 0.20), "PLACES\n\nPacks\nUser Library\nCurrent Project\n+ Add Folder…", role: .browser, detail: ElementDetail(
                title: "Places",
                summary: "Folders on your own disk, including your sample library.",
                bullets: [
                    "User Library is where your saved presets, racks, default settings and grooves go.",
                    "Current Project shows what is inside this Live Set's project folder.",
                    "Add Folder points Live at any drive or sample pack — it indexes it for search."
                ]
            )),
            MapElement("preview", CGRect(x: 0.04, y: 0.88, width: 0.92, height: 0.09), "PREVIEW  🔈  ⏻  vol", role: .audio, detail: ElementDetail(
                title: "Preview switch and volume",
                summary: "Auditions the selected file without loading it.",
                bullets: [
                    "The headphone-with-note icon makes previews play in sync with the running set (warped to your tempo).",
                    "Preview volume is separate from the mix; it follows the Cue Out routing."
                ]
            ))
        ],
        howToOpen: "Cmd+Alt+B, or View → Browser."
    )

    // MARK: - Mixer strip

    static let mixer = InterfaceMap(
        id: "live-mixer",
        daw: .ableton,
        title: "Track Mixer Strip",
        subtitle: "Routing, monitoring, sends and the arm button — top to bottom",
        aspect: 0.55,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),
            MapElement("audiofrom", CGRect(x: 0.06, y: 0.03, width: 0.88, height: 0.08), "AUDIO/MIDI FROM  ▾", role: .audio, detail: ElementDetail(
                title: "Input Routing (Audio From / MIDI From)",
                summary: "Two dropdowns: the source, and then the specific channel of that source.",
                bullets: [
                    "Audio tracks: pick your interface (Ext. In) then a channel like '1' or '1/2', or pick another track to record its output.",
                    "MIDI tracks: 'All Ins' listens to every controller; choose a specific device to isolate one.",
                    "'Resampling' records Live's own master output back into the track — the fastest way to bounce a sound.",
                    "Choosing another track as input lets you feed one track into another (sidechain sources, parallel processing)."
                ]
            )),
            MapElement("monitor", CGRect(x: 0.06, y: 0.12, width: 0.88, height: 0.07), "MONITOR:  IN | AUTO | OFF", role: .highlight, detail: ElementDetail(
                title: "Monitor",
                summary: "Decides when the track's input is passed through to its output.",
                bullets: [
                    "In — always hear the input, even during playback of recorded material.",
                    "Auto — hear it only when the track is armed and not playing back a clip. This is the right default.",
                    "Off — never hear the input; use it when your interface gives you direct hardware monitoring."
                ],
                gotcha: "Feedback howl while recording a mic? Monitor is on 'In' with speakers up. Switch to Auto and use headphones."
            )),
            MapElement("audioto", CGRect(x: 0.06, y: 0.20, width: 0.88, height: 0.08), "AUDIO/MIDI TO  ▾", role: .audio, detail: ElementDetail(
                title: "Output Routing (Audio To / MIDI To)",
                summary: "Where this track sends its signal.",
                bullets: [
                    "Master is the default. Send to another track to build a bus manually.",
                    "'Sends Only' removes the track from the main mix so you hear it only through its sends.",
                    "MIDI To lets one MIDI track play another track's instrument — the basis of layering and of MIDI effects chains."
                ]
            )),
            MapElement("sends", CGRect(x: 0.06, y: 0.30, width: 0.88, height: 0.16), "SENDS  A  B  C", role: .device, detail: ElementDetail(
                title: "Send knobs",
                summary: "How much of this track is fed to each Return track.",
                bullets: [
                    "One knob per Return. Turning it up adds that return's effect to the track.",
                    "Pre-fader sends (set on the Return) stay at the same level when you pull the track fader down; post-fader follows the fader.",
                    "Right-click a send → Enable/Disable to bypass it."
                ]
            )),
            MapElement("pan", CGRect(x: 0.06, y: 0.48, width: 0.88, height: 0.08), "PAN  ◀ ● ▶", role: .control, detail: ElementDetail(
                title: "Pan",
                summary: "Left/right placement. Right-click for Split Stereo Pan mode, which gives independent L and R controls.",
                bullets: ["Delete over the knob re-centres it.", "Shift-drag for fine movement."]
            )),
            MapElement("fader", CGRect(x: 0.06, y: 0.58, width: 0.50, height: 0.30), "VOLUME FADER", role: .meter, detail: ElementDetail(
                title: "Volume fader",
                summary: "Track level into its output. 0.0 dB is unity — the fader's default.",
                bullets: [
                    "Shift-drag for fine control; Delete resets to 0 dB.",
                    "Right-click → Show Automation to reveal the volume envelope in the Arrangement.",
                    "The number under it is the current value; type into it for exact levels."
                ]
            )),
            MapElement("meterstrip", CGRect(x: 0.60, y: 0.58, width: 0.34, height: 0.30), "METER", role: .meter, detail: ElementDetail(
                title: "Level meter",
                summary: "Shows the track's output level after the fader.",
                bullets: [
                    "The number at the top holds the peak; click it to reset.",
                    "Red at the top means clipping on that track — pull the fader or the source down."
                ]
            )),
            MapElement("buttons", CGRect(x: 0.06, y: 0.90, width: 0.88, height: 0.07), "  1  ·  S  ·  ○  ·  A|B  ", role: .danger, detail: ElementDetail(
                title: "Activator · Solo · Arm · Crossfade assign",
                summary: "The four small buttons at the bottom of every strip.",
                bullets: [
                    "Activator (the track number) — mute/unmute the track.",
                    "S (Solo) — hear only this track. Cmd/Ctrl-click to solo several. Right-click → 'Solo in Place' vs cue behaviour.",
                    "Arm (the circle) — enable this track for recording. Cmd/Ctrl-click to arm several at once.",
                    "A / B — assign the track to a side of the crossfader on the Master."
                ],
                shortcuts: [Shortcut("0", "Deactivate/activate selected clip or track")]
            ))
        ],
        howToOpen: "Visible in the Session mixer, and along the bottom of Arrangement track headers."
    )

    // MARK: - MIDI Note Editor

    static let midiEditor = InterfaceMap(
        id: "live-midi-editor",
        daw: .ableton,
        title: "MIDI Note Editor",
        subtitle: "Live's piano roll — notes, velocity, grid and scale",
        aspect: 1.9,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),
            MapElement("clipbox", CGRect(x: 0, y: 0, width: 0.20, height: 1), "CLIP BOX\n\nName\nColour\nSignature\nGroove\nLoop / Start / End\nLaunch mode\nQuantisation", role: .control, detail: ElementDetail(
                title: "Clip / Notes / Launch boxes",
                summary: "The left-hand panels of Clip View that control the clip as a whole.",
                bullets: [
                    "Clip box — name, colour, time signature, groove amount, and the Loop switch with Start/End/Position.",
                    "Launch box — Launch Mode (Trigger / Gate / Toggle / Repeat), Quantisation, Legato, Velocity and Follow Actions.",
                    "Follow Actions make a clip automatically fire another clip after n bars — the trick behind generative Session sets.",
                    "Notes box — Bank/Sub-bank and the MIDI transpose/velocity settings."
                ]
            )),
            MapElement("keyboard", CGRect(x: 0.21, y: 0.10, width: 0.055, height: 0.88), "KEYS", role: .midi, detail: ElementDetail(
                title: "Piano / pitch strip",
                summary: "Click a key to hear the instrument; drag it vertically to scroll the note range.",
                bullets: [
                    "The 'Fold' button (top left of the editor) hides every pitch that isn't used in the clip — invaluable for drum racks.",
                    "In a Drum Rack the strip shows pad names instead of note names."
                ]
            )),
            MapElement("notearea", CGRect(x: 0.275, y: 0.10, width: 0.715, height: 0.62), "NOTE AREA — draw / drag / stretch", role: .midi, detail: ElementDetail(
                title: "Note editing area",
                summary: "Where notes live. Double-click empty space to create a note; double-click a note to delete it.",
                bullets: [
                    "Drag a note to move it (snaps to the grid), drag its right edge to change length.",
                    "Marquee-select by dragging in empty space; then transpose with ↑/↓ or move in time with ←/→.",
                    "Shift+↑/↓ moves by an octave. Cmd/Ctrl+↑/↓ nudges by a semitone without snapping to scale.",
                    "Draw Mode (B) paints notes in grid-length steps; hold Alt while drawing to bypass the grid.",
                    "Cmd/Ctrl+U quantises the selection to the current Record Quantisation; Cmd/Ctrl+Shift+U opens the Quantise dialog with strength and swing."
                ],
                actions: [
                    "Right-click empty space for the grid menu, Scale mode, chop and 'Deactivate Note'.",
                    "Cmd+E splits a note; Cmd+J joins."
                ],
                shortcuts: [
                    Shortcut("B", "Draw Mode"),
                    Shortcut("Cmd+U", "Quantise"),
                    Shortcut("Cmd+Shift+U", "Quantise Settings"),
                    Shortcut("0", "Deactivate/activate note"),
                    Shortcut("Cmd+D", "Duplicate loop content")
                ]
            )),
            MapElement("velocity", CGRect(x: 0.275, y: 0.74, width: 0.715, height: 0.24), "VELOCITY / EXPRESSION LANE", role: .highlight, detail: ElementDetail(
                title: "Velocity and expression lanes",
                summary: "The strip under the notes: each stem is one note's velocity.",
                bullets: [
                    "Drag a stem up/down to change velocity; drag across several to draw a ramp.",
                    "The lane chooser also exposes Velocity Deviation, Chance (Live 11+), and per-note Pitch/Slide/Pressure (MPE).",
                    "Chance sets the probability a note fires — great for humanising hats.",
                    "Envelopes tab lets you draw automation for any device parameter inside the clip itself."
                ]
            )),
            MapElement("gridctl", CGRect(x: 0.72, y: 0.015, width: 0.27, height: 0.07), "GRID: 1/16  ·  TRIPLET  ·  ADAPTIVE", role: .control, detail: ElementDetail(
                title: "Grid settings",
                summary: "Right-click anywhere in the editor to set the grid.",
                bullets: [
                    "Adaptive Grid changes resolution as you zoom; Fixed Grid pins it to a value.",
                    "Triplet Grid toggles triplet divisions.",
                    "Snap to Grid off = free placement."
                ],
                shortcuts: [
                    Shortcut("Cmd+1 / Cmd+2", "Narrow / widen grid"),
                    Shortcut("Cmd+3", "Triplet grid"),
                    Shortcut("Cmd+4", "Snap to grid on/off")
                ]
            )),
            MapElement("scale", CGRect(x: 0.21, y: 0.015, width: 0.24, height: 0.07), "FOLD  ·  SCALE  C MINOR", role: .clip, detail: ElementDetail(
                title: "Fold and Scale",
                summary: "Fold hides unused pitches; Scale mode highlights (and optionally forces) the notes of a key.",
                bullets: [
                    "In Live 12, Scale is set for the whole Set and every clip can follow it.",
                    "With Scale on, the piano strip dims out-of-key notes so mistakes are hard to make.",
                    "Right-click a clip → 'Fold to Scale' constrains existing notes to the key."
                ]
            ))
        ],
        howToOpen: "Double-click a MIDI clip, or select it and press Shift+Tab."
    )

    // MARK: - Device chain

    static let deviceChain = InterfaceMap(
        id: "live-device-chain",
        daw: .ableton,
        title: "Device View & Racks",
        subtitle: "Signal flows left to right through the chain",
        aspect: 2.6,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),
            MapElement("dev1", CGRect(x: 0.02, y: 0.12, width: 0.20, height: 0.76), "MIDI EFFECT\nArpeggiator", role: .midi, detail: ElementDetail(
                title: "MIDI Effects",
                summary: "Devices that alter notes before they reach the instrument. They only exist on MIDI tracks and must sit left of the instrument.",
                bullets: [
                    "Arpeggiator — turns held chords into patterns; Rate, Style, Gate, Transpose.",
                    "Chord — stacks intervals on every incoming note.",
                    "Scale — snaps incoming notes into a chosen key.",
                    "Velocity, Note Length, Random, Pitch, CC Control — small utilities that shape performance data."
                ]
            )),
            MapElement("dev2", CGRect(x: 0.24, y: 0.12, width: 0.24, height: 0.76), "INSTRUMENT\nWavetable / Simpler", role: .clip, detail: ElementDetail(
                title: "Instrument",
                summary: "Turns MIDI into audio. Exactly one per MIDI track (unless it's inside a Rack).",
                bullets: [
                    "Simpler — one sample, three playback modes (Classic, One-Shot, Slice). Slice mode chops a loop across a drum pad layout.",
                    "Drum Rack — a 4×4 pad grid, each pad its own chain with its own effects and its own mixer return.",
                    "Wavetable / Operator / Analog / Drift — the synths; each has oscillators, filter, envelopes and an LFO section.",
                    "Every device has a triangle to fold it and a power button to bypass it."
                ],
                shortcuts: [
                    Shortcut("Cmd+G", "Group device(s) into a Rack"),
                    Shortcut("0", "Bypass selected device")
                ]
            )),
            MapElement("dev3", CGRect(x: 0.50, y: 0.12, width: 0.22, height: 0.76), "AUDIO EFFECT\nEQ Eight", role: .device, detail: ElementDetail(
                title: "Audio Effects",
                summary: "Process the audio after the instrument. Order matters — the chain runs strictly left to right.",
                bullets: [
                    "A sensible starting order: corrective EQ → compression → saturation → modulation → delay → reverb.",
                    "Drag a device by its title bar to reorder; Alt-drag to copy it to another track.",
                    "Right-click a device title → Group to wrap it in an Audio Effect Rack."
                ]
            )),
            MapElement("rack", CGRect(x: 0.74, y: 0.12, width: 0.24, height: 0.76), "RACK\n8 MACROS\nchain selector", role: .highlight, detail: ElementDetail(
                title: "Racks and Macro knobs",
                summary: "A Rack wraps several devices into one, exposing up to 16 Macro knobs that can each control many parameters at once.",
                bullets: [
                    "Cmd/Ctrl+G on selected devices creates the Rack.",
                    "Click 'Map' then a parameter to bind it to a Macro; set min/max in the mapping browser to invert or limit range.",
                    "Chains: parallel copies of the signal. The Chain Selector zone lets you switch or blend between them (Instrument/Drum/Effect Racks).",
                    "Variations (Live 11+) store snapshots of all Macro positions — a preset system inside the Rack."
                ]
            )),
            MapElement("hotswap", CGRect(x: 0.02, y: 0.02, width: 0.12, height: 0.08), "HOT-SWAP", role: .control, detail: ElementDetail(
                title: "Hot-Swap",
                summary: "The circular-arrows button on a device. Press it and the Browser filters to presets for that exact device — arrow through them and hear each in place.",
                bullets: [], shortcuts: [Shortcut("Q", "Hot-Swap the selected device")]
            ))
        ],
        howToOpen: "Select a track and press Shift+Tab until the Device View shows."
    )

    // MARK: - Preferences

    static let preferences = InterfaceMap(
        id: "live-preferences",
        daw: .ableton,
        title: "Preferences",
        subtitle: "Every tab, and the settings that actually matter",
        aspect: 1.3,
        elements: [
            MapElement("bg", CGRect(x: 0, y: 0, width: 1, height: 1), "", role: .surface, decorative: true),
            MapElement("tabs", CGRect(x: 0.02, y: 0.05, width: 0.26, height: 0.90), "Look & Feel\nAudio\nLink / Tempo / MIDI\nFile / Folder\nLibrary\nPlug-Ins\nRecord / Warp / Launch\nLicenses / Maintenance", role: .browser, detail: ElementDetail(
                title: "The tab list",
                summary: "Eight pages. You will live in Audio, Plug-Ins and Record/Warp/Launch.",
                bullets: []
            )),
            MapElement("audio", CGRect(x: 0.30, y: 0.05, width: 0.68, height: 0.42), "AUDIO\n\nDriver Type · Audio Device\nSample Rate · Buffer Size\nInput/Output Config\nLatency", role: .audio, detail: ElementDetail(
                title: "Audio tab",
                summary: "Your interface, sample rate and buffer size — set this before anything else.",
                bullets: [
                    "Driver Type: CoreAudio on macOS; ASIO on Windows (install your interface's ASIO driver, or ASIO4ALL as a fallback).",
                    "Sample Rate: 44100 or 48000 Hz. Match whatever the project will be delivered at and leave it alone.",
                    "Buffer Size: small (64–128) while recording for low latency, large (512–1024) while mixing to save CPU.",
                    "Input/Output Config: switch on the physical channel pairs you actually want to appear in the routing menus.",
                    "Overall Latency is shown at the bottom — that's the round-trip you'll feel when playing."
                ],
                gotcha: "Crackles and pops are almost always buffer size, not a broken plug-in. Raise the buffer first."
            )),
            MapElement("plugins", CGRect(x: 0.30, y: 0.49, width: 0.33, height: 0.22), "PLUG-INS\n\nVST2/VST3 folders\nAU on/off\nRescan", role: .device, detail: ElementDetail(
                title: "Plug-Ins tab",
                summary: "Where Live looks for third-party instruments and effects.",
                bullets: [
                    "Switch on Audio Units (macOS) and/or VST2/VST3, then set custom folders if your plug-ins live somewhere unusual.",
                    "'Rescan' after installing anything new.",
                    "Plug-in Window options here control whether editors auto-open and auto-hide."
                ]
            )),
            MapElement("record", CGRect(x: 0.65, y: 0.49, width: 0.33, height: 0.22), "RECORD / WARP / LAUNCH", role: .highlight, detail: ElementDetail(
                title: "Record / Warp / Launch tab",
                summary: "Defaults for how new recordings and new clips behave.",
                bullets: [
                    "File Type and Bit Depth for recordings (WAV 24-bit is the sane default).",
                    "Count-in before recording.",
                    "Auto-Warp Long Samples — whether dropped files are stretched to project tempo.",
                    "Default Warp Mode: Beats for drums, Complex Pro for full mixes and vocals.",
                    "Create Fades on Clip Edges — 4 ms fades that stop clicks.",
                    "Default Launch Mode and Quantisation for new clips."
                ]
            )),
            MapElement("filefolder", CGRect(x: 0.30, y: 0.73, width: 0.33, height: 0.22), "FILE / FOLDER\n\nSample cache\nDecoding\nCollect on Export", role: .browser, detail: ElementDetail(
                title: "File / Folder tab",
                summary: "Where temporary and project files go, plus sample management.",
                bullets: [
                    "Decoding & Web Cache — clear it when your disk fills up.",
                    "'Collect Files on Export' controls whether saved sets copy their samples into the project folder.",
                    "Max Cache Size sets how much analysed audio Live keeps."
                ]
            )),
            MapElement("linkmidi", CGRect(x: 0.65, y: 0.73, width: 0.33, height: 0.22), "LINK / TEMPO / MIDI\n\nControl surfaces\nTrack · Sync · Remote", role: .midi, detail: ElementDetail(
                title: "Link / Tempo / MIDI tab",
                summary: "Controllers and MIDI ports.",
                bullets: [
                    "Control Surface slots: pick your controller here for automatic mapping (Push, Launchpad, MPK, etc.).",
                    "The MIDI Ports table has three switches per port — Track (note/CC data in or out), Sync (MIDI clock), Remote (mapping to Live's controls).",
                    "A controller that plays notes but won't map: turn on 'Remote'. One that maps but won't play: turn on 'Track'."
                ],
                gotcha: "This table is the answer to most 'my controller doesn't work' problems."
            ))
        ],
        howToOpen: "Cmd+, on macOS · Ctrl+, on Windows · Live → Preferences / Options → Preferences."
    )
}
