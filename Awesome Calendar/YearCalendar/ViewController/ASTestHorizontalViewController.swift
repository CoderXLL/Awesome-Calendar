//
//  ASTestHorizontalViewController.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/19.
//

import Foundation
import UIKit
import SnapKit

class ASTestHorizontalViewController: ASBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    // MARK: - private methods
    private func makeUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - lazy laoding
    private lazy var collectionView: UICollectionView = {
        let layout = ASYearHorizontalLayout()
        layout.rowCount = 4
        layout.itemCountPerRow = 3
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 50)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 2 * 8) / 3.0, height: 160)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.isPagingEnabled = false
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ASTestCell.self, forCellWithReuseIdentifier: "lala")
        collectionView.register(ASYearCalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        return collectionView
    }()
}

extension ASTestHorizontalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reuseableView: UICollectionReusableView = UICollectionReusableView.init()
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId", for: indexPath)
            guard let headerView = headerView as? ASYearCalendarHeaderView else {
                return headerView
            }
            headerView.setup(title: "我是第\(indexPath.section)组", subTitle: nil)
            headerView.backgroundColor = .random()
            reuseableView = headerView
        }
        return reuseableView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lala", for: indexPath)
        guard let cell = cell as? ASTestCell else {
            return cell
        }
        cell.set(item: indexPath.item, section: indexPath.section)
        cell.backgroundColor = .random()
        return cell
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let offsetX = scrollView.contentOffset.x
//        let pageWidth = scrollView.bounds.size.width
//        let currentPage = Int(floor((offsetX - pageWidth / 2) / pageWidth)) + 1
//        scrollView.setContentOffset(CGPoint(x: CGFloat(currentPage) * (self.view.bounds.size.width + 20), y: 0), animated: true)
//    }
    
}

