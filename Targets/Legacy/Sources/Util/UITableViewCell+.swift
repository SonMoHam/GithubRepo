//
//  UITableViewCell+.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/16.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
