//
//  GithubRepository.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/14.
//

import Foundation

public struct GithubRepository: Codable {
    let name: String
    let description: String?
    let language: String?
    let svnURL: String?
    
    enum CodingKeys: String, CodingKey {
      case name, description, language
      case svnURL = "svn_url"
    }
}
