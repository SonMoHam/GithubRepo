//
//  RepositoryViewReactor.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/15.
//

import ReactorKit
import RxSwift

public final class RepositoryViewReactor: Reactor {
    
    public enum Action {
        case refresh
    }
    
    public enum Mutation {
        case setRepositories([GithubRepository])
    }
    
    public struct State {
        var repositories: [GithubRepository]
    }
    
    let userName = "sonmoham"
    public let initialState: State
    let useCase: GithubUseCase
    
    public init(useCase: GithubUseCase) {
        self.initialState = State(repositories: [])
        self.useCase = useCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return self.useCase.fetchRepositories(of: userName)
                .catchAndReturn([])
                .map { .setRepositories($0) }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setRepositories(let repos):
            state.repositories = repos
            return state
        }
    }
}
