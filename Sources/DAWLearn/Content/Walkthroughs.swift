import Foundation

enum Walkthroughs {

    static let all: [Walkthrough] = ableton + fl

    // MARK: - Ableton Live

    static let ableton: [Walkthrough] = [

        Walkthrough(
            id: "live-setup",
            daw: .ableton,
            title: "Set Live up so it makes sound",
            goal: "Audio out of your speakers, a controller playing notes, nothing crackling.",
            mapID: "live-preferences",
            steps: [
                .init("Open Preferences", "Cmd+, on macOS, Ctrl+, on Windows.", highlights: "tabs"),
                .init("Audio tab → Driver Type", "CoreAudio on macOS. On Windows choose ASIO and pick your interface's driver; if you have no interface, install ASIO4ALL.", highlights: "audio"),
                .init("Pick your Audio Output Device", "Your interface, or Built-in Output. Test with the 'Test Tone' switch if you hear nothing."),
                .init("Set Sample Rate to 44100 or 48000", "Then leave it alone for the life of the project."),
                .init("Set Buffer Size to 128 samples", "Low enough to play in time. Raise it to 512+ later when the project gets heavy."),
                .init("Input Config / Output Config", "Switch on the channel pairs you own, so they appear in track routing menus."),
                .init("Link/Tempo/MIDI tab → Control Surface", "Choose your controller if it's in the list. Then in the MIDI Ports table below, switch on Track and Remote for its input port.", highlights: "linkmidi"),
                .init("Plug-Ins tab → switch on VST3 / Audio Units", "Add custom folders if needed, then press Rescan.", highlights: "plugins"),
                .init("Close Preferences and play a note", "Load an instrument from the Browser onto a MIDI track — you should hear it.")
            ],
            tips: [
                "Overall Latency at the bottom of the Audio tab is what you'll feel when playing. Under ~10 ms feels immediate.",
                "Crackling is nearly always buffer size. Raise it before you blame a plug-in."
            ]
        ),

        Walkthrough(
            id: "live-first-beat",
            daw: .ableton,
            title: "Build a beat in Session View",
            goal: "A four-bar drum loop you can launch, made from a Drum Rack.",
            mapID: "live-session",
            steps: [
                .init("Cmd+Shift+T to make a MIDI track", "Or drag one in from the Create menu.", highlights: "trackhead2"),
                .init("Browser → Drums → drag a Drum Rack onto the track", "Try one of the 'Kit-Core' kits to start.", highlights: "browser"),
                .init("Double-click an empty clip slot on that track", "This creates an empty 1-bar MIDI clip and opens the editor.", highlights: "clip-r1c3"),
                .init("Set the clip length to 4 bars", "In the Clip View's loop box, type 4 into the loop length field."),
                .init("Press B for Draw Mode and paint a kick on beats 1 and 3", "The pad names appear down the left of the editor when Fold is on."),
                .init("Add a snare on 2 and 4, then hats on every 1/8", "Right-click → grid → 1/8 if you need a coarser grid."),
                .init("Open the velocity lane and pull some hats down", "Anything between 60 and 110 sounds more human than a flat 100."),
                .init("Launch the clip", "Click the triangle in the slot. It starts on the next bar because Global Quantisation is 1 Bar.", highlights: "clip-r1c1"),
                .init("Duplicate the clip into the slot below and change it", "Cmd+D, then edit — that's your variation/fill for a second scene.")
            ],
            tips: [
                "Right-click a Drum Rack pad → 'Extract Chains' to break a kit into separate tracks for individual processing.",
                "Cmd+U quantises a sloppy performance to the current Record Quantisation."
            ],
            shortcuts: [
                Shortcut("Cmd+Shift+T", "New MIDI track"),
                Shortcut("B", "Draw Mode"),
                Shortcut("Cmd+D", "Duplicate"),
                Shortcut("Cmd+U", "Quantise")
            ]
        ),

        Walkthrough(
            id: "live-record-midi",
            daw: .ableton,
            title: "Record MIDI from a keyboard",
            goal: "Capture a played part into a clip, in time, without fighting the transport.",
            mapID: "live-session",
            difficulty: .core,
            steps: [
                .init("Load an instrument onto a MIDI track"),
                .init("Arm the track", "The circle at the bottom of the mixer strip. Play — you should hear it.", highlights: "buttons"),
                .init("Set Record Quantisation", "Edit menu → Record Quantisation → Sixteenth Note Quantisation. This tidies your timing as you play."),
                .init("Turn on the metronome and a count-in", "Click the arrow next to the metronome → 1 Bar count-in.", highlights: "controlbar"),
                .init("Click the record button in an empty clip slot", "Recording starts after the count-in and loops.", highlights: "clip-r2c3"),
                .init("Play. Click the same slot again to stop recording", "The clip immediately starts playing back what you recorded."),
                .init("Fix anything in the MIDI editor", "Shift+Tab, then drag notes or press Cmd+U to quantise again."),
                .init("Didn't press record but played something great?", "Press Cmd+Shift+C — Capture MIDI retroactively creates a clip from what Live was listening to.")
            ],
            tips: [
                "Capture MIDI (Cmd+Shift+C) is the single best feature in Live for songwriting. Learn it before anything else.",
                "Overdub: with the clip playing and the track armed, switch on the Session Record button to layer more notes into the same clip."
            ],
            shortcuts: [
                Shortcut("Cmd+Shift+C", "Capture MIDI"),
                Shortcut("F9", "Session Record"),
                Shortcut("Cmd+U", "Quantise")
            ]
        ),

        Walkthrough(
            id: "live-record-audio",
            daw: .ableton,
            title: "Record a vocal or guitar",
            goal: "A clean take on an audio track with no feedback and no latency confusion.",
            mapID: "live-mixer",
            steps: [
                .init("Cmd+T for a new Audio track", highlights: "audiofrom"),
                .init("Audio From → Ext. In → the input your mic is on", "1 for a single mic; 1/2 only if you want a stereo pair.", highlights: "audiofrom"),
                .init("Set Monitor to Auto", "You'll hear the input whenever the track is armed and not playing a clip.", highlights: "monitor"),
                .init("Arm the track and check the meter", "Sing at your loudest — peaks should sit around −12 to −6 dB. Adjust gain on the interface, not in Live.", highlights: "meterstrip"),
                .init("Put on headphones", "Monitoring through speakers with a live mic is how feedback happens."),
                .init("Record into a clip slot (Session) or along the timeline (Arrangement)", "In Arrangement, press the global record button and Space."),
                .init("Comp your takes", "Record several passes into different slots/lanes, then pick the best bits. In Arrangement, unfold the track to see take lanes."),
                .init("Clean the edges", "Preferences → Record/Warp/Launch → Create Fades on Clip Edges avoids clicks.")
            ],
            tips: [
                "If your take lands early or late, that's driver latency compensation — check 'Driver Error Compensation' under the Audio tab's Latency section.",
                "'Resampling' as an input records Live's own output — perfect for bouncing a sound with its effects."
            ]
        ),

        Walkthrough(
            id: "live-warp",
            daw: .ableton,
            title: "Warp a sample so it fits your tempo",
            goal: "A loop or acapella that stays in time no matter what BPM you choose.",
            difficulty: .builds,
            steps: [
                .init("Drag the audio file onto a clip slot or the Arrangement"),
                .init("Select the clip and open Clip View", "Shift+Tab."),
                .init("Switch Warp on", "The Warp button in the Sample box. Live guesses the original tempo — check the Seg. BPM field."),
                .init("Choose a Warp Mode", "Beats for drums and loops · Tones for monophonic melodic material · Texture for pads · Complex Pro for vocals and full mixes."),
                .init("Check the alignment", "Play the clip against the metronome. If it drifts, the transient markers are wrong."),
                .init("Fix drift with Warp Markers", "Double-click a transient marker in the waveform to make it a Warp Marker, then drag it onto the right grid line."),
                .init("Or let Live do it", "Right-click the waveform → Warp From Here (Straight) / Warp As X-Bar Loop when the loop length is known."),
                .init(":2 and *2 buttons", "If Live guessed double or half the tempo, these fix it in one click.")
            ],
            tips: [
                "Set the default Warp Mode for imported audio in Preferences → Record/Warp/Launch.",
                "For one-shots (a single kick, a vocal stab) switch Warp OFF — warping them only adds artefacts."
            ]
        ),

        Walkthrough(
            id: "live-session-to-arrangement",
            daw: .ableton,
            title: "Turn a Session jam into a finished arrangement",
            goal: "Record your clip launching onto the timeline, then edit it into a song.",
            mapID: "live-arrangement",
            difficulty: .builds,
            steps: [
                .init("Get your scenes in order in Session View", "Name them Intro / Verse / Chorus so you know what you're firing.", highlights: "ruler"),
                .init("Press the global Record button in the Control Bar", "The Arrangement is now recording everything you launch."),
                .init("Play the set", "Launch scenes and clips, move faders, twist knobs — all of it is written to the timeline."),
                .init("Press Stop, then Tab to Arrangement View", "Your performance is laid out as clips and automation."),
                .init("Press 'Back to Arrangement'", "The orange button — this hands playback control back to the timeline.", highlights: "backtoarr"),
                .init("Edit the structure", "Select a time range, Cmd+X to cut it out (ripple delete), Cmd+D to double a section."),
                .init("Consolidate messy regions", "Select and press Cmd+J to render them into one clean clip."),
                .init("Draw automation for transitions", "Press A and draw a filter sweep into the drop.", highlights: "autolane")
            ],
            tips: [
                "The reverse also works: select a time range in Arrangement, right-click → Consolidate Time to New Scene to get it back into Session.",
                "Cmd+E splits a clip at the insert marker — the main editing tool in Arrangement."
            ],
            shortcuts: [
                Shortcut("Cmd+E", "Split"),
                Shortcut("Cmd+J", "Consolidate"),
                Shortcut("Cmd+X", "Cut time"),
                Shortcut("A", "Automation Mode")
            ]
        ),

        Walkthrough(
            id: "live-automation",
            daw: .ableton,
            title: "Automate any parameter",
            goal: "A filter that opens across eight bars, and a volume dip on the master.",
            mapID: "live-arrangement",
            difficulty: .builds,
            steps: [
                .init("Go to Arrangement View and press A", "Automation Mode: clips dim and every parameter becomes drawable.", highlights: "autolane"),
                .init("Unfold the track", "Click the ⊞ triangle in the track header to reveal the automation lane.", highlights: "lane1head"),
                .init("Choose what to automate", "The two dropdowns in the lane: first the device, then the parameter (e.g. Auto Filter → Frequency)."),
                .init("Click on the line to add breakpoints", "One at the start low, one eight bars later high."),
                .init("Curve the ramp", "Alt+drag the segment between two points to bend it."),
                .init("Or just move the control while recording", "With Arrangement Record on, any knob you touch writes automation."),
                .init("Red values = overridden", "If a parameter shows its value in red, you've moved it manually. Press 'Back to Arrangement' to restore the written automation.", highlights: "backtoarr"),
                .init("Clip envelopes for per-clip movement", "In Clip View → Envelopes, automation lives inside the clip and repeats with it — great for Session View.")
            ],
            tips: [
                "Delete an automation lane's data with the lane's ✕, or select a range and press Delete.",
                "Draw Mode (B) plus Automation Mode gives you stepped, grid-quantised automation — good for gated effects."
            ]
        ),

        Walkthrough(
            id: "live-sidechain",
            daw: .ableton,
            title: "Sidechain the bass to the kick",
            goal: "The classic pumping duck, done properly with Compressor's sidechain input.",
            mapID: "live-device-chain",
            difficulty: .builds,
            steps: [
                .init("Put a Compressor on the bass track", "Drag it from Audio Effects → Compressor.", highlights: "dev3"),
                .init("Open the sidechain panel", "Click the ▶ triangle at the top-left of the Compressor, then switch Sidechain on."),
                .init("Set Audio From to the kick track", "The dropdown inside the sidechain panel."),
                .init("Set Ratio around 4:1 and Threshold down until you see 4–6 dB of gain reduction"),
                .init("Attack fast (~1 ms), Release ~100 ms", "Release is the feel control: shorter = snappier pump; time it to the tempo."),
                .init("Check with the EQ button in the sidechain panel", "Filter the sidechain input to only the kick's low end so hats don't trigger it."),
                .init("Alternative: use an LFO / envelope instead", "Put a 'Volume' automation or an LFO device (Max for Live) on the bass for a shape that never depends on the kick's dynamics.")
            ],
            tips: [
                "No kick track to trigger from? Make a silent MIDI/audio track with just the kick pattern and route the compressor's sidechain to it.",
                "Glue Compressor also has a sidechain and is gentler on busses."
            ]
        ),

        Walkthrough(
            id: "live-simpler",
            daw: .ableton,
            title: "Chop a sample with Simpler",
            goal: "Play slices of a loop across your keyboard or pads.",
            mapID: "live-device-chain",
            difficulty: .builds,
            steps: [
                .init("Drag an audio file onto an empty MIDI track", "Live loads it into Simpler automatically."),
                .init("Choose Slice mode", "The three mode buttons at the top of Simpler: Classic, One-Shot, Slice."),
                .init("Pick the slice division", "Slice by Transient, Beat, Region or Manual. Beat → 1/8 is a good start."),
                .init("Play the pads", "Each slice sits on its own MIDI note, starting at C1."),
                .init("Add or remove slices", "Click on the waveform to add a marker; select and Delete to remove."),
                .init("Record a new pattern", "Arm the track and play the slices in a new order — instant flipped loop."),
                .init("Convert to a Drum Rack", "Right-click Simpler → 'Convert to Drum Rack' if you want each slice processed separately.")
            ],
            tips: ["One-Shot mode with Snap on is the right choice for single hits and vocal stabs."]
        ),

        Walkthrough(
            id: "live-midi-map",
            daw: .ableton,
            title: "Map a MIDI controller to anything",
            goal: "A knob that controls a filter, a pad that launches a clip.",
            mapID: "live-controlbar",
            steps: [
                .init("Make sure the controller's Remote switch is on", "Preferences → Link/Tempo/MIDI → MIDI Ports table → Remote: On for that input."),
                .init("Press Cmd+M", "MIDI Map Mode. The interface turns blue and a mapping list opens on the left.", highlights: "midimap"),
                .init("Click the control in Live you want to map", "A filter knob, a clip slot, the tempo field — almost anything."),
                .init("Move the knob or press the pad on your controller", "The mapping appears in the list."),
                .init("Set Min / Max in the mapping list", "Swap them to invert the control, or narrow the range for finer feel."),
                .init("Press Cmd+M again to leave map mode", "Now play."),
                .init("Key mapping works the same way", "Cmd+K, click a control, press a computer key.")
            ],
            tips: [
                "Mappings are saved with the Set. To reuse them everywhere, save a Default Set (Preferences → File/Folder → Save Current Set as Default).",
                "Delete a mapping by selecting it in the list and pressing Delete."
            ],
            shortcuts: [Shortcut("Cmd+M", "MIDI Map"), Shortcut("Cmd+K", "Key Map")]
        ),

        Walkthrough(
            id: "live-export",
            daw: .ableton,
            title: "Export the finished track",
            goal: "A WAV that sounds like what you hear, at the right length.",
            steps: [
                .init("Select the time range you want to export", "In Arrangement, drag across the ruler from bar 1 to the end. Leave a bar of tail for reverbs."),
                .init("Cmd+Shift+R — Export Audio/Video"),
                .init("Rendered Track: Master", "Or choose 'All Individual Tracks' to get stems."),
                .init("Set Sample Rate and Bit Depth", "44100 / 24-bit for mixing and mastering; 44100 / 16-bit for a CD-style deliverable."),
                .init("File Type: WAV", "Export MP3 too if you want a quick share copy — Live can do both at once."),
                .init("Normalize: Off. Dither: only on a final 16-bit master", "Never dither twice."),
                .init("Check 'Render as Loop' only if the file must loop seamlessly"),
                .init("Press Export and pick a location")
            ],
            tips: [
                "The Master meter must not hit red. If it does, pull the master fader down before rendering, not after.",
                "Exporting stems: switch off any master-bus processing first, or it'll be baked into every stem."
            ],
            shortcuts: [Shortcut("Cmd+Shift+R", "Export Audio/Video")]
        ),

        Walkthrough(
            id: "live-cpu",
            daw: .ableton,
            title: "Fix a project that's crackling",
            goal: "Playback that doesn't stutter on a heavy set.",
            mapID: "live-session",
            difficulty: .builds,
            steps: [
                .init("Raise the buffer size", "Preferences → Audio → 512 or 1024 while mixing."),
                .init("Freeze the heaviest tracks", "Right-click the track header → Freeze Track. Live renders it to audio and stops running its devices.", highlights: "trackhead1"),
                .init("Flatten if you're sure", "Right-click → Flatten replaces the frozen track's devices with the rendered audio permanently."),
                .init("Check the CPU meter per device", "Live 11+ shows per-track CPU; reverbs and convolution are usually the culprits."),
                .init("Use one reverb on a Return instead of six on tracks", highlights: "trackhead4"),
                .init("Turn off high-quality modes while working", "Right-click a device → 'Hi-Quality' off for EQ Eight and similar."),
                .init("Watch the Disk Overload LED", "If it's flashing, your samples are streaming too slowly — move the project to a faster drive or raise the RAM cache in File/Folder.")
            ]
        ),

        Walkthrough(
            id: "live-save",
            daw: .ableton,
            title: "Save and move a project safely",
            goal: "A set that still finds all its samples on another computer.",
            steps: [
                .init("Cmd+S saves the Set", "A .als file, which is only pointers to samples."),
                .init("File → Collect All and Save", "Copies every sample the set uses into the project folder."),
                .init("Choose what to collect", "Files from elsewhere: Yes. Factory library: No (the other machine has it too)."),
                .init("Zip the whole project folder to move it", "Not just the .als file."),
                .init("Missing samples on the other machine?", "File → Manage Files → Missing Files → Locate; point it at a folder and Live searches it.")
            ],
            tips: ["Live auto-saves nothing by default — Cmd+S often. Set 'Create Analysis Files' on so warping settings travel with the audio."]
        )
    ]

