//
//  GithubEndpoints.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/15.
//

import Foundation

final class GithubEndpoints {
    private let baseURL = "https://api.github.com"
    
    func getUser(name: String) -> Endpoint<GithubUser> {
        return Endpoint(
            baseURL: baseURL,
            path: "users/\(name)",
            method: .get)
    }
    
    func getRepos(userName: String) -> Endpoint<[GithubRepository]> {
        return Endpoint(
            baseURL: baseURL,
            path: "users/\(userName)/repos",
            method: .get,
            queryParameters: ["sort": "updated", "per_page": 10])
    }
}
