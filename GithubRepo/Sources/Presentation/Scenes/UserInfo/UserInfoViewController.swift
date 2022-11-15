//
//  UserInfoViewController.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/15.
//

import UIKit

import ReactorKit
import RxSwift
import SnapKit
import Then

final class UserInfoViewController: UIViewController, View {
    
    // MARK: Properties
    
    var disposeBag = DisposeBag()
    let label = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "UserInfoVC"
    }
    
    // MARK: Initializing
    
    init(reactor: UserInfoViewReactor) {
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
        self.view.addSubview(label)
        setupConstraints()
    }
    
    // MARK: Methods

    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func bind(reactor: UserInfoViewReactor) {
        print(#function)
        bindAction(reactor)
        bindState(reactor)
    }
}

// MARK: - Bind

private extension UserInfoViewController {
    func bindAction(_ reactor: UserInfoViewReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    func bindState(_ reactor: UserInfoViewReactor) {
        reactor.state.asObservable()
            .map { "userName: \($0.user?.name ?? "user") followers: \(($0.user?.followers ?? 0))" }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}
