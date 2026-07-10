// LOCAL BUILD SHIM — NEVER COMMIT.
// Xcode 16.3 (iOS 18.4 SDK) has no iOS 26 `glassEffect` API, but FloatingTabBar's
// `#available(iOS 26.0, *)` branch must still compile. Mirrors the Material fallback.
#if os(iOS)
import SwiftUI

struct _LocalGlassShimStyle { static let regular = _LocalGlassShimStyle() }

extension View {
    func glassEffect(_ style: _LocalGlassShimStyle, in shape: some Shape) -> some View {
        background(.ultraThinMaterial, in: shape)
    }
}
#endif
