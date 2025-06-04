//
//  DashboardViewController.swift
//  CompositionalLayout
//
//  Created by User on 04.06.25.
//

import Foundation
import UIKit
import SnapKit
class DashboardViewController: UIViewController {
    
    private let viewModel = DashboardViewModel()
    
    private var cardCollectionView: UICollectionView!
    private var frequentlyUsedCollectionView: UICollectionView!
    private var serviceCollectionView: UICollectionView!
    private let frequentlyUsedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Frequently Used"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let servicesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Services"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(frequentlyUsedTitleLabel)
        view.addSubview(servicesTitleLabel)
        
        setupCardCollectionView()
        setupFrequentlyUsedCollectionView()
        setupServiceCollectionView()
        setupConstraints()
    }
    
    private func setupCardCollectionView() {
        let layout = createHorizontalCardLayout()
        cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cardCollectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCell")
        cardCollectionView.dataSource = self
        cardCollectionView.isPagingEnabled = true
        cardCollectionView.backgroundColor = .white
        view.addSubview(cardCollectionView)
    }
    
    private func setupFrequentlyUsedCollectionView() {
        let layout = createHorizontalCompositionalLayout(itemWidth: 0.2, itemHeight: 1.0, groupHeight: 100)
        frequentlyUsedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        frequentlyUsedCollectionView.register(FrequentlyUsedCollectionViewCell.self, forCellWithReuseIdentifier: "FrequentlyUsedCell")
        frequentlyUsedCollectionView.dataSource = self
        frequentlyUsedCollectionView.backgroundColor = .white
        view.addSubview(frequentlyUsedCollectionView)
    }
    
    private func setupServiceCollectionView() {
        let layout = createHorizontalCompositionalLayout(itemWidth: 0.5, itemHeight: 1.0, groupHeight: 150)
        serviceCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        serviceCollectionView.register(ServiceCollectionViewCell.self, forCellWithReuseIdentifier: "ServiceCell")
        serviceCollectionView.dataSource = self
        serviceCollectionView.backgroundColor = .white
        view.addSubview(serviceCollectionView)
    }
    
    private func setupConstraints() {
        cardCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        frequentlyUsedTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(cardCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        frequentlyUsedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(frequentlyUsedTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        servicesTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(frequentlyUsedCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        serviceCollectionView.snp.makeConstraints { make in
            make.top.equalTo(servicesTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        
    }
    
    private func createHorizontalCardLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(327),
                                                  heightDimension: .absolute(200))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(327),
                                                   heightDimension: .absolute(200))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 10)
            return section
        }
    }
    
    private func createHorizontalCompositionalLayout(itemWidth: CGFloat, itemHeight: CGFloat, groupHeight: CGFloat) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemWidth),
                                                  heightDimension: .fractionalHeight(itemHeight))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(groupHeight))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            return section
        }
    }
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cardCollectionView {
            return viewModel.cards.count
        } else if collectionView == frequentlyUsedCollectionView {
            return viewModel.frequentlyUsed.count
        } else if collectionView == serviceCollectionView {
            return viewModel.services.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cardCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = viewModel.cards[indexPath.item]
            cell.configure(imageName: model.imageName)
            return cell
        } else if collectionView == frequentlyUsedCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrequentlyUsedCell", for: indexPath) as? FrequentlyUsedCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = viewModel.frequentlyUsed[indexPath.item]
            cell.configure(iconName: model.iconName, title: model.title)
            return cell
        } else if collectionView == serviceCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as? ServiceCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = viewModel.services[indexPath.item]
            cell.configure(title: model.title)
            return cell
        }
        return UICollectionViewCell()
    }
}
