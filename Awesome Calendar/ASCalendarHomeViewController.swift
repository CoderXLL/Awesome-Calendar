//
//  ASCalendarHomeViewController.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/15.
//

import Foundation
import SnapKit
import FSCalendar

class ASCalendarHomeViewController: ASBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    // MARK: - private methods
    private func makeUI() {
        let button: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("进入", for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
            return button
        }()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc private func onButtonClick() {
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - lazy loading
    private lazy var calendarView: FSCalendar = {
        let calendar = FSCalendar()
        calendar.delegate = self
        calendar.dataSource = self
        calendar.allowsSelection = true
        calendar.pagingEnabled = false
        calendar.locale = Locale(identifier: "zh-CN")
        calendar.adjustsBoundingRectWhenChangingMonths = true
        calendar.placeholderType = .none
        calendar.appearance.caseOptions = [.weekdayUsesSingleUpperCase, .headerUsesUpperCase]
        calendar.appearance.separators = .interRows
        return calendar
    }()
}

extension ASCalendarHomeViewController: FSCalendarDelegateAppearance, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
