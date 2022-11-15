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

final class RepositoryViewController: UIViewController {
    
    // MARK: Initializing
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel().then {
            $0.text = "RepositoryVC"
        }
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
