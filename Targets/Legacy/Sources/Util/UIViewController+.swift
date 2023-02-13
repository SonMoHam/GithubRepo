//
//  UIViewController+.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/16.
//

import UIKit

import SnapKit
import Then

extension UIViewController {
    func showToast(
        message : String,
        font: UIFont? = UIFont.systemFont(ofSize: 14),
        bottomInset: CGFloat = UIScreen.main.bounds.height/6
    ) {
        let toastView = UIView(frame: .zero).then {
            $0.backgroundColor = .black.withAlphaComponent(0.8)
            $0.layer.cornerRadius = 15
        }
        
        let toastLabel = UILabel(frame: .zero).then {
            $0.textColor = UIColor.white
            $0.font = font
            $0.textAlignment = .center;
            $0.text = message
            $0.numberOfLines = 0
        }
        
        toastView.addSubview(toastLabel)
        self.view.addSubview(toastView)
        
        toastLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(10)
        }
        
        toastView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(bottomInset)
            $0.centerX.equalToSuperview()
            $0.width.lessThanOrEqualToSuperview().multipliedBy(0.8)
        }
        UIView.animate(
            withDuration: 2.0,
            delay: 2.0,
            options: .curveEaseOut,
            animations: {
                toastView.alpha = 0.0
            },
            completion: { isCompleted in
                toastView.removeFromSuperview()
            }
        )
    }
}
