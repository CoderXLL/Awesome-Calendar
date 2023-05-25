//
//  UIFont+Custome.swift
//  YPUIKit
//
//  Created by xiaoll on 2020/8/3.
//

import Foundation
import UIKit

//后续有自定义字体可增加对应枚举成员
public enum YPFontStyle {
    case none
    case thin
    case light
    case regular
    case medium
    case semibold
    case ultraLight
    case boldDINAlternate
    case countdownRegular
    case countdownMedium
}

private let YPFontNamePingFangSCUltraLight: String = "PingFangSC-UltraLight"
private let YPFontNamePingFangSCLight: String = "PingFangSC-Light"
private let YPFontNamePingFangSCThin: String = "PingFangSC-Thin"
private let YPFontNamePingFangSCRegular: String = "PingFangSC-Regular"
private let YPFontNamePingFangSCMedium: String = "PingFangSC-Medium"
private let YPFontNamePingFangSemibold: String = "PingFangSC-Semibold"
private let YPFontNameDINAlternateSemibold: String = "DINAlternate-Bold"
private let YPFontNameHelveticaNeueRegular: String = "HelveticaNeue"
private let YPFontNameHelveticaNeueMedium: String = "HelveticaNeue-Medium"

public extension UIFont {
    static func fontWithSize(_ size: CGFloat, _ style: YPFontStyle = .regular) -> UIFont {
        var font: UIFont?
        switch style {
        case .none: fallthrough
        case .light:
            font = UIFont(name: YPFontNamePingFangSCLight, size: size)
        case .ultraLight:
            font = UIFont(name: YPFontNamePingFangSCUltraLight, size: size)
        case .thin:
            font = UIFont(name: YPFontNamePingFangSCThin, size: size)
        case .regular:
            font = UIFont(name: YPFontNamePingFangSCRegular, size: size)
        case .medium:
            font = UIFont(name: YPFontNamePingFangSCMedium, size: size)
        case .semibold:
            font = UIFont(name: YPFontNamePingFangSemibold, size: size)
        case .boldDINAlternate:
            font = UIFont(name: YPFontNameDINAlternateSemibold, size: size)
        case .countdownRegular:
            font = UIFont(name: YPFontNameHelveticaNeueRegular, size: size)
        case .countdownMedium:
            font = UIFont(name: YPFontNameHelveticaNeueMedium, size: size)
        }
        if let realFont = font {
            return realFont
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}

