//
//  EndpointsProvider.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/15.
//

import Foundation

final class EndpointsProvider {
    public func makeGithubEndpoints() -> GithubEndpoints {
        return GithubEndpoints()
    }
}
