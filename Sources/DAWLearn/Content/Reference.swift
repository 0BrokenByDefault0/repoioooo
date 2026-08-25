import Foundation

struct ShortcutGroup: Identifiable {
    let id = UUID()
    let daw: DAW
    let title: String
    let items: [Shortcut]
}

enum Reference {

    /// Live's shortcuts are written with Cmd; on Windows substitute Ctrl (and Alt for Option).
    static let shortcutGroups: [ShortcutGroup] = [

        ShortcutGroup(daw: .ableton, title: "Views & windows", items: [
            Shortcut("Tab", "Session ⇄ Arrangement"),
            Shortcut("Shift+Tab", "Clip View ⇄ Device View"),
            Shortcut("Cmd+Alt+B", "Show/hide Browser"),
            Shortcut("Cmd+Alt+L", "Show/hide Detail View"),
            Shortcut("Cmd+Alt+M", "Show/hide Mixer"),
            Shortcut("Cmd+Alt+I", "Show/hide In/Out"),
            Shortcut("Cmd+Alt+S", "Show/hide Sends"),
            Shortcut("Cmd+Shift+W", "Second Window"),
            Shortcut("Cmd+Ctrl+F", "Full screen"),
            Shortcut("Shift+/", "Show/hide Help View")
        ]),

        ShortcutGroup(daw: .ableton, title: "Transport & recording", items: [
            Shortcut("Space", "Play / Stop"),
            Shortcut("Shift+Space", "Continue from stop position"),
            Shortcut("Home", "Playhead to start"),
            Shortcut("F9", "Session Record"),
            Shortcut("Cmd+Shift+C", "Capture MIDI", note: "Retroactively grabs what you just played"),
            Shortcut("Cmd+Shift+L", "Loop on/off"),
            Shortcut("Cmd+L", "Set loop to selection"),
            Shortcut("Cmd+M", "MIDI Map Mode"),
            Shortcut("Cmd+K", "Key Map Mode"),
            Shortcut("M", "Computer MIDI keyboard on/off")
        ]),

        ShortcutGroup(daw: .ableton, title: "Editing", items: [
            Shortcut("Cmd+D", "Duplicate"),
            Shortcut("Cmd+E", "Split at insert marker"),
            Shortcut("Cmd+J", "Consolidate"),
            Shortcut("Cmd+U", "Quantise"),
            Shortcut("Cmd+Shift+U", "Quantise settings"),
            Shortcut("Cmd+G", "Group tracks / devices"),
            Shortcut("0", "Deactivate (mute) clip, note or device"),
            Shortcut("Cmd+R", "Rename"),
            Shortcut("B", "Draw Mode"),
            Shortcut("A", "Automation Mode"),
            Shortcut("Q", "Hot-Swap"),
            Shortcut("Cmd+1 / Cmd+2", "Narrow / widen grid"),
            Shortcut("Cmd+3", "Triplet grid"),
            Shortcut("Cmd+4", "Snap to grid on/off"),
            Shortcut("Alt+drag", "Copy · or bypass snap · or curve automation")
        ]),

        ShortcutGroup(daw: .ableton, title: "Tracks & clips", items: [
            Shortcut("Cmd+T", "Insert Audio Track"),
            Shortcut("Cmd+Shift+T", "Insert MIDI Track"),
            Shortcut("Cmd+Alt+T", "Insert Return Track"),
            Shortcut("Cmd+Shift+I", "Insert Scene"),
            Shortcut("Enter", "Launch selected clip or scene"),
            Shortcut("Cmd+Shift+R", "Export Audio/Video"),
            Shortcut("Cmd+S", "Save Set"),
            Shortcut("+ / −", "Zoom in / out")
        ]),

        ShortcutGroup(daw: .fl, title: "Windows", items: [
            Shortcut("F5", "Playlist"),
            Shortcut("F6", "Channel Rack"),
            Shortcut("F7", "Piano Roll"),
            Shortcut("F8", "Browser / Plugin Picker"),
            Shortcut("F9", "Mixer"),
            Shortcut("F10", "Settings"),
            Shortcut("F11", "Song info"),
            Shortcut("F12", "Close all windows"),
            Shortcut("Ctrl+Shift+H", "Arrange windows")
        ]),

        ShortcutGroup(daw: .fl, title: "Transport & modes", items: [
            Shortcut("Space", "Play / Pause"),
            Shortcut("Ctrl+Space", "Play from start"),
            Shortcut("L", "Pattern ⇄ Song mode"),
            Shortcut("R", "Record on/off"),
            Shortcut("Ctrl+M", "Metronome"),
            Shortcut("Ctrl+P", "Count-in before recording"),
            Shortcut("Ctrl+T", "Typing keyboard to piano", note: "Turns QWERTY into a piano — and disables normal shortcuts"),
            Shortcut("Ctrl+E", "Toggle step edit mode")
        ]),

        ShortcutGroup(daw: .fl, title: "Patterns & clips", items: [
            Shortcut("F4", "Next empty pattern"),
            Shortcut("+ / −", "Next / previous pattern"),
            Shortcut("Ctrl+B", "Duplicate selection to the right"),
            Shortcut("Alt+drag", "Copy a clip · or bypass snapping"),
            Shortcut("Ctrl+C / Ctrl+V", "Copy / paste"),
            Shortcut("Ctrl+Z / Ctrl+Shift+Z", "Undo / redo"),
            Shortcut("Ctrl+Alt+Z", "Undo history")
        ]),

        ShortcutGroup(daw: .fl, title: "Tools (Playlist & Piano Roll)", items: [
            Shortcut("P", "Draw / pencil"),
            Shortcut("B", "Paint / brush"),
            Shortcut("E", "Select"),
            Shortcut("C", "Slice"),
            Shortcut("D", "Delete"),
            Shortcut("T", "Mute"),
            Shortcut("Z", "Zoom"),
            Shortcut("Y", "Playback")
        ]),

        ShortcutGroup(daw: .fl, title: "Piano Roll editing", items: [
            Shortcut("Ctrl+Q", "Quick quantise"),
            Shortcut("Ctrl+L", "Quick legato"),
            Shortcut("Ctrl+A", "Select all"),
            Shortcut("Alt+↑ / ↓", "Transpose by semitone"),
            Shortcut("Ctrl+↑ / ↓", "Transpose by octave"),
            Shortcut("Ctrl+←/→", "Nudge in time"),
            Shortcut("Shift+drag", "Copy the selection"),
            Shortcut("Ctrl+R", "Export WAV"),
            Shortcut("Ctrl+S", "Save project")
        ])
    ]

