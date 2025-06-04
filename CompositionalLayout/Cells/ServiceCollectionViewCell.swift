//
//  ServiceCollectionViewCell.swift
//  CompositionalLayout
//
//  Created by User on 04.06.25.
//

import Foundation
import UIKit
import SnapKit

class ServiceCollectionViewCell: UICollectionViewCell {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = .white
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.addSubview(iconImageView)
        iconImageView.image = UIImage(systemName: "creditcard")
        iconImageView.tintColor = .systemBlue
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }
        containerView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
        if title == "Open Account" {
            iconImageView.image = .open
        } else if title == "Manage Cards" {
            iconImageView.image = .manage
        }
    }
}
