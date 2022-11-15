//
//  UserInfoViewReactor.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/15.
//

import ReactorKit
import RxSwift

final class UserInfoViewReactor: Reactor {
    
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setUser(GithubUser)
    }
    
    struct State {
        var user: GithubUser?
    }
    
    let userName = "sonmoham"
    let initialState: State
    let useCase: GithubUseCase
    
    init(useCase: GithubUseCase) {
        self.initialState = State(user: nil)
        self.useCase = useCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return self.useCase.fetchUser(name: userName)
                .map { .setUser($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setUser(let user):
            state.user = user
            return state
        }
    }
}
