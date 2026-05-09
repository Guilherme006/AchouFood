
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var deliveryScenesCoordinator: DeliveryScenesCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        StorageManager.shared.save(value: "Av. das Estrelas, 567 - Canela, RS", forKey: "userAddress")
        let window = UIWindow(windowScene: windowScene)
        self.deliveryScenesCoordinator = DeliveryScenesCoordinator()
        window.rootViewController = self.deliveryScenesCoordinator?.start()
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

