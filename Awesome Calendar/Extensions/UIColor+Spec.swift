//
//  UIColor+NovelMe.swift
//  NovelMe
//
//  Created by lili on 2018/10/17.
//  Copyright © 2018 fun. All rights reserved.
//

import UIKit

public extension UIColor {
    static func RGBH(_ value: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((value & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((value & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(value & 0xFF))/255.0, alpha: 1.0)
    }
    static func RGBHA(_ value: Int, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: ((CGFloat)((value & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((value & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(value & 0xFF))/255.0, alpha: alpha)
    }
    //随机色
    static func random() -> UIColor {
        let r = CGFloat(arc4random() % 256) / 255.0
        let g = CGFloat(arc4random() % 256) / 255.0
        let b = CGFloat(arc4random() % 256) / 255.0
        if #available(iOS 10.0, *) {
            let color = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1)
            return color
        } else {
            // Fallback on earlier versions
            return UIColor(red: r, green: g, blue: b, alpha: 1)
        }
    }
    
    // MARK: - 功能划分
    
    ///背景色

    static var ypBackgroundColor: UIColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1) //#F3F3F3

    /// 分割线颜色
    static var ypLineColor: UIColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1) // #DEDEDE
    
    /// VIP字体颜色
    static var ypVIPTitle: UIColor = #colorLiteral(red: 0.9843137255, green: 0.9019607843, blue: 0.7882352941, alpha: 1) // #FBE6C9
    
    /// 黑色半透明蒙版
    static var ypBlackAlphaMask: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5) // #000000 alpha 0.5
    
    static var ypImagePlaceholder: UIColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1) // #EBEBEB
    
    // MARK: - 通用颜色
    
    /// 黑色
    static var ypBlack: UIColor =  #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) // #333333
    
    /// 深灰色
    static var ypDarkGray: UIColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) // #666666
    /// 灰色
    static var ypGray: UIColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1) // #999999
    /// 亮灰色
    static var ypLightGray: UIColor = #colorLiteral(red: 0.7333333333, green: 0.7333333333, blue: 0.7333333333, alpha: 1) // #BBBBBB
    
    ///绿色
    static var ypGreen: UIColor = #colorLiteral(red: 0.2980392157, green: 0.5568627451, blue: 0, alpha: 1) ///4C8E00
    
    /// 亮红色
    static var ypLightRed: UIColor = #colorLiteral(red: 1, green: 0.1254901961, blue: 0.3137254902, alpha: 1) // #FF2050
    /// 红色
    static var ypRed: UIColor = #colorLiteral(red: 1, green: 0.2941176471, blue: 0.2941176471, alpha: 1) // #FF4B4B
    /// 不可点红色
    static var ypDisableRed: UIColor = #colorLiteral(red: 0.9803921569, green: 0.5607843137, blue: 0.6509803922, alpha: 1) // #FA8FA6
    /// 紫色
    static var ypPurple: UIColor = #colorLiteral(red: 0.3921568627, green: 0.08235294118, blue: 0.8862745098, alpha: 1) // #FF2050
    
    /// 白色
    static var ypWhite: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // #FFFFFF
    
    /// 黄色
    static var ypYellow: UIColor = #colorLiteral(red: 1, green: 0.937254902, blue: 0.2196078431, alpha: 1) // #FFEF38
    
    static var asRed: UIColor = #colorLiteral(red: 1, green: 0.3647357821, blue: 0.2889650464, alpha: 1) // FF443A
    static var asLightGray: UIColor = #colorLiteral(red: 0.6274509804, green: 0.6196078431, blue: 0.6352941176, alpha: 1)
}
