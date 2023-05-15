//
//  SceneDelegate.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var coordinator: MainCoordinator?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let navController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
        
        self.window = window
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
}

