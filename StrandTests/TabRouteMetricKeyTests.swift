import XCTest
@testable import Strand

/// Pins the `TabRoute.metric` contract (#198): every catalog key a tab root pushes must resolve in
/// `MetricCatalog`, because an unknown key silently falls back to the catch-all Health screen —
/// a tap-through that opens the wrong page would pass every other check.
final class TabRouteMetricKeyTests: XCTestCase {

    /// The keys the Today cards (LiquidTodayView) and Trends (charge card + small multiples) push.
    /// A catalog rename must update the pushing view, not fall through to HealthView.
    func testPushedMetricKeysResolveInCatalog() {
        let pushed = [
            // LiquidTodayView cards
            "fitness_age", "vitality", "hrv", "rhr", "resp_rate", "steps_est",
            "spo2", "skin_temp", "active_kcal",
            // TrendsView charge card + small multiples
            "recovery", "strain",
        ]
        for key in pushed {
            XCTAssertNotNil(MetricCatalog.all.first { $0.key == key },
                            "TabRoute.metric(\"\(key)\") no longer resolves in MetricCatalog; the tap would silently open Health instead of the metric.")
        }
    }
}
