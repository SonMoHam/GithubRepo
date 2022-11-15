//
//  AppManager.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/15.
//

import Foundation
import UIKit
import Then

final class AppManager {
    static let sharedManager = AppManager(isTest: false)
    static let stubManager = AppManager(isTest: true)
    
    private let networkUseCaseProvider: UseCaseProvider
    
    private init(isTest: Bool) {
            networkUseCaseProvider = StubUseCaseProvider()
        // TODO: if isTest 따라서 Provider 생성
    }
    
    func configureMainInterface(in window: UIWindow?) {
        let userInfoViewController = UserInfoViewController().then {
            $0.view.backgroundColor = .yellow.withAlphaComponent(0.2)
            $0.tabBarItem = UITabBarItem(
                title: "User Info",
                image: UIImage(systemName: "person.fill"),
                tag: 0)
        }
        let repositoryViewController = RepositoryViewController().then {
            $0.view.backgroundColor = .red.withAlphaComponent(0.2)
            $0.tabBarItem = UITabBarItem(
                title: "Repository",
                image: UIImage(systemName: "list.bullet"),
                tag: 1)
        }
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([userInfoViewController, repositoryViewController], animated: false)
        tabBarController.tabBar.backgroundColor = .systemBackground
        
        window?.rootViewController = tabBarController
    }
}
