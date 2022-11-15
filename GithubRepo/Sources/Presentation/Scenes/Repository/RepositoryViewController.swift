//
//  RepositoryViewController.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/15.
//

import UIKit

import ReactorKit
import RxSwift
import SnapKit
import Then

final class RepositoryViewController: UIViewController, View {
    
    // MARK: Properties
    
    var disposeBag = DisposeBag()

    
    lazy var tableViewLabel = UILabel().then {
        let userName = self.reactor?.userName ?? "user"
        $0.text = "\(userName)'s repos"
        $0.textAlignment = .left
    }
    
    let label = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "RepositoryVC"
    }
    
    // MARK: Initializing
    
    init(reactor: RepositoryViewReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableViewLabel)
        view.addSubview(label)
        setupConstraints()
    }
    
    // MARK: Methods
    
    func setupConstraints() {
        tableViewLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(30)
            make.height.equalTo(20)
        }
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func bind(reactor: RepositoryViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
}

// MARK: - Bind

private extension RepositoryViewController {
    func bindAction(_ reactor: RepositoryViewReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    func bindState(_ reactor: RepositoryViewReactor) {
        reactor.state.asObservable()
            .map {
                $0.repositories
                    .map { "\($0.name), \($0.language ?? "")"}
                    .joined(separator: "\n")
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}
