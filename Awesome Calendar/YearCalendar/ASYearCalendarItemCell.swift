//
//  ASYearCalendarItemCell.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/18.
//

import Foundation
import UIKit
import FSCalendar

class ASYearCalendarItemCell: UICollectionViewCell {
    private struct LayoutConstant {
        static let itemSpacing: CGFloat = 0
        static let lineSpacing: CGFloat = 0
        static let itemSize: CGSize = CGSize(width: 20, height: 20)
        static let cellId: String = "ASYearCalendarItemCell.cellId"
    }
    private var monthDate: NSDate?
    private var monthHeadDate: NSDate?
    private var calculator: ASYearCalendarCalculator? {
        didSet {
            weekDayView.calendar = (calculator?.getCurrentCalendar() as? NSCalendar)
        }
    }
    // MARK: - life circle
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods
    private func makeUI() {
        contentView.addSubview(monthLabel)
        contentView.addSubview(weekDayView)
        contentView.addSubview(collectionView)
        monthLabel.snp.makeConstraints {
            $0.leading.equalTo(5)
            $0.top.equalToSuperview()
        }
        weekDayView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(monthLabel.snp.bottom)
            $0.height.equalTo(20)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(weekDayView.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - public methods
    public func set(monthDate: NSDate, monthHeadDate: NSDate, calculator: ASYearCalendarCalculator) {
        self.monthDate = monthDate
        self.monthHeadDate = monthHeadDate
        self.calculator = calculator
        
        let attributedString = NSMutableAttributedString(string: monthFormatter.string(from: monthDate as Date), attributes: [
            .font: UIFont.fontWithSize(22, .semibold),
            .foregroundColor: UIColor.RGBH(0x333333)
        ])
        attributedString.append(NSAttributedString(string: "月", attributes: [
            .font: UIFont.fontWithSize(10),
            .foregroundColor: UIColor.asLightGray,
        ]))
        monthLabel.attributedText = attributedString
        collectionView.reloadData()
    }
    
    // MARK: - lazy loading
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumInteritemSpacing = LayoutConstant.itemSpacing
        layout.minimumLineSpacing = LayoutConstant.lineSpacing
        layout.itemSize = LayoutConstant.itemSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.panGestureRecognizer.isEnabled = false
        collectionView.isUserInteractionEnabled = false
        collectionView.bounces = false
        collectionView.register(FSCalendarCell.self, forCellWithReuseIdentifier: LayoutConstant.cellId)
        return collectionView
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private lazy var weekDayView: ASYearCalendarWeekdayView = {
        let weekDayView = ASYearCalendarWeekdayView()
        return weekDayView
    }()
    
    private lazy var monthFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M"
        return dateFormatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
}

extension ASYearCalendarItemCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        42
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 7.0 - 1.0, height: collectionView.width / 7.0 - 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LayoutConstant.cellId, for: indexPath)
        guard let cell = cell as? FSCalendarCell, let monthHeadDate = monthHeadDate, let monthDate = monthDate else {
            return cell
        }
        cell.titleLabel.font = .fontWithSize(9, .regular)
        if let dayDate = calculator?.dayDate(forMonthDate: monthHeadDate as Date, row: indexPath.item),
           let placeholders = calculator?.numberOfHeadPlaceholders(forMonth: monthDate as Date),
           indexPath.item >= placeholders,
           let numberOfDaysInMonth = calculator?.numberOfDays(inMonth: monthDate as Date),
           indexPath.item < placeholders + numberOfDaysInMonth {
            cell.titleLabel.text = dayFormatter.string(from: dayDate)
        } else {
            cell.titleLabel.text = ""
        }
        return cell
    }
    
    
}
