//
//  GithubUser.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/14.
//

import Foundation

public struct GithubUser: Codable {
    let name: String
    let bio: String?
    let publicRepos: Int
    let followers: Int
    
    enum CodingKeys: String, CodingKey {
      case name, bio, followers
      case publicRepos = "public_repos"
    }
}
