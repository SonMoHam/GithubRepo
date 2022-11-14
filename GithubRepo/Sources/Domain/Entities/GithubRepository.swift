//
//  GithubRepository.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/14.
//

import Foundation

public struct GithubRepository: Decodable {
    let name: String
    let description: String?
    let language: String?
}
