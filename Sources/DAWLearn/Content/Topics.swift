import Foundation

enum Topics {

    static let all: [Topic] = shared + ableton + fl

    // MARK: - Applies to both

    static let shared: [Topic] = [

        Topic(
            id: "signal-flow",
            daw: nil,
            title: "How a DAW actually works",
            blurb: "The mental model that makes every button make sense.",
            sections: [
                .init(heading: "The chain", body: "Every DAW is the same pipeline. Learn it once and both programs stop being mysterious.", flow: ["MIDI note", "Instrument", "Insert FX", "Channel fader", "Bus / mixer", "Master", "Speakers"]),
                .init(heading: "Two kinds of data", bullets: [
                    "MIDI is instructions: which note, how hard, how long. It makes no sound by itself.",
                    "Audio is the actual waveform. Once something is audio, notes can't be changed — only processed.",
                    "An instrument converts MIDI into audio. Everything after that point is audio."
                ]),
                .init(heading: "Where the two DAWs differ", bullets: [
                    "Live: a track holds its own device chain, and a mixer strip is part of the track.",
                    "FL: channels (sound sources) and mixer inserts (processing) are separate things you connect with a number.",
                    "Live's Return tracks are pre-made send busses; in FL any insert can become one."
                ]),
                .init(heading: "Why order matters", body: "Effects process in series, left-to-right (Live) or top-to-bottom (FL). A compressor before an EQ reacts to the un-EQ'd sound; after it, it reacts to the EQ'd sound. Neither is wrong — but knowing which you have is the difference between mixing and guessing.")
            ]
        ),

        Topic(
            id: "levels",
            daw: nil,
            title: "Gain staging and levels",
            blurb: "Why your mix sounds worse the louder it gets.",
            sections: [
                .init(heading: "The target", bullets: [
                    "Individual tracks: peaks around −12 dB.",
                    "Master while producing: peaks around −6 dB.",
                    "Final master: −1 dB true peak, loudness to taste (−14 to −8 LUFS integrated depending on genre)."
                ]),
                .init(heading: "Digital clipping", body: "0 dBFS is a hard ceiling. Past it, samples are simply truncated and you get crunch — not the pleasant analogue kind. A red master meter in either DAW means the export will be distorted.", warning: "Turning the master fader down after clipping inside a plug-in does not fix it. Fix the level going in."),
                .init(heading: "Practical routine", bullets: [
                    "Set rough levels with faders before adding a single effect.",
                    "Trim the input of each plug-in rather than reaching for the fader afterwards.",
                    "Mix at a quiet monitoring level; loud makes everything sound good.",
                    "Leave the master fader at 0 dB and control the mix with the tracks."
                ])
            ]
        ),

        Topic(
            id: "latency",
            daw: nil,
            title: "Latency, buffers and why it crackles",
            blurb: "One setting explains most audio problems in both programs.",
            sections: [
                .init(heading: "What the buffer does", body: "The computer prepares audio in chunks. A bigger chunk gives it more time (fewer dropouts) but you hear the result later (more latency). That is the whole trade-off."),
                .init(heading: "Rules of thumb", bullets: [
                    "Recording or playing an instrument: 64–128 samples.",
                    "Mixing a big project: 512–1024 samples.",
                    "Crackles, pops and stutters: raise the buffer first, always.",
                    "Sluggish feel when playing: lower the buffer, or freeze/disable heavy plug-ins."
                ]),
                .init(heading: "Plug-in delay compensation", body: "Some plug-ins (linear-phase EQs, lookahead limiters) need time to work. The DAW delays every other track to match, which is why a project can suddenly feel laggy after adding one plug-in. Both DAWs let you see and manage this: Live compensates automatically (Options → Delay Compensation); FL exposes PDC per plug-in in the wrapper's Processing page."),
                .init(heading: "Windows specifics", bullets: [
                    "Use a real ASIO driver. WDM/DirectSound drivers add tens of milliseconds.",
                    "FL Studio ASIO works with any hardware and is a good default.",
                    "ASIO4ALL is a last resort, not a first choice."
                ])
            ]
        ),

        Topic(
            id: "translate",
            daw: nil,
            title: "Ableton ⇄ FL Studio translation table",
            blurb: "The same concept, two vocabularies.",
            difficulty: .core,
            sections: [
                .init(heading: "Containers", bullets: [
                    "Live 'Clip' ≈ FL 'Pattern clip' or 'Audio clip'.",
                    "Live 'Scene' ≈ FL 'Performance mode row' (roughly).",
                    "Live 'Arrangement View' ≈ FL 'Playlist'.",
                    "Live 'Session View' ≈ FL 'Performance mode'.",
                    "Live 'Set' (.als) ≈ FL 'Project' (.flp)."
                ]),
                .init(heading: "Sound sources", bullets: [
                    "Live 'Track' ≈ FL 'Channel' + a Mixer insert.",
                    "Live 'Drum Rack' ≈ FL 'Channel Rack with one channel per drum' (or FPC).",
                    "Live 'Simpler' ≈ FL 'Sampler channel'; 'Sampler' ≈ 'DirectWave'.",
                    "Live 'Slice mode' ≈ FL 'Slicex'."
                ]),
                .init(heading: "Mixing", bullets: [
                    "Live 'Return track' ≈ FL 'an insert used as a send'.",
                    "Live 'Send knob' ≈ FL 'send knob under the routing arrow'.",
                    "Live 'Master' ≈ FL 'Master insert'.",
                    "Live 'Freeze' ≈ FL 'Consolidate / render to audio clip'."
                ]),
                .init(heading: "Editing", bullets: [
                    "Live 'MIDI Note Editor' ≈ FL 'Piano Roll'.",
                    "Live 'Quantise (Cmd+U)' ≈ FL 'Quick quantise (Ctrl+Q)'.",
                    "Live 'Automation lane' ≈ FL 'Automation clip'.",
                    "Live 'Warping' ≈ FL 'Time stretching / stretch modes'.",
                    "Live 'Groove Pool' ≈ FL 'Swing knob + groove templates'."
                ])
            ]
        ),

        Topic(
            id: "which-daw",
            daw: nil,
            title: "Which one should you actually use?",
            blurb: "An honest comparison, not a fan post.",
            difficulty: .core,
            sections: [
                .init(heading: "FL Studio is better at", bullets: [
                    "The Piano Roll — genuinely the best note editor in any DAW.",
                    "Fast pattern-based beat making; the step sequencer is immediate.",
                    "Price: lifetime free updates.",
                    "Getting a loop going in five minutes with zero setup."
                ]),
                .init(heading: "Ableton Live is better at", bullets: [
                    "Live performance and improvisation (Session View has no real equivalent).",
                    "Audio warping and working with recorded material.",
                    "Consistent, predictable routing and a tidier mental model.",
                    "Hardware integration (Push, and Max for Live for anything custom)."
                ]),
                .init(heading: "Honest verdict", body: "Both make finished records; neither has a sound. Pick the one whose workflow annoys you less and spend the saved time learning it properly. If you're beat-first, start in FL. If you're jam-first or record real instruments, start in Live."),
                .init(heading: "Moving between them", bullets: [
                    "MIDI exports/imports cleanly both ways.",
                    "Audio stems are the universal exchange format — render stems from one, drag into the other.",
                    "Project files are not interchangeable and never will be."
                ])
            ]
        )
    ]

