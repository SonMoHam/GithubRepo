//
//  RepositoryViewController.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/15.
//

import SafariServices
import UIKit

import ReactorKit
import RxSwift
import SnapKit
import Then

public final class RepositoryViewController: UIViewController, View {
    
    // MARK: Constants
    
    private struct Metric {
        static let verticalMargin: CGFloat = 50
        static let horizontalMargin: CGFloat = 30
    }
    
    // MARK: Properties
    
    public var disposeBag = DisposeBag()
    
    lazy var tableViewLabel = UILabel().then {
        let userName = self.reactor?.userName ?? "user"
        $0.text = "\(userName)'s repos"
        $0.textAlignment = .left
    }
    
    let tableView = UITableView().then {
        $0.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.reuseIdentifier)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.systemGray6.cgColor
        $0.layer.cornerRadius = 5
    }
    
    // MARK: Initializing
    
    public init(reactor: RepositoryViewReactor) {
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
        view.addSubview(tableViewLabel)
        view.addSubview(tableView)
        setupConstraints()
    }
    
    // MARK: Methods
    
    func setupConstraints() {
        tableViewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Metric.verticalMargin)
            make.left.right.equalToSuperview().inset(Metric.horizontalMargin)
            make.height.equalTo(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tableViewLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(Metric.horizontalMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Metric.verticalMargin)
        }
    }
    
    public func bind(reactor: RepositoryViewReactor) {
        bindView(reactor)
        bindAction(reactor)
        bindState(reactor)
    }
}

// MARK: - Bind

private extension RepositoryViewController {
    func bindView(_ reactor: RepositoryViewReactor) {
        self.tableView.rx
            .modelSelected(GithubRepository.self)
            .withUnretained(self)
            .bind { (owner, repository) in
                guard let urlString = repository.svnURL, let url = URL(string: urlString)
                else { return }
                let safariVC = SFSafariViewController(url: url).then {
                    $0.modalTransitionStyle = .coverVertical
                    $0.modalPresentationStyle = .pageSheet
                }
                owner.present(safariVC, animated: true)
                
            }.disposed(by: disposeBag)
    }
    
    func bindAction(_ reactor: RepositoryViewReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    func bindState(_ reactor: RepositoryViewReactor) {
        reactor.state.asObservable()
            .map { $0.repositories }
            .do { [weak self] in
                if $0.isEmpty {
                    self?.parent?.showToast(message: "no result")
                }
            }
            .bind(to: tableView.rx.items) { (tableView, index, element) in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RepositoryCell.reuseIdentifier) as? RepositoryCell
                else { return UITableViewCell() }
                cell.configure(element)
                return cell
            }.disposed(by: disposeBag)
    }
}
