//
//  UserInfoViewReactor.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/15.
//

import ReactorKit
import RxSwift

public final class UserInfoViewReactor: Reactor {
    
    public enum Action {
        case refresh
    }
    
    public enum Mutation {
        case setUser(GithubUser)
    }
    
    public struct State {
        var user: GithubUser?
    }
    
    let userName = "sonmoham"
    public let initialState: State
    let useCase: GithubUseCase
    
    public init(useCase: GithubUseCase) {
        self.initialState = State(user: nil)
        self.useCase = useCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return self.useCase.fetchUser(name: userName)
                .map { .setUser($0) }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setUser(let user):
            state.user = user
            return state
        }
    }
}
