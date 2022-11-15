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
    var disposeBag = DisposeBag()
    
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
        
        let label = UILabel().then {
            $0.text = "UserInfoVC"
        }
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func bind(reactor: UserInfoViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
}

// MARK: - Bind

private extension UserInfoViewController {
    func bindAction(_ reactor: UserInfoViewReactor) {
        
    }
    
    func bindState(_ reactor: UserInfoViewReactor) {
        
    }
}