    // MARK: - FL Studio

    static let fl: [Walkthrough] = [

        Walkthrough(
            id: "fl-setup",
            daw: .fl,
            title: "Set FL Studio up so it makes sound",
            goal: "Audio out, controller in, no crackle.",
            mapID: "fl-settings",
            steps: [
                .init("F10 to open Settings", highlights: "tabs"),
                .init("Audio tab → Device", "Windows: FL Studio ASIO, or your interface's ASIO driver. macOS: your interface via CoreAudio.", highlights: "audio"),
                .init("Buffer length ≈ 10 ms", "Slide it left for lower latency when playing, right if you get crackles."),
                .init("Sample rate 44100 Hz", "Match whatever you'll deliver."),
                .init("Switch on Safe overloads and Triple buffer", "Both reduce dropouts on busy projects."),
                .init("MIDI tab → select your controller under Input → click Enable", "Nothing works until Enable is lit.", highlights: "midi"),
                .init("Pick the controller type if FL knows your hardware", "It loads a mapping automatically."),
                .init("File tab → add your sample folders", "Browser extra search folders. Add your VST paths here too, then 'Manage plugins' → Find installed plugins.", highlights: "file"),
                .init("General tab → raise the undo history, turn auto-save on", highlights: "general")
            ],
            tips: [
                "FL Studio ASIO works on any Windows machine with no interface — use it before ASIO4ALL.",
                "'Auto close device' lets YouTube keep working while FL is open."
            ],
            shortcuts: [Shortcut("F10", "Settings")]
        ),

        Walkthrough(
            id: "fl-first-beat",
            daw: .fl,
            title: "Make a beat in the Channel Rack",
            goal: "A one-bar drum pattern using the step sequencer.",
            mapID: "fl-channelrack",
            steps: [
                .init("F6 to open the Channel Rack", highlights: "chan1"),
                .init("Make sure you're in PAT mode", "The PAT/SONG switch in the toolbar — otherwise you'll hear the (empty) playlist."),
                .init("Drag a kick sample from the Browser into the rack", "Or click + → Sampler and load one.", highlights: "plus"),
                .init("Click steps 1, 5, 9, 13", "Those are the four downbeats on a 16-step bar.", highlights: "steps1"),
                .init("Add a clap on 5 and 13, hats on every other step", highlights: "steps3"),
                .init("Open the Graph Editor and shape the hat velocities", "Alternate loud/quiet for a groove.", highlights: "graph"),
                .init("Add swing", "The Swing knob at the top of the rack — 20–30% is enough to feel it.", highlights: "header"),
                .init("Name and colour the pattern", "Right-click the pattern selector → Rename. Call it 'Drums'."),
                .init("Route each drum to its own mixer insert", "Select all drum channels, press Ctrl+L.", highlights: "fx1")
            ],
            tips: [
                "Right-click a step to set a per-step velocity/pitch without opening the graph editor.",
                "Right-click a channel → 'Fill each 2 steps' for instant hi-hat patterns."
            ],
            shortcuts: [Shortcut("F6", "Channel Rack"), Shortcut("Ctrl+L", "Route channels to inserts"), Shortcut("L", "Pattern/Song mode")]
        ),

        Walkthrough(
            id: "fl-melody",
            daw: .fl,
            title: "Write a melody in the Piano Roll",
            goal: "A chord progression and a lead line that stay in key.",
            mapID: "fl-pianoroll",
            steps: [
                .init("Add an instrument channel", "+ → your synth, or pick from the Plugin Picker."),
                .init("F7 with that channel selected", "Opens the Piano Roll for it.", highlights: "grid"),
                .init("Turn on scale highlighting", "The ▾ menu → Helpers → Scale highlighting → pick your key. Out-of-key rows go dark.", highlights: "scale"),
                .init("Use the stamp tool for chords", "Pick a chord shape from the stamp dropdown and click on the grid to place the whole voicing.", highlights: "stamp"),
                .init("Draw the lead over the top", "Left-click to place, right-click to delete, drag the right edge to lengthen."),
                .init("Shape velocities in the control lane", "The strip at the bottom; drag stems, or Alt+drag for a straight ramp.", highlights: "velolane"),
                .init("Ctrl+Q to quantise anything sloppy"),
                .init("Ctrl+L for quick legato", "Extends each note to the start of the next one — tidy basslines in one keystroke.")
            ],
            tips: [
                "Ghost channels (Helpers → Ghost channels) show other channels' notes greyed out behind yours, so parts fit together.",
                "Tools → Riff machine generates a melodic idea you can then edit — a good stuck-writer's tool."
            ],
            shortcuts: [
                Shortcut("F7", "Piano Roll"),
                Shortcut("Ctrl+Q", "Quick quantise"),
                Shortcut("Ctrl+L", "Quick legato"),
                Shortcut("Ctrl+B", "Duplicate to the right")
            ]
        ),

        Walkthrough(
            id: "fl-arrange",
            daw: .fl,
            title: "Arrange patterns into a song",
            goal: "An intro / verse / drop structure on the Playlist.",
            mapID: "fl-playlist",
            steps: [
                .init("Make one pattern per part", "Drums, Bass, Chords, Lead, Fills. F4 jumps to the next empty pattern."),
                .init("F5 to open the Playlist and switch to SONG mode", "The PAT/SONG toggle, or press L."),
                .init("Select a pattern in the pattern selector, then paint it onto a track", "Press B for the brush tool and drag across bars.", highlights: "clip1"),
                .init("Keep one instrument per Playlist track", "Tracks are just lanes, so this convention is what keeps a project readable.", highlights: "track1head"),
                .init("Add time markers", "Ctrl+T on the timeline → name them Intro, Verse, Drop.", highlights: "ruler"),
                .init("Duplicate sections", "Select with the E tool, then Ctrl+B to duplicate to the right."),
                .init("Vary repeats", "Right-click a clip → Make unique, then edit that copy so the second verse isn't identical."),
                .init("Drop audio and automation clips onto their own tracks at the bottom", highlights: "autoclip")
            ],
            tips: [
                "Clips on the Playlist reference patterns. Editing the pattern changes every instance — that's a feature until it isn't; 'Make unique' is the escape hatch.",
                "Right-click a Playlist track → 'Merge pattern clips' consolidates a lane."
            ],
            shortcuts: [Shortcut("F5", "Playlist"), Shortcut("B", "Paint"), Shortcut("Ctrl+B", "Duplicate"), Shortcut("F4", "Next empty pattern")]
        ),

        Walkthrough(
            id: "fl-mixer-routing",
            daw: .fl,
            title: "Route to the mixer and add effects",
            goal: "Every sound on its own insert, a reverb bus, and a clean master.",
            mapID: "fl-mixer",
            steps: [
                .init("Select all channels in the rack and press Ctrl+L", "They're assigned to consecutive free inserts.", highlights: "ins1"),
                .init("F9 to open the Mixer, then F2 to rename each insert", "Kick, Snare, Bass, Lead — future you will thank you.", highlights: "ins1"),
                .init("Click an empty effect slot to add a plugin", "Fruity Parametric EQ 2 first, then a compressor.", highlights: "fxslots"),
                .init("Set up a reverb bus", "Pick a free insert, name it REVERB, load Fruity Reeverb 2 and set its mix to 100% wet.", highlights: "bus"),
                .init("Send tracks to it", "Select the source insert, then click the send arrow under the REVERB insert. Turn the send knob up.", highlights: "sendknobs"),
                .init("Group your drums", "Route kick/snare/hats to one free insert instead of Master, and compress that."),
                .init("Watch the Master", "Peaks around −6 dB; a limiter last if you need volume.", highlights: "masterstrip")
            ],
            tips: [
                "Insert order in the slots is the processing order — EQ before compression usually, saturation after.",
                "Right-click a slot's dry/wet knob → 'Create automation clip' to automate an effect's mix over time."
            ],
            shortcuts: [Shortcut("F9", "Mixer"), Shortcut("Ctrl+L", "Auto-route"), Shortcut("F2", "Rename insert")]
        ),

        Walkthrough(
            id: "fl-automation",
            daw: .fl,
            title: "Automate a knob with an automation clip",
            goal: "A filter sweep that runs across eight bars of the arrangement.",
            mapID: "fl-playlist",
            difficulty: .builds,
            steps: [
                .init("Right-click the knob you want to automate", "Any knob in FL — a plugin parameter, a mixer fader, the tempo."),
                .init("Choose 'Create automation clip'", "A new automation clip channel appears and the clip lands on the Playlist.", highlights: "autoclip"),
                .init("Drag it onto its own Playlist track", "Keep automation at the bottom of the arrangement."),
                .init("Shape the curve", "Right-click a point for curve type (single curve, hold, stairs, smooth). Drag the diamond between points to bend it."),
                .init("Add points by right-clicking the line", "Double-click a point to remove it."),
                .init("Resize the clip to cover the bars you want", "Outside the clip, the parameter holds its last value."),
                .init("Alternative: record knob moves live", "Arm record with the recording filter set to Automation, hit play and move the knob.")
            ],
            tips: [
                "'Link to controller' on the same right-click menu binds hardware instead of drawing.",
                "An automation clip's own channel can be muted like any other — handy for A/B-ing."
            ]
        ),

        Walkthrough(
            id: "fl-sidechain",
            daw: .fl,
            title: "Sidechain the bass to the kick",
            goal: "That pumping duck, using the mixer's sidechain routing.",
            mapID: "fl-mixer",
            difficulty: .builds,
            steps: [
                .init("Put the kick and the bass on separate mixer inserts", highlights: "ins1"),
                .init("Select the KICK insert", "Its routing arrows light up along the bottom."),
                .init("Right-click the arrow under the BASS insert → 'Sidechain to this track'", "The kick is now available as a sidechain source for plugins on the bass.", highlights: "sendknobs"),
                .init("Load Fruity Limiter on the bass and switch to COMP mode", "Or use Fruity Compressor / a third-party compressor with sidechain support."),
                .init("Set its Sidechain source to the kick's sidechain number", "The SIDECHAIN knob in Fruity Limiter's COMP page."),
                .init("Dial threshold down until you see 4–6 dB of ducking", "Fast attack, release around 100–150 ms."),
                .init("Alternative: Fruity Peak Controller", "Put it on the kick, then right-click the bass volume knob → Link to controller → Peak ctrl. Total control over the shape.")
            ],
            tips: ["Turning the kick's direct routing to Master off after sidechaining is a classic mistake — check you can still hear the kick."]
        ),

        Walkthrough(
            id: "fl-record-audio",
            daw: .fl,
            title: "Record a vocal or an instrument",
            goal: "A take on the Playlist, at a healthy level.",
            mapID: "fl-mixer",
            steps: [
                .init("F9 → pick a free insert and set its IN to your interface input", highlights: "io"),
                .init("Arm the insert", "The circle at the bottom of the strip.", highlights: "recarm"),
                .init("Check the level", "Aim for peaks around −12 dB. Set gain on the interface, not with the FL fader."),
                .init("Set the recording filter", "Right-click the transport record button → Audio."),
                .init("Turn on the count-in if you want one", "Ctrl+P."),
                .init("Press record, then play", "FL asks where to record; choose 'Into the playlist'."),
                .init("Stop. The clip appears on the Playlist and the file lands in the project folder."),
                .init("Edit the take", "Right-click the clip → Edit in Edison for trimming, noise reduction and normalising.")
            ],
            tips: ["Latency compensation: Options → Audio settings → 'Record latency compensation'. Record a click through a loopback to measure it exactly."]
        ),

        Walkthrough(
            id: "fl-chop",
            daw: .fl,
            title: "Chop a sample",
            goal: "Slices you can replay as a new pattern.",
            mapID: "fl-pianoroll",
            difficulty: .builds,
            steps: [
                .init("Drag the sample onto the Playlist or into a channel"),
                .init("Right-click the clip → Chop", "FL slices at transients and builds a pattern of the slices."),
                .init("Or load it into Slicex", "+ → Slicex, drag the sample in. Each slice gets its own key and its own envelope."),
                .init("Adjust slice markers", "In Slicex's waveform, drag markers; right-click for slicing by beat or by transient sensitivity."),
                .init("Open the Piano Roll on the Slicex channel and rearrange", "Each key is a slice — write a new order.", highlights: "grid"),
                .init("Or use Edison for surgical work", "Right-click a clip → Edit in Edison: trim, fade, reverse, normalise, declick, then drag the result back out.")
            ],
            tips: ["Slicex's 'Declick' setting stops slice edges from clicking. 'Smart' is a good default."]
        ),

        Walkthrough(
            id: "fl-link-controller",
            daw: .fl,
            title: "Link a hardware knob to any parameter",
            goal: "Hands-on control of a filter, a fader or a plugin knob.",
            mapID: "fl-settings",
            steps: [
                .init("Options → MIDI settings → enable your controller's input port", highlights: "midi"),
                .init("Right-click the parameter in FL → 'Link to controller…'"),
                .init("Move the knob on your hardware", "FL detects it and links it."),
                .init("Set 'Remove conflicts' if the knob is already used elsewhere"),
                .init("Tick 'Global link' to make the mapping apply in every project", "Otherwise it's saved with this project only."),
                .init("Multiple parameters at once", "Switch on 'Multilink to controllers' in the toolbar, then move several knobs — they all link in one pass."),
                .init("Manage links", "Tools → 'Last tweaked' and the browser's 'Current project → Controllers' show what's mapped.")
            ]
        ),

        Walkthrough(
            id: "fl-export",
            daw: .fl,
            title: "Export the finished track",
            goal: "A WAV or MP3 of the whole song, or stems.",
            steps: [
                .init("Set the export range", "Either select a region on the Playlist timeline, or leave nothing selected to render the whole song."),
                .init("File → Export → WAV file", "Ctrl+R."),
                .init("Choose a folder and filename"),
                .init("Mode: set the quality", "Resampling: 24-point sinc or better for the final render."),
                .init("Bit depth 24-bit for mixing, 16-bit for a final master"),
                .init("Tick 'Leave remainder' so reverb tails aren't cut off", "Or add an empty bar at the end of your arrangement."),
                .init("Split mixer tracks = stems", "Ticking it renders every insert to its own file."),
                .init("Start. Watch that the Master never clipped during the render.")
            ],
            tips: [
                "FL renders faster than real time, and it renders at higher quality than playback — the mix can sound slightly different (usually better).",
                "'Save note/slice markers' is only needed for loops you'll re-import."
            ],
            shortcuts: [Shortcut("Ctrl+R", "Export WAV")]
        ),

        Walkthrough(
            id: "fl-save",
            daw: .fl,
            title: "Save and move a project safely",
            goal: "A project that opens with all its samples on another machine.",
            steps: [
                .init("Ctrl+S to save the .flp", "The .flp holds settings and pointers, not the audio."),
                .init("File → Save as… → 'Zipped loop package'", "This bundles the project with every sample it uses."),
                .init("Or File → Export → Project bundle", "Same idea, as a folder."),
                .init("Backups", "FL auto-saves into the project's Backup folder — check there after a crash."),
                .init("Missing samples on another machine?", "FL asks you to locate them on open; point it at a folder and it searches recursively.")
            ],
            tips: ["Keep one folder per project with the .flp, the samples and the renders inside it. Zipped loop packages make that automatic."]
        )
    ]
}
