//
//  FrequentlyUsedCollectionViewCell.swift
//  CompositionalLayout
//
//  Created by User on 04.06.25.
//

import UIKit
class FrequentlyUsedCollectionViewCell: UICollectionViewCell {
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.height.equalTo(67)
        }
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func configure(iconName: String, title: String) {
        iconImageView.image = UIImage(named: iconName)
        titleLabel.text = title
    }
}
