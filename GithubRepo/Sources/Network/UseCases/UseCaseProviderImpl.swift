//
//  UseCaseProvider.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/14.
//

import Foundation

public final class DefaultUseCaseProvider { }

public final class StubUseCaseProvider: UseCaseProvider {
    public func makeGithubUseCase() -> GithubUseCase {
        return StubGithubUseCase()
    }

}
