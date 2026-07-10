import SwiftUI

// First-hop pushes off a tab root must be VALUES so they ride the tab's `NavigationPath` and a
// re-tap of the active tab can pop them (#135/#198, Path A). Deeper links stay closure-based:
// popping the first hop pops everything above it.

/// One first-hop destination reachable from a tab root.
enum TabRoute: Hashable {
    /// The whole-day HR timeline (#979).
    case fullDayChart
    /// One metric's detail page by `MetricCatalog` key — each card opens ITS metric
    /// (2026-07-02: not the shared Health screen).
    case metric(String)
    case metricExplorer
    case workouts
    case dataSources
    case stress
    case sleep
    case health
    case hydration
    case coupled
}

extension View {
    /// Maps every `TabRoute` push to its screen. Register exactly ONCE per `NavigationStack`
    /// hosting a tab root — a double registration double-pushes (#38).
    func tabRouteDestinations() -> some View {
        navigationDestination(for: TabRoute.self) { route in
            switch route {
            case .fullDayChart: FullDayChartView()
            case .metric(let key):
                // Unknown key (theoretical): fall back to the catch-all vitals surface.
                if let m = MetricCatalog.all.first(where: { $0.key == key }) {
                    MetricDetailView(metric: m)
                } else {
                    HealthView()
                }
            case .metricExplorer: MetricExplorerView()
            case .workouts: WorkoutsView()
            case .dataSources: DataSourcesView()
            case .stress: StressView()
            case .sleep: SleepView()
            case .health: HealthView()
            case .hydration: HydrationView()
            case .coupled: CoupledView()
            }
        }
    }
}
