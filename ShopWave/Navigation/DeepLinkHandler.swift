import SwiftUI

enum DeepLink {
    case product(slug: String)
    case order(id: String)
    case category(slug: String)
    case profile
}

struct DeepLinkHandler {
    static func resolve(_ url: URL) -> DeepLink? {
        let path = url.path
        let components = path.split(separator: "/").map(String.init)
        switch components.first {
        case "products":  return components.count > 1 ? .product(slug: components[1]) : nil
        case "orders":    return components.count > 1 ? .order(id: components[1]) : nil
        case "categories": return components.count > 1 ? .category(slug: components[1]) : nil
        case "profile":   return .profile
        default:          return nil
        }
    }
}
