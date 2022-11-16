//
//  RepositoryViewReactor.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/15.
//

import ReactorKit
import RxSwift

final class RepositoryViewReactor: Reactor {
    
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setRepositories([GithubRepository])
    }
    
    struct State {
        var repositories: [GithubRepository]
    }
    
    let userName = "sonmoham"
    let initialState: State
    let useCase: GithubUseCase
    
    init(useCase: GithubUseCase) {
        self.initialState = State(repositories: [])
        self.useCase = useCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return self.useCase.fetchRepositories(of: userName)
                .catchAndReturn([])
                .map { .setRepositories($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setRepositories(let repos):
            state.repositories = repos
            return state
        }
    }
}