    static let glossary: [GlossaryEntry] = [
        GlossaryEntry(term: "BPM", definition: "Beats per minute — the project tempo. 120 BPM means two beats every second."),
        GlossaryEntry(term: "Bar", definition: "A group of beats, four by default. Almost all arrangement lengths are counted in bars: 8, 16, 32.", alsoCalled: "Measure"),
        GlossaryEntry(term: "Quantise", definition: "Snap notes to the nearest grid division. 100% is machine-tight; less keeps some of your feel."),
        GlossaryEntry(term: "Swing", definition: "Delaying every second subdivision so the rhythm lilts instead of marching."),
        GlossaryEntry(term: "Velocity", definition: "How hard a MIDI note was struck, 0–127. Most instruments map it to volume and brightness."),
        GlossaryEntry(term: "MIDI", definition: "A control protocol: notes, velocities, timing and controller movements. Not audio — it makes no sound until an instrument plays it."),
        GlossaryEntry(term: "Sample rate", definition: "How many times per second the audio is measured. 44.1 kHz is CD standard; 48 kHz is video standard."),
        GlossaryEntry(term: "Bit depth", definition: "The resolution of each measurement. 24-bit for working, 16-bit for final delivery."),
        GlossaryEntry(term: "Buffer size", definition: "How much audio the computer prepares at once. Bigger = safer but more latency."),
        GlossaryEntry(term: "Latency", definition: "The delay between doing something and hearing it. Under ~10 ms feels immediate."),
        GlossaryEntry(term: "PDC", definition: "Plug-in Delay Compensation — the DAW delaying other tracks so a slow plug-in stays in sync."),
        GlossaryEntry(term: "Gain staging", definition: "Keeping levels sensible at every stage so nothing clips and every plug-in gets the input it expects."),
        GlossaryEntry(term: "Headroom", definition: "The space between your loudest peak and 0 dBFS. Leave 6 dB while producing."),
        GlossaryEntry(term: "Clipping", definition: "Signal exceeding 0 dBFS and being truncated. Sounds like crunch, and it is permanent once rendered."),
        GlossaryEntry(term: "dBFS", definition: "Decibels relative to full scale. 0 is the maximum a digital system can represent; everything else is negative."),
        GlossaryEntry(term: "LUFS", definition: "A loudness measurement that matches how loud something actually sounds. Streaming services normalise to around −14 LUFS."),
        GlossaryEntry(term: "Bus", definition: "A channel that several other channels feed into, so you can process them together."),
        GlossaryEntry(term: "Send / Return", definition: "Feeding a copy of a track to a shared effect. The send knob sets how much; the return holds the effect."),
        GlossaryEntry(term: "Insert effect", definition: "An effect in the direct path of a channel — everything goes through it."),
        GlossaryEntry(term: "Dry / Wet", definition: "The balance between the untreated and treated signal."),
        GlossaryEntry(term: "Sidechain", definition: "Using one signal to control an effect on another — classically, the kick ducking the bass."),
        GlossaryEntry(term: "Compressor", definition: "Turns down whatever is louder than the threshold, by the ratio, with attack and release timing."),
        GlossaryEntry(term: "Limiter", definition: "A compressor with a very high ratio, used to stop peaks from exceeding a ceiling."),
        GlossaryEntry(term: "EQ", definition: "Boosting or cutting specific frequency ranges."),
        GlossaryEntry(term: "Filter", definition: "An EQ shape that removes everything above (low-pass) or below (high-pass) a cutoff frequency."),
        GlossaryEntry(term: "Cutoff / Resonance", definition: "Where a filter starts working, and how much it emphasises that point."),
        GlossaryEntry(term: "ADSR", definition: "Attack, Decay, Sustain, Release — the shape of a sound's level (or filter, or pitch) over the life of a note."),
        GlossaryEntry(term: "LFO", definition: "Low Frequency Oscillator — a slow wave used to move a parameter automatically."),
        GlossaryEntry(term: "Oscillator", definition: "The part of a synth that generates the raw waveform."),
        GlossaryEntry(term: "Polyphony", definition: "How many notes an instrument can sound at once. Mono = one, and lets you use glides."),
        GlossaryEntry(term: "One-shot", definition: "A sample that plays through once, ignoring note length. Right for drum hits."),
        GlossaryEntry(term: "Warping", definition: "Stretching audio to follow the project tempo.", daw: .ableton),
        GlossaryEntry(term: "Warp marker", definition: "A pin that ties a moment of audio to a moment on the grid.", daw: .ableton),
        GlossaryEntry(term: "Scene", definition: "A row of clips in Session View, launched together.", daw: .ableton),
        GlossaryEntry(term: "Rack", definition: "A container of parallel device chains with Macro knobs on the front.", daw: .ableton),
        GlossaryEntry(term: "Macro", definition: "A knob on a Rack that controls many parameters at once.", daw: .ableton),
        GlossaryEntry(term: "Follow Action", definition: "A rule that makes one Session clip automatically launch another.", daw: .ableton),
        GlossaryEntry(term: "Freeze", definition: "Rendering a track's devices to audio temporarily to save CPU.", daw: .ableton),
        GlossaryEntry(term: "Resampling", definition: "Recording the DAW's own output back into a track.", daw: .ableton),
        GlossaryEntry(term: "Pattern", definition: "A block of note and automation data spanning every channel.", daw: .fl),
        GlossaryEntry(term: "Channel", definition: "One sound source in the Channel Rack.", daw: .fl),
        GlossaryEntry(term: "Insert", definition: "One mixer strip. Channels are routed to inserts by number.", daw: .fl),
        GlossaryEntry(term: "Automation clip", definition: "A clip on the Playlist that draws a parameter's value over time.", daw: .fl),
        GlossaryEntry(term: "Ghost notes", definition: "Other channels' notes shown greyed out behind the ones you're editing.", daw: .fl),
        GlossaryEntry(term: "Smart disable", definition: "Idling a plug-in when it isn't producing sound, to save CPU.", daw: .fl),
        GlossaryEntry(term: "Make unique", definition: "Detaching one Playlist clip from the pattern it references so it can be edited alone.", daw: .fl),
        GlossaryEntry(term: "Slicex / Edison", definition: "FL's slicer and its audio editor/recorder.", daw: .fl),
        GlossaryEntry(term: "Stem", definition: "One track (or group) rendered to its own audio file, for mixing elsewhere."),
        GlossaryEntry(term: "Bounce / Render", definition: "Writing what you hear to an audio file."),
        GlossaryEntry(term: "Dither", definition: "Tiny noise added when reducing bit depth, to avoid distortion. Apply once, at the very end.")
    ]
}
