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
    static let sharedManager = AppManager(useCaseProvider: DefaultUseCaseProvider())
    static let stubManager = AppManager(useCaseProvider: StubUseCaseProvider())
    
    private let networkUseCaseProvider: UseCaseProvider
    
    private init(useCaseProvider: UseCaseProvider) {
        self.networkUseCaseProvider = useCaseProvider
    }
    
    func configureMainInterface(in window: UIWindow?) {
        let useCase = networkUseCaseProvider.makeGithubUseCase()
        let userInfoViewReactor = UserInfoViewReactor(useCase: useCase)
        let userInfoViewController = UserInfoViewController(reactor: userInfoViewReactor).then {
            $0.tabBarItem = UITabBarItem(
                title: "User Info",
                image: UIImage(systemName: "person.fill"),
                tag: 0)
        }
        let repositoryViewReactor = RepositoryViewReactor(useCase: useCase)
        let repositoryViewController = RepositoryViewController(
            reactor: repositoryViewReactor
        ).then {
            $0.tabBarItem = UITabBarItem(
                title: "Repository",
                image: UIImage(systemName: "list.bullet"),
                tag: 1)
        }
        
        let tabBarController = UITabBarController()
        tabBarController.view.backgroundColor = .systemBackground
        tabBarController.setViewControllers([userInfoViewController, repositoryViewController], animated: false)
        tabBarController.tabBar.backgroundColor = .systemGray5
        
        window?.rootViewController = tabBarController
    }
}
