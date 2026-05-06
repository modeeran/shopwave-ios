import CoreData
import Network

@Observable
final class CacheRepository {
    private let context: NSManagedObjectContext
    private let monitor = NWPathMonitor()
    private(set) var isOffline = false

    init(context: NSManagedObjectContext) {
        self.context = context
        monitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                self?.isOffline = path.status == .unsatisfied
            }
        }
        monitor.start(queue: .global(qos: .utility))
    }

    func cachedProducts() throws -> [CachedProduct] {
        let req = CachedProduct.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: "viewedAt", ascending: false)]
        req.fetchLimit = 50
        return try context.fetch(req)
    }
}