    // MARK: - Ableton

    static let ableton: [Topic] = [

        Topic(
            id: "live-two-views",
            daw: .ableton,
            title: "Session vs Arrangement",
            blurb: "The idea Live is built around.",
            sections: [
                .init(heading: "Same set, two lenses", body: "Session and Arrangement show the same tracks and devices. Session is a grid with no timeline: clips wait to be launched. Arrangement is a timeline: clips happen at a fixed time. Tab switches between them."),
                .init(heading: "Who wins", bullets: [
                    "Launching any Session clip takes control of that track away from the Arrangement.",
                    "The 'Back to Arrangement' button lights orange when that has happened; pressing it returns control.",
                    "Nothing is lost either way — the Arrangement's clips are still there."
                ]),
                .init(heading: "Moving material between them", bullets: [
                    "Session → Arrangement: press the global Record button and perform.",
                    "Arrangement → Session: select a time range, right-click → Consolidate Time to New Scene.",
                    "Drag-and-drop works too, one clip at a time."
                ]),
                .init(heading: "Which to write in", body: "Most people sketch in Session (where repetition is free) and finish in Arrangement (where structure matters). There is no rule; plenty of people never open Session at all.")
            ]
        ),

        Topic(
            id: "live-quantisation",
            daw: .ableton,
            title: "The three quantisations",
            blurb: "They are different settings and they trip up everyone.",
            difficulty: .core,
            sections: [
                .init(heading: "1 — Global Quantisation", body: "The Control Bar dropdown (default '1 Bar'). Decides when a launched clip or scene actually starts. Nothing to do with note timing.", shortcuts: [Shortcut("Cmd+7 … Cmd+0", "Cycle global quantisation values (version-dependent)")]),
                .init(heading: "2 — Record Quantisation", body: "Edit menu → Record Quantisation. Snaps notes as you record them. Set to 'Sixteenth Note' for tidy takes, 'None' if you want your real feel."),
                .init(heading: "3 — Clip Launch Quantisation", body: "In each clip's Launch box. Overrides the global setting for that one clip — useful for a one-shot that must fire instantly inside an otherwise bar-quantised set."),
                .init(heading: "And then quantising after the fact", body: "Cmd+U applies the Record Quantisation value to selected notes. Cmd+Shift+U opens the dialog with Amount (strength, so you can go 50% toward the grid) and swing.", warning: "Quantising to 100% removes groove. Try 60–80% amount before assuming the take was bad.")
            ]
        ),

        Topic(
            id: "live-warp-modes",
            daw: .ableton,
            title: "Warp modes, chosen properly",
            blurb: "Which algorithm for which material.",
            difficulty: .builds,
            sections: [
                .init(heading: "The modes", bullets: [
                    "Beats — drums and percussive loops. Preserve at 1/16 or transients; Transient Loop Mode controls what fills the gaps when slowed down.",
                    "Tones — monophonic pitched material: a bassline, a solo vocal, a lead.",
                    "Texture — pads, noise, atmospheres. Grain Size and Flux are the character controls.",
                    "Re-Pitch — no stretching at all; speed changes pitch, like a turntable. Best for classic sampling sounds.",
                    "Complex — full mixes and complicated material.",
                    "Complex Pro — the best (and heaviest) for vocals and full mixes; Formants and Envelope controls."
                ]),
                .init(heading: "Warp markers", bullets: [
                    "Double-click a transient marker to promote it to a warp marker (yellow).",
                    "Drag a warp marker to pin that moment of audio to that moment in time.",
                    "Right-click → Warp From Here (Straight) assumes a steady tempo from that point.",
                    "Right-click → Warp as X-Bar Loop when you know the loop length."
                ]),
                .init(heading: "Don't warp", body: "One-shots, single hits and anything already at the project tempo. Warping adds artefacts for no benefit. Switch Warp off in the Sample box.")
            ]
        ),

        Topic(
            id: "live-racks",
            daw: .ableton,
            title: "Racks, chains and macros",
            blurb: "Live's most powerful and least understood feature.",
            difficulty: .deep,
            sections: [
                .init(heading: "What a Rack is", body: "A container holding one or more parallel chains of devices, with up to 16 Macro knobs on the front. Cmd+G on selected devices makes one."),
                .init(heading: "The four types", bullets: [
                    "Instrument Rack — parallel instruments (layering).",
                    "Drum Rack — a 4×4 pad grid; each pad is a chain with its own output and its own return chains.",
                    "Audio Effect Rack — parallel effect chains, e.g. a dry path and a heavily filtered path.",
                    "MIDI Effect Rack — parallel note processing."
                ]),
                .init(heading: "Macros", bullets: [
                    "Click 'Map', then click any parameter inside the Rack to bind it.",
                    "One Macro can control many parameters at once, each with its own min/max range.",
                    "Reversing min and max inverts the parameter — that's how one knob opens one filter while closing another.",
                    "Macro Variations (Live 11+) save snapshots of all knob positions."
                ]),
                .init(heading: "Zones", bullets: [
                    "Chain Selector — chains only play in their assigned zone of a 0–127 range; move the selector to crossfade between them.",
                    "Key Zone — chains respond only to a range of notes (splits).",
                    "Velocity Zone — chains respond only to a velocity range (soft/hard layers)."
                ])
            ]
        ),

        Topic(
            id: "live-routing",
            daw: .ableton,
            title: "Routing and resampling",
            blurb: "Getting sound from anywhere to anywhere.",
            difficulty: .builds,
            sections: [
                .init(heading: "The four dropdowns", bullets: [
                    "Audio/MIDI From — source, then which channel of it.",
                    "Monitor — In / Auto / Off.",
                    "Audio/MIDI To — destination, then which input point of it.",
                    "Every track can be a source or destination for any other."
                ]),
                .init(heading: "Resampling", body: "Set an audio track's input to 'Resampling' and it records Live's master output. Arm it, hit record, and you've bounced whatever is playing — with all its effects — into a new audio clip."),
                .init(heading: "Feeding one track into another", bullets: [
                    "Set track B's Audio From to track A, and choose the tap point: Pre FX, Post FX or Post Mixer.",
                    "Pre FX takes the raw signal before A's devices; Post Mixer takes it after the fader and pan.",
                    "This is how you build parallel processing, sidechain sources and manual busses."
                ]),
                .init(heading: "MIDI routing", body: "A MIDI track's MIDI To can point at another MIDI track's instrument. Combined with MIDI effects, this lets one keyboard part drive several instruments with different arpeggiators — without duplicating the notes.")
            ]
        ),

        Topic(
            id: "live-menus",
            daw: .ableton,
            title: "Menu-by-menu reference",
            blurb: "What actually lives under each menu.",
            difficulty: .deep,
            sections: [
                .init(heading: "File", bullets: [
                    "New / Open / Open Recent · Save / Save As / Save a Copy.",
                    "Collect All and Save — copies used samples into the project.",
                    "Export Audio/Video (Cmd+Shift+R) · Export MIDI Clip.",
                    "Manage Files — find missing samples, clean unused ones, see what the project uses."
                ]),
                .init(heading: "Edit", bullets: [
                    "Undo / Redo (Live keeps a deep history) · Cut / Copy / Paste / Duplicate.",
                    "Delete Time / Insert Time — the ripple edits that shift everything after them.",
                    "Record Quantisation submenu.",
                    "Deactivate (0) — mutes a clip, note or device without deleting it."
                ]),
                .init(heading: "Create", bullets: [
                    "Insert Audio / MIDI / Return Track · Insert Scene · Capture and Insert Scene.",
                    "Add Locator — named markers on the Arrangement timeline."
                ]),
                .init(heading: "View", bullets: [
                    "Toggle Browser, Detail View, Mixer, In/Out, Sends, Returns, Video Window.",
                    "Second Window (Cmd+Shift+W) — Session on one screen, Arrangement on the other.",
                    "Full Screen (Cmd+Ctrl+F)."
                ]),
                .init(heading: "Options", bullets: [
                    "Edit MIDI Map / Edit Key Map.",
                    "Computer MIDI Keyboard (M) — play notes from QWERTY.",
                    "Reduced Latency When Monitoring · Delay Compensation.",
                    "Solo/Cue behaviour · Time Ruler Format."
                ]),
                .init(heading: "Help", bullets: [
                    "Built-in Lessons — genuinely good, and they run inside a real Set.",
                    "Help View (the info text at the bottom-left) explains whatever you hover. Toggle with Shift+/."
                ])
            ]
        )
    ]

