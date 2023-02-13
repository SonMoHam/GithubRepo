//
//  RepositoryCell.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/16.
//

import UIKit

import Then
import ReactorKit
import RxSwift
import SnapKit

final class RepositoryCell: UITableViewCell {
    // MARK: Constants
    
    private struct Metric {
        static let contentMargin: CGFloat = 10
        static let contentSpacing: CGFloat = 10
    }
    
    // MARK: Properties
    
    let titleLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.text = "repo title"
    }
    
    let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "repo description"
    }
    
    let languageLabel = UILabel().then {
        $0.text = "repo language"
    }
    
    // MARK: Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(languageLabel)
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    // 단순 표시 용이라면 configure, 동작 or 조작 추가된다면 reactor 통해 state 받아야 할 것
    func configure(_ repo: GithubRepository) {
        self.titleLabel.text = repo.name
        self.descriptionLabel.text = repo.description ?? "no description"
        self.languageLabel.text = repo.language ?? "no language"
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(Metric.contentMargin)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Metric.contentSpacing)
            make.left.right.equalToSuperview().inset(Metric.contentMargin)
        }
        languageLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(Metric.contentSpacing)
            make.left.right.bottom.equalToSuperview().inset(Metric.contentMargin)
        }
    }
}
