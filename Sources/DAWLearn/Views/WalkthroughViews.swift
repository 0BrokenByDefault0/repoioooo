import SwiftUI

struct WalkthroughListView: View {
    @EnvironmentObject private var state: AppState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    DAWSwitcher()

                    HStack {
                        Text("\(state.completedWalkthroughCount) of \(Library.walkthroughs(for: state.daw).count) done")
                            .font(Theme.mono(11, .semibold))
                            .foregroundColor(Theme.inkDim)
                        Spacer()
                    }

                    ForEach(Difficulty.allCases, id: \.self) { level in
                        let items = Library.walkthroughs(for: state.daw).filter { $0.difficulty == level }
                        if !items.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                SectionHeader(text: level.rawValue, accent: level.color)
                                ForEach(items) { walkthrough in
                                    NavigationLink {
                                        WalkthroughDetailView(walkthrough: walkthrough)
                                    } label: {
                                        NavRow(
                                            title: walkthrough.title,
                                            subtitle: walkthrough.goal,
                                            accent: level.color,
                                            icon: "list.number",
                                            done: state.isCompleted(walkthrough.id)
                                        ) {
                                            Chip(text: "\(walkthrough.steps.count) steps")
                                        }
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.top, 6)
                        }
                    }
                }
                .padding(16)
            }
            .screenBackground()
            .navigationTitle("How-to")
        }
    }
}

struct WalkthroughDetailView: View {
    @EnvironmentObject private var state: AppState
    let walkthrough: Walkthrough

    @State private var doneSteps: Set<Int> = []
    @State private var activeStep: Int? = nil

    private var linkedMap: InterfaceMap? {
        walkthrough.mapID.flatMap { Library.map(id: $0) }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 8) {
                        Chip(text: walkthrough.daw.shortName, color: walkthrough.daw.accent, filled: true)
                        Chip(text: walkthrough.difficulty.rawValue, color: walkthrough.difficulty.color)
                    }
                    Text(walkthrough.goal)
                        .font(Theme.text(17))
                        .foregroundColor(Theme.ink)
                        .fixedSize(horizontal: false, vertical: true)
                }

                if let map = linkedMap {
                    VStack(alignment: .leading, spacing: 8) {
                        SectionHeader(text: "On this screen", accent: map.daw.accent)
                        DiagramView(map: map, highlightedID: highlightFor(activeStep)) { _ in }
                            .allowsHitTesting(false)
                        Text(highlightFor(activeStep) == nil
                             ? "Tap a step below to light up where it happens."
                             : "Highlighted: step \((activeStep ?? 0) + 1)")
                            .font(Theme.mono(10, .medium))
                            .foregroundColor(Theme.inkFaint)
                        NavigationLink {
                            MapDetailView(map: map)
                        } label: {
                            Text("Open \(map.title) in full →")
                                .font(Theme.mono(11, .semibold))
                                .foregroundColor(map.daw.accent)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    SectionHeader(text: "Steps", accent: walkthrough.daw.accent)
                    ForEach(Array(walkthrough.steps.enumerated()), id: \.element.id) { index, step in
                        stepRow(index: index, step: step)
                    }
                }

                if !walkthrough.tips.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        SectionHeader(text: "Worth knowing", accent: Theme.lime)
                        ForEach(Array(walkthrough.tips.enumerated()), id: \.offset) { _, tip in
                            BulletLine(text: tip, color: Theme.lime)
                        }
                    }
                }

                if !walkthrough.shortcuts.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        SectionHeader(text: "Shortcuts used here")
                        ForEach(walkthrough.shortcuts) { ShortcutRow(shortcut: $0) }
                    }
                    .padding(14)
                    .panel()
                }

                Button {
                    state.toggleCompleted(walkthrough.id)
                } label: {
                    HStack {
                        Image(systemName: state.isCompleted(walkthrough.id) ? "checkmark.circle.fill" : "circle")
                        Text(state.isCompleted(walkthrough.id) ? "Marked as done" : "Mark as done")
                            .font(Theme.text(15, .semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(14)
                    .background(
                        RoundedRectangle(cornerRadius: Theme.radiusCard, style: .continuous)
                            .fill(state.isCompleted(walkthrough.id) ? Theme.lime : Theme.panelRaised)
                    )
                    .foregroundColor(state.isCompleted(walkthrough.id) ? Theme.void : Theme.ink)
                }
                .buttonStyle(.plain)
            }
            .padding(16)
        }
        .screenBackground()
        .navigationTitle(walkthrough.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func highlightFor(_ index: Int?) -> String? {
        guard let index, walkthrough.steps.indices.contains(index) else { return nil }
        return walkthrough.steps[index].highlights
    }

    private func stepRow(index: Int, step: Walkthrough.Step) -> some View {
        let isDone = doneSteps.contains(index)
        let isActive = activeStep == index

        return Button {
            withAnimation(.easeOut(duration: 0.15)) {
                activeStep = isActive ? nil : index
                if isDone { doneSteps.remove(index) } else { doneSteps.insert(index) }
            }
        } label: {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(isDone ? walkthrough.daw.accent : Theme.panelRaised)
                        .frame(width: 26, height: 26)
                    Text("\(index + 1)")
                        .font(Theme.mono(12, .bold))
                        .foregroundColor(isDone ? Theme.void : Theme.inkDim)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(step.instruction)
                        .font(Theme.text(15, .semibold))
                        .foregroundColor(isDone ? Theme.inkDim : Theme.ink)
                        .strikethrough(isDone, color: Theme.inkFaint)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)

                    if let detail = step.detail {
                        Text(detail)
                            .font(Theme.caption)
                            .foregroundColor(Theme.inkDim)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    if step.highlights != nil {
                        Text(isActive ? "shown on the diagram above" : "tap to locate on the diagram")
                            .font(Theme.mono(9, .medium))
                            .foregroundColor(isActive ? Theme.magenta : Theme.inkFaint)
                    }
                }
                Spacer(minLength: 0)
            }
            .padding(13)
            .frame(maxWidth: .infinity, alignment: .leading)
            .panel(stroke: isActive ? Theme.magenta.opacity(0.6) : Theme.hairline)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
