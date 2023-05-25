//
//  ASCalendarDayCell.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/16.
//

import Foundation
import FSCalendar

class ASCalendarDayCell: FSCalendarCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        let shapeWH = min(contentView.width, contentView.height) - 5
        shapeLayer.frame = CGRect(x: (contentView.width - shapeWH) * 0.5, y: (contentView.height - shapeWH) * 0.5, width: shapeWH, height: shapeWH)
        let path = UIBezierPath(roundedRect: shapeLayer.bounds, cornerRadius: shapeWH * 0.5).cgPath
        if path != shapeLayer.path {
            shapeLayer.path = path
        }
    }
}
