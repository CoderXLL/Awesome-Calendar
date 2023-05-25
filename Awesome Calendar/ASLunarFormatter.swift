//
//  ASLunarFormatter.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/15.
//

import Foundation

class ASLunarFormatter: NSObject {
    
    private let chineseCalendar = Calendar(identifier: .chinese)
    private let formatter = DateFormatter()
    private let lunarDays = ["初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","廿十","廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"]
    private let lunarMonths = ["正月","二月","三月","四月","五月","六月","七月","八月","九月","十月","冬月","腊月"]
    
    
    override init() {
        formatter.calendar = chineseCalendar
        formatter.dateFormat = "M"
    }
    
    func string(from date: Date) -> String {
        let day = chineseCalendar.component(.day, from: date)
        if day != 1 {
            return lunarDays[day-2]
        }
        // First day of month
        let monthString = formatter.string(from: date)
        if chineseCalendar.veryShortMonthSymbols.contains(monthString) {
            if let month = Int(monthString) {
                return lunarMonths[month-1]
            }
            return ""
        }
        // Leap month
        let month = chineseCalendar.component(.month, from: date)
        return "闰" + lunarMonths[month-1]
    }
    
}
