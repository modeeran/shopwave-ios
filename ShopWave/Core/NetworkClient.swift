import Foundation

actor NetworkClient {
    static let shared = NetworkClient()
    private let session = URLSession.shared
    private let baseURL = URL(string: ProcessInfo.processInfo.environment["API_BASE_URL"]
                              ?? "https://api.shopwave.io")!

    func get<T: Decodable>(_ path: String) async throws -> T {
        let request = URLRequest(url: baseURL.appendingPathComponent(path))
        let (data, _) = try await session.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
