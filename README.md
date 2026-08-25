# Deck — an Ableton Live & FL Studio navigation trainer

A personal iOS app, built to be **sideloaded as an unsigned IPA**, that teaches you where
everything is in Ableton Live and FL Studio and what each control actually does.

Not a video course and not a screenshot dump: every screen is redrawn as an **interactive
schematic** you can pinch, zoom and tap. Tap any region and you get what that control is,
what each of its options means, what to click to use it, its keyboard shortcuts, and the
mistake people usually make with it.

## What's in it

| | |
|---|---|
| **16 screen maps** | Session View, Arrangement, Control Bar, Browser, Mixer strip, MIDI editor, Device chain & Racks, Preferences · Toolbar/Transport, Channel Rack, Playlist, Piano Roll, Mixer, Browser, Plugin Wrapper, Settings |
| **~140 annotated controls** | Every tappable region carries a summary, an option-by-option breakdown, "try this" actions, shortcuts and gotchas |
| **25 how-to walkthroughs** | Setup, first beat, recording MIDI/audio, warping, arranging, automation, sidechaining, sampling, controller mapping, export, CPU triage, saving & moving projects — for both DAWs |
| **11 concept guides** | Signal flow, gain staging, latency & buffers, the three quantisations, warp modes, racks & macros, routing, the FL pattern model, mixer routing, channel settings, plus a full Ableton⇄FL translation table and menu-by-menu references |
| **~70 shortcuts** | Grouped by task, with a Windows/macOS key-name switch |
| **50-term glossary** | Plain language, no jargon explaining jargon |
| **Search** | Across every control, task, shortcut and term; scoped to one DAW or both |
| **Progress tracking** | Screens visited and how-tos completed, stored on device |

## Getting the IPA

### Option A — GitHub Actions (no Mac needed)

Every push builds it. Open the **Actions** tab → the latest **Build unsigned IPA** run →
download the `DAWLearn-unsigned-ipa` artifact → unzip → `DAWLearn-unsigned.ipa`.

### Option B — locally, on a Mac with Xcode

```bash
brew install xcodegen
./Scripts/build_ipa.sh
# → build/DAWLearn-unsigned.ipa
```

## Sideloading it

The IPA is unsigned on purpose — you sign it with your own free Apple ID at install time:

- **AltStore / SideStore** — add the IPA from the Files app; refreshes itself over Wi-Fi.
- **Sideloadly** — plug the phone in, drag the IPA in, enter your Apple ID.
- **Xcode** — open the project directly, set your own team, and run to your device.

With a free Apple developer account the app expires after 7 days and needs refreshing;
with a paid account it lasts a year. After installing, trust the certificate under
**Settings → General → VPN & Device Management**.

The app requires iOS 16 or later, runs on iPhone and iPad, is entirely offline, and
collects nothing.

## Repository layout

```
project.yml                        XcodeGen spec (the .xcodeproj is generated, not committed)
Scripts/build_ipa.sh               Unsigned Release build + Payload/ zip → .ipa
Scripts/make_icon.py               Generates the app icon (no dependencies)
Scripts/preview_maps.py            Renders every screen map to PNG to check layouts
.github/workflows/build-ipa.yml    CI build, uploads the IPA as an artifact
Sources/DAWLearn/
  Theme.swift                      Every colour, radius and type size — the whole look
  Model/                           Content types + persisted app state
  Content/                         All the teaching material, as Swift data
    AbletonMaps.swift              Ableton screen diagrams + per-control explanations
    FLMaps.swift                   FL Studio screen diagrams + per-control explanations
    Walkthroughs.swift             Step-by-step tasks
    Topics.swift                   Concept guides
    Reference.swift                Shortcuts + glossary
    Library.swift                  Aggregation and search
  Views/                           SwiftUI screens; DiagramView.swift is the diagram engine
```

### Re-skinning it

`Sources/DAWLearn/Theme.swift` is the single source of truth for the palette, corner radii
and type ramp. Change the colours there and the entire app — diagrams included — follows.

### Adding content

The diagrams are data, not drawings. A screen is an `InterfaceMap` holding `MapElement`s
with normalised (0…1) frames, a role that picks their colour, and an optional
`ElementDetail` that makes them tappable. Add an element to any map, run
`python3 Scripts/preview_maps.py` to check the layout, and the app picks it up — including
in search.

## Accuracy

Written against Ableton Live 11/12 and FL Studio 21/2024. Menu paths and shortcuts change
between versions; the schematics deliberately show structure and relationships rather than
pixel-exact chrome, so they stay right for longer. Ableton shortcuts are written with Cmd —
switch on Windows key names in Settings for Ctrl.
