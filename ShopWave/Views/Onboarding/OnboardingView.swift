import SwiftUI

struct OnboardingPage {
    let image: String
    let title: String
    let subtitle: String
}

private let pages: [OnboardingPage] = [
    .init(image: "bag.fill",      title: "Browse & Discover",  subtitle: "Explore thousands of products"),
    .init(image: "bolt.fill",     title: "Fast Checkout",      subtitle: "Save addresses and pay in one tap"),
    .init(image: "location.fill", title: "Track Your Orders",  subtitle: "Real-time updates from dispatch to door"),
]

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var currentPage = 0

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(pages.indices, id: \.self) { i in
                OnboardingPageView(page: pages[i])
                    .tag(i)
                    .overlay(alignment: .bottom) {
                        if i == pages.count - 1 {
                            Button("Get Started") { hasSeenOnboarding = true }
                                .buttonStyle(.borderedProminent).padding(.bottom, 48)
                        }
                    }
            }
        }
        .tabViewStyle(.page)
        .overlay(alignment: .topTrailing) {
            Button("Skip") { hasSeenOnboarding = true }.padding()
        }
    }
}
