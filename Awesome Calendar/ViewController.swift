//
//  ViewController.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/15.
//

import UIKit
import FSCalendar
import SnapKit

class ViewController: ASBaseViewController {
    
    private var showLunar: Bool = true
    private let lunarFormatter = ASLunarFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        makeUI()
    }
    
    // MARK: - private methods
    private func makeUI() {
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        view.addGestureRecognizer(scopeGesture)
        
        let lunarBtn: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("显示阴历", for: .normal)
            button.setTitle("隐藏阴历", for: .selected)
            button.setTitleColor(.RGBH(0x333333), for: .normal)
            button.setTitleColor(.lightGray, for: .selected)
            button.titleLabel?.font = .fontWithSize(14, .regular)
            button.addTarget(self, action: #selector(onLunarBtnClick(_:)), for: .touchUpInside)
            button.isSelected = true
            return button
        }()
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: lunarBtn)]
        
        if let leftBarButton = navigationItem.leftBarButtonItem?.customView as? UIButton {
            leftBarButton.setTitle(dateFormatter.string(from: calendarView.currentPage), for: .normal)
        }
    }
    
    @objc private func onLunarBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        showLunar = sender.isSelected
        calendarView.reloadData()
    }
    
    // MARK: - lazy loading
    private lazy var calendarView: FSCalendar = {
        let calendar = FSCalendar()
        calendar.delegate = self
        calendar.dataSource = self
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.headerHeight = 0
        calendar.calendarHeaderView = FSCalendarHeaderView()
        calendar.locale = Locale(identifier: "zh-CN")
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendar.appearance.weekdayTextColor = .RGBH(0x333333)
        calendar.appearance.weekdayFont = .fontWithSize(15, .medium)
        calendar.appearance.titleFont = .fontWithSize(14, .regular)
        calendar.appearance.separators = .none
        calendar.register(ASCalendarDayCell.self, forCellReuseIdentifier: "cell")
        return calendar
    }()
    
    private lazy var scopeGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: calendarView, action: #selector(self.calendarView.handleScopeGesture(_:)))
        gesture.delegate = self
        gesture.minimumNumberOfTouches = 1
        gesture.maximumNumberOfTouches = 2
        return gesture
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY年MM月"
        return formatter
    }()
    
    private lazy var holidayImage: UIImage? = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        label.textColor = .blue
        label.font = .fontWithSize(10, .regular)
        label.text = "休"
        let image = UIImage.image(view: label)
        return image
    }()
}

extension ViewController: FSCalendarDelegateAppearance, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarView.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        if let leftBarButton = navigationItem.leftBarButtonItem?.customView as? UIButton {
            leftBarButton.setTitle(dateFormatter.string(from: calendar.currentPage), for: .normal)
        }
    }
    
    // 农历
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        guard showLunar else {
            return nil
        }
        return lunarFormatter.string(from: date)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: 2.5)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: 5.5)
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let day: Int! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)?.component(.day, from: date)
        return [13,24].contains(day) ? holidayImage : nil
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 20, y: -20)
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let velocity = scopeGesture.velocity(in: view)
        switch calendarView.scope {
        case .month:
            return velocity.y < 0
        case .week:
            return velocity.y > 0
        @unknown default:
            fatalError("unkonwn error")
        }
    }
}


