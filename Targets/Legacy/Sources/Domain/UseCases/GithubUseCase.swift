//
//  GithubUseCase.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/14.
//

import Foundation
import RxSwift

public protocol GithubUseCase {
    func fetchUser(name: String) -> Observable<GithubUser>
    func fetchRepositories(of userName: String) -> Observable<[GithubRepository]>
}

