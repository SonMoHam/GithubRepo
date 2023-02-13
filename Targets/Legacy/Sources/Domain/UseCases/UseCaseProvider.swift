//
//  UseCaseProvider.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/14.
//

import Foundation

public protocol UseCaseProvider {
    func makeGithubUseCase() -> GithubUseCase
}
