import SwiftUI

/// A button that guarantees minimum touch target size and correct accessibility traits.
struct AccessibleButton<Label: View>: View {
    let action: () -> Void
    let label: () -> Label
    var accessibilityLabel: String
    var accessibilityHint: String = ""

    var body: some View {
        Button(action: action) {
            label()
                .frame(minWidth: 44, minHeight: 44)
        }
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint)
    }
}
