import SwiftUI
import UIKit

@main
struct DAWLearnApp: App {
    @StateObject private var state = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(state)
                .preferredColorScheme(.dark)
                .tint(state.daw.accent)
        }
    }
}

struct RootView: View {
    @EnvironmentObject private var state: AppState

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Theme.panel)
        appearance.shadowColor = UIColor(Theme.hairline)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance

        let nav = UINavigationBarAppearance()
        nav.configureWithOpaqueBackground()
        nav.backgroundColor = UIColor(Theme.void)
        nav.shadowColor = UIColor(Theme.hairline)
        nav.titleTextAttributes = [.foregroundColor: UIColor(Theme.ink)]
        nav.largeTitleTextAttributes = [.foregroundColor: UIColor(Theme.ink)]
        UINavigationBar.appearance().standardAppearance = nav
        UINavigationBar.appearance().scrollEdgeAppearance = nav
    }

    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "square.grid.2x2") }

            MapListView()
                .tabItem { Label("Screens", systemImage: "rectangle.3.group") }

            WalkthroughListView()
                .tabItem { Label("How-to", systemImage: "list.number") }

            LearnView()
                .tabItem { Label("Learn", systemImage: "book") }

            SearchView()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
        }
    }
}