    // MARK: - FL Studio

    static let fl: [Topic] = [

        Topic(
            id: "fl-patterns",
            daw: .fl,
            title: "Patterns, channels and clips",
            blurb: "The model that makes FL click.",
            sections: [
                .init(heading: "The three layers", flow: ["Channel (a sound)", "Pattern (notes across all channels)", "Playlist clip (a pattern placed in time)"]),
                .init(heading: "What a pattern really is", body: "A pattern is not 'a drum loop for the drum channel'. It is a slice of note and automation data across every channel in the project. If you put your bass notes in the same pattern as your drums, you cannot arrange them separately — which is why the standard advice is one pattern per part."),
                .init(heading: "Clips reference patterns", bullets: [
                    "Placing a pattern on the Playlist creates a reference, not a copy.",
                    "Editing the pattern changes every clip that references it.",
                    "Right-click → 'Make unique' when you want one instance to diverge.",
                    "This is the opposite of Ableton, where each clip is its own data."
                ]),
                .init(heading: "PAT vs SONG", body: "PAT mode plays the selected pattern, ignoring the Playlist. SONG mode plays the Playlist. Nearly every 'why can't I hear anything' moment is this switch.", warning: "Empty playlist + SONG mode = silence. Selected empty pattern + PAT mode = silence.")
            ]
        ),

        Topic(
            id: "fl-mixer-model",
            daw: .fl,
            title: "The mixer routing model",
            blurb: "Inserts, arrows and why there are no return tracks.",
            difficulty: .builds,
            sections: [
                .init(heading: "Channels connect to inserts by number", body: "A channel's FX number says which mixer insert its audio lands on. 0 means straight to Master. Several channels can share an insert; a channel can only go to one."),
                .init(heading: "Every insert is a bus", bullets: [
                    "Select an insert, then click the routing arrow under another insert to send to it.",
                    "The knob above the arrow sets send level.",
                    "Switch off the source's Master arrow to make it send-only.",
                    "A drum bus, a reverb send and a parallel compression path are all the same mechanism."
                ]),
                .init(heading: "Sidechain routing", body: "Right-click a routing arrow → 'Sidechain to this track'. The source becomes an available sidechain input for compressors on the destination. The audio is not mixed in; it's only used for detection."),
                .init(heading: "Practical layout", bullets: [
                    "Inserts 1–10: individual drums. 11–20: instruments. 21+: busses and sends.",
                    "Name (F2) and colour every insert you use.",
                    "Ctrl+L on selected channels auto-assigns them to free inserts."
                ])
            ]
        ),

        Topic(
            id: "fl-channel-settings",
            daw: .fl,
            title: "Channel settings: SMP, INS, MISC, FUNC",
            blurb: "The four tabs behind every sampler channel.",
            difficulty: .deep,
            sections: [
                .init(heading: "SMP (Sample)", bullets: [
                    "The file, plus Loop settings and the 'Keep on disk' switch for large files.",
                    "Time stretching: mode (Auto, Resample, e3 Generic, Slice stretch, Stretch…), tempo and pitch.",
                    "Precomputed effects: reverse, fade in/out, normalise, remove DC offset, POGO, trim.",
                    "Set the stretch mode before dropping loops in — 'Auto' handles most things."
                ]),
                .init(heading: "INS (Instrument)", bullets: [
                    "Envelopes and LFOs for Volume, Panning, Cutoff, Resonance and Pitch.",
                    "Each has Delay, Attack, Hold, Decay, Sustain, Release plus tension curves.",
                    "Articulator switches at the top turn each envelope on — they're off by default, which is why moving them sometimes does nothing."
                ]),
                .init(heading: "MISC", bullets: [
                    "Levels adjustment (pan, volume, pitch, mod x/y) applied to the whole channel.",
                    "Polyphony: max voices, mono mode, portamento/slide time.",
                    "Time: gate and shift for micro-timing the whole channel.",
                    "Echo delay / fat mode — a quick built-in delay per channel.",
                    "Arpeggiator: range, chord type, time, gate — a full arp with no extra plugin."
                ]),
                .init(heading: "FUNC / Wrapper", body: "On plugin channels this is the wrapper page instead: MIDI input port, processing options and Smart disable. See the Plugin Wrapper screen map.")
            ]
        ),

        Topic(
            id: "fl-stretch",
            daw: .fl,
            title: "Time stretching modes",
            blurb: "Which mode for which sound.",
            difficulty: .builds,
            sections: [
                .init(heading: "The modes", bullets: [
                    "Resample — no stretching; changing pitch changes speed. The turntable sound.",
                    "Auto — FL picks based on the material. A good default.",
                    "e3 Generic / e2 Generic — general-purpose, good on full loops.",
                    "Transient / Slice stretch — preserves drum hits; best for percussive loops.",
                    "Mono / Speech — for single voices.",
                    "Pro Default / Pro Transient — the high-quality élastique modes."
                ]),
                .init(heading: "How to conform a loop", bullets: [
                    "Drop the loop in, then in the channel's SMP tab set the TIME knob to the loop's original tempo, or type the bar count.",
                    "Right-click the clip → 'Fit to tempo' when FL can read the file's own tempo tag.",
                    "For big tempo moves, expect artefacts; a different mode usually helps more than more processing."
                ]),
                .init(heading: "Pitch without speed", body: "Set a stretch mode other than Resample, then use the pitch knob. In Resample mode, pitch and speed are locked together.")
            ]
        ),

        Topic(
            id: "fl-menus",
            daw: .fl,
            title: "Menu-by-menu reference",
            blurb: "What lives under each FL menu.",
            difficulty: .deep,
            sections: [
                .init(heading: "File", bullets: [
                    "New / New from template · Open / Save / Save as.",
                    "Save as → 'Zipped loop package' bundles samples with the project.",
                    "Export → WAV, MP3, FLAC, OGG, MIDI file, Project bundle.",
                    "Import → MIDI file, and the audio formats."
                ]),
                .init(heading: "Edit", bullets: [
                    "Undo / Redo, plus 'Undo history' which shows the full stack.",
                    "Cut/Copy/Paste and 'Select all'.",
                    "'Prepare for MIDI export' and similar helpers."
                ]),
                .init(heading: "Add", bullets: [
                    "One entry per bundled instrument, plus 'More plugins…' which opens the plugin manager.",
                    "Automation clip · Layer · Sampler."
                ]),
                .init(heading: "Patterns", bullets: [
                    "Find first empty pattern (F4) · Insert / Clone / Delete.",
                    "Split by channel — turns one crowded pattern into one per channel. Fixes a badly-started project.",
                    "Rename / Colour."
                ]),
                .init(heading: "View", bullets: [
                    "Playlist, Piano roll, Channel rack, Mixer, Browser, Plugin picker.",
                    "Toolbars, Plugin performance monitor, Project info.",
                    "Arrange windows (Ctrl+Shift+H)."
                ]),
                .init(heading: "Options", bullets: [
                    "MIDI / Audio / General / File / Project settings (all tabs of the same dialog, F10).",
                    "Multilink to controllers · Typing keyboard to piano (Ctrl+T).",
                    "Loop recording · Step edit · Metronome · Count-in."
                ]),
                .init(heading: "Tools", bullets: [
                    "Macros — 'Switch smart disable for all plugins', 'Prepare for audio recording', 'Purge unused audio clips'.",
                    "Riff machine · One-click audio recording.",
                    "Browse example projects."
                ])
            ]
        )
    ]
}
