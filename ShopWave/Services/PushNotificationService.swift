import UserNotifications
import UIKit

@MainActor
final class PushNotificationService: NSObject {
    static let shared = PushNotificationService()

    func requestPermission() async -> Bool {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        return (try? await UNUserNotificationCenter.current()
            .requestAuthorization(options: options)) ?? false
    }

    func registerForRemoteNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
    }

    func handleDeviceToken(_ data: Data) {
        let token = data.map { String(format: "%02x", $0) }.joined()
        Task {
            try? await APIClient.shared.post("/notifications/device-token",
                                             body: ["token": token, "platform": "ios"])
        }
    }
}
