//
//  AppManager.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/15.
//

import Foundation

final class AppManager {
    static let sharedManager = AppManager(isTest: false)
    static let stubManager = AppManager(isTest: true)
    
    private let networkUseCaseProvider: UseCaseProvider
    
    private init(isTest: Bool) {
            networkUseCaseProvider = StubUseCaseProvider()
        // TODO: if isTest 따라서 Provider 생성
    }
}
