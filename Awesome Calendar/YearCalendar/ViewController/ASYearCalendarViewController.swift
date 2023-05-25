//
//  ASYearCalendarViewController.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/17.
//

import Foundation
import UIKit
import FSCalendar

class ASYearCalendarViewController: ASBaseViewController {
    private struct LayoutConstant {
        static let itemSpacing: CGFloat = 8
        static let headerSize: CGSize = CGSize(width: UIScreen.main.bounds.size.width, height: 50)
        static let edgeSpacing: CGFloat = 5
        static let cellId: String = "ASYearCalendarViewController.cellId"
        static let headerId: String = "ASYearCalendarViewController.headerId"
    }
    
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
        
        let button: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("切换布局", for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
            return button
        }()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc private func onButtonClick() {
//        let viewController = ASTestHorizontalViewController()
//        navigationController?.pushViewController(viewController, animated: true)
        if collectionView.collectionViewLayout == verticalLayout {
            collectionView.setCollectionViewLayout(self.horizontalLayout, animated: false)
            collectionView.decelerationRate = .fast
//            perform(#selector(simulateScroll), with: nil, afterDelay: 0.5)
        } else {
            collectionView.setCollectionViewLayout(verticalLayout, animated: false)
            collectionView.decelerationRate = .normal
        }
    }
    
    
    @objc private func simulateScroll() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(simulateScroll), object: nil)
        collectionView.setContentOffset(CGPoint(x: collectionView.contentOffset.x + 100, y: collectionView.contentOffset.y), animated: true)
        perform(#selector(lala), with: nil, afterDelay: 0.35)
    }
    
    @objc private func lala() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(lala), object: nil)
        collectionView.setContentOffset(CGPoint(x: 0, y: collectionView.contentOffset.y), animated: true)
    }
    
    // MARK: - lazy loading
    private lazy var verticalLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumInteritemSpacing = LayoutConstant.itemSpacing
        layout.minimumLineSpacing = LayoutConstant.itemSpacing
        layout.headerReferenceSize = LayoutConstant.headerSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: LayoutConstant.edgeSpacing, bottom: 0, right: LayoutConstant.edgeSpacing)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 2 * LayoutConstant.itemSpacing - 2 * LayoutConstant.edgeSpacing - 1) / 3.0, height: 150)
        return layout
    }()
    
    private lazy var horizontalLayout: ASYearHorizontalLayout = {
        let layout = ASYearHorizontalLayout()
        layout.rowCount = 4
        layout.itemCountPerRow = 3
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = LayoutConstant.itemSpacing
        layout.minimumLineSpacing = LayoutConstant.itemSpacing
        layout.headerReferenceSize = LayoutConstant.headerSize
        layout.edgeSpacing = LayoutConstant.edgeSpacing
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 2 * LayoutConstant.itemSpacing - 2 * LayoutConstant.edgeSpacing) / 3.0, height: 150)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: verticalLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.decelerationRate = .normal
        collectionView.register(ASYearCalendarItemCell.self, forCellWithReuseIdentifier: LayoutConstant.cellId)
        collectionView.register(ASTestCell.self, forCellWithReuseIdentifier: "lala")
        collectionView.register(ASYearCalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LayoutConstant.headerId)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        return collectionView
    }()
    
    private lazy var calculator: ASYearCalendarCalculator = {
        let calculator = ASYearCalendarCalculator()
        return calculator
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter
    }()
}

extension ASYearCalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return calculator.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reuseableView: UICollectionReusableView = UICollectionReusableView.init()
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LayoutConstant.headerId, for: indexPath)
            guard let headerView = headerView as? ASYearCalendarHeaderView else {
                return headerView
            }
            let year = calculator.yearHead(forSection: indexPath.section)
            headerView.setup(title: dateFormatter.string(from: year) + "年", subTitle: calculator.lunnarYearString(Int(dateFormatter.string(from: year)) ?? 0))
            reuseableView = headerView
        }
        return reuseableView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LayoutConstant.cellId, for: indexPath)
        guard let cell = cell as? ASYearCalendarItemCell else {
            return cell
        }
        let monthDate = calculator.monthDate(for: indexPath)
        let monthHeadDate = calculator.monthHeadDate(for: indexPath)
        cell.set(monthDate: monthDate as NSDate, monthHeadDate: monthHeadDate as NSDate, calculator: calculator)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = ASCalendarHomeViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
