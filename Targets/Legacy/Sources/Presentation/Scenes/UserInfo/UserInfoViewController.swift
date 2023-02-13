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

public final class UserInfoViewController: UIViewController, View {
    
    // MARK: Properties
    
    public var disposeBag = DisposeBag()
    let label = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "UserInfoVC"
    }
    
    // MARK: Initializing
    
    public init(reactor: UserInfoViewReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    
    public override func viewDidLoad() {
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
    
    public func bind(reactor: UserInfoViewReactor) {
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
            .map {
                let userName = "userName: \($0.user?.name ?? "user")"
                let bio = "bio: \($0.user?.bio ?? "bio")"
                let publicRepos = "publicRepos: \($0.user?.publicRepos ?? 0)"
                let followers = "followers: \(($0.user?.followers ?? 0))"
                
                return "\(userName)\n\(bio)\n\(publicRepos)\n\(followers)"
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}
