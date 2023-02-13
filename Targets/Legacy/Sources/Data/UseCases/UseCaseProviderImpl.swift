//
//  UseCaseProvider.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/14.
//

import Foundation

public final class DefaultUseCaseProvider: UseCaseProvider {
    private let endpointsProvider: EndpointsProvider
    private let networkService: NetworkService  // ???: Provider로 변경
    
    public init() {
        endpointsProvider = EndpointsProvider()
        networkService = AFNetworkService()
    }
    
    public func makeGithubUseCase() -> GithubUseCase {
        let endpoints = endpointsProvider.makeGithubEndpoints()
        return DefaultGithubUseCase(networkService: networkService, endpoints: endpoints)
    }
}

public final class StubUseCaseProvider: UseCaseProvider {
    public init() {
        
    }
    public func makeGithubUseCase() -> GithubUseCase {
        return StubGithubUseCase()
    }

}
