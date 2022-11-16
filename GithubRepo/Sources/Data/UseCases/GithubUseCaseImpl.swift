//
//  GithubUseCase.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/14.
//

import Foundation
import RxSwift

public final class DefaultGithubUseCase: GithubUseCase {
    
    private let networkService: NetworkService
    private let endpoints: GithubEndpoints
    
    init(networkService: NetworkService, endpoints: GithubEndpoints) {
        self.networkService = networkService
        self.endpoints = endpoints
    }
    
    public func fetchUser(name: String) -> Observable<GithubUser> {
        let endpoint = endpoints.getUser(name: name)
        return Observable.create { [weak self] observer -> Disposable in
            self?.networkService.request(with: endpoint) { result in
                switch result {
                case .success(let decodable):
                    observer.onNext(decodable)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    public func fetchRepositories(of userName: String) -> Observable<[GithubRepository]> {
        let endpoint = endpoints.getRepos(userName: userName)
        return Observable.create { [weak self] observer -> Disposable in
            self?.networkService.request(with: endpoint) { result in
                switch result {
                case .success(let decodable):
                    observer.onNext(decodable)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}

// TODO: 더미 엔티티 반환

public final class StubGithubUseCase: GithubUseCase {
    
    public func fetchUser(name: String) -> Observable<GithubUser> {
        let dummyUser = GithubUser(
            name: "dummy " + name, bio: "iOS junior", publicRepos: 1, followers: 1)
        return Observable.create { observer -> Disposable in
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
                print("\(#file) \(#function)")
                observer.onNext(dummyUser)
            }
            return Disposables.create()
        }
    }
    
    public func fetchRepositories(of userName: String) -> Observable<[GithubRepository]> {
        let dummyRepos: [GithubRepository] = [
            GithubRepository(
                name: "Repo 1",
                description: "This is first repo.",
                language: "Swift",
                svnURL: nil),
            GithubRepository(
                name: "Repo 2",
                description: "This is second repo.",
                language: "Objective-C",
                svnURL: nil),
            GithubRepository(
                name: "Repo 3",
                description: "This is third repo.",
                language: "Python",
                svnURL: nil),
        ]
        return Observable.create { observer -> Disposable in
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
                print("\(#file) \(#function)")
                observer.onNext(dummyRepos)
            }
            return Disposables.create()
        }

    }
}
