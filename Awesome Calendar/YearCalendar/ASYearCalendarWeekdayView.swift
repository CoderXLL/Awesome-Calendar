//
//  ASYearCalendarWeekdayView.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/19.
//

import Foundation
import FSCalendar

class ASYearCalendarWeekdayView: UIView {
    var calendar: NSCalendar? {
        didSet {
            let weekdaySymbols = calendar?.veryShortWeekdaySymbols
            for (i, label) in contentView.subviews.enumerated() {
                if label is UILabel {
                    (label as! UILabel).text = weekdaySymbols?[i].uppercased()
                }
            }
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
        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        var lastLabel: UILabel?
        for _ in 0 ..< 7 {
            let weekdayLabel = UILabel()
            weekdayLabel.textAlignment = .center
            weekdayLabel.textColor = .lightGray
            weekdayLabel.font = .fontWithSize(10, .regular)
            contentView.addSubview(weekdayLabel)
            weekdayLabel.snp.makeConstraints {
                $0.width.equalToSuperview().multipliedBy(1 / 7.0)
                $0.top.height.equalToSuperview()
                if let lastLabel = lastLabel {
                    $0.leading.equalTo(lastLabel.snp.trailing)
                } else {
                    $0.leading.equalToSuperview()
                }
            }
            lastLabel = weekdayLabel
        }
    }
    
    // MARK: - lazy loading
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
}
