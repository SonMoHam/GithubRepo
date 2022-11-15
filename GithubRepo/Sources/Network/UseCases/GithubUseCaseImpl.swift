//
//  GithubUseCase.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/14.
//

import Foundation
import RxSwift

public final class DefaultGithubUseCase { }

// TODO: 더미 엔티티 반환

public final class StubGithubUseCase: GithubUseCase {
    
    public func fetchUser(name: String) -> Observable<GithubUser> {
        let dummyUser = GithubUser(name: "sonmo", followers: 12)
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
                language: "Swift"),
            GithubRepository(
                name: "Repo 2",
                description: "This is second repo.",
                language: "Objective-C"),
            GithubRepository(
                name: "Repo 3",
                description: "This is third repo.",
                language: "Python"),
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
