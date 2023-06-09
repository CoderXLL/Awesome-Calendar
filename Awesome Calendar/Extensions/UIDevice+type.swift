//
//  UIDevice+type.swift
//  YPUIKit
//
//  Created by xiaoll on 2020/8/6.
//

import Foundation
import UIKit

public enum DeviceType: Int {
    case pod1
    case pod2
    case pod3
    case pod4
    case pod5
    case pad
    case phone1
    case phone3G
    case phone3GS
    case phone4
    case phone4s
    case phone5
    case phone5c
    case phone5s
    case phone6
    case phone6Plus
    case phone6s
    case phone6sPlus
    case phoneSE
    case phone7
    case phone7Plus
    case phone8
    case phone8Plus
    case phoneSE2
    case phoneX
    case phoneXS
    case phoneXSMax
    case phoneXR
    case phone11
    case phone11Pro
    case phone11ProMax
    case phone12Mini
    case phone12
    case phone12Pro
    case phone12ProMax
    case others
}

public extension UIDevice {
    
    static let platformIdentifier: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()
    
    static let modelName: String = {
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone1,1":                               return "iPhone 2G"
            case "iPhone1,2":                               return "iPhone 3G"
            case "iPhone2,1":                               return "iPhone 3GS"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd generation)"
            case "iPhone13,1":                              return "iPhone 12 mini"
            case "iPhone13,2":                              return "iPhone 12"
            case "iPhone13,3":                              return "iPhone 12 Pro"
            case "iPhone13,4":                              return "iPhone 12 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: UIDevice.platformIdentifier)
    }()
    
    static let deviceType: DeviceType = {
        var type: DeviceType = .others
        if UIDevice.platformIdentifier.hasPrefix("iPhone1,1") {
            type = .phone1
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone1,2") {
            type = .phone3G
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone2") {
            type = .phone3GS
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone2,1") {
            type = .phone3GS
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone3") {
            type = .phone4
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone3,1") {
            type = .phone4
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone3,2") {
            type = .phone4
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone3,3") {
            type = .phone4
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone4") {
            type = .phone4s
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone4,1") {
            type = .phone4s
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone5,1") {
            type = .phone5
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone5,2") {
            type = .phone5
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone5,3") {
            type = .phone5c
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone5,4") {
            type = .phone5c
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone6") {
            type = .phone5s
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone6,1") {
            type = .phone5s
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone6,2") {
            type = .phone5s
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone7,1") {
            type = .phone6Plus
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone7,2") {
            type = .phone6
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone8,1") {
            type = .phone6s
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone8,2") {
            type = .phone6sPlus
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone8,3") {
            type = .phoneSE
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone8,4") {
            type = .phoneSE
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone9,1") {
            type = .phone7
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone9,3") {
            type = .phone7
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone9,2") {
            type = .phone7Plus
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone9,4") {
            type = .phone7Plus
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone10,1") {
            type = .phone8
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone10,4") {
            type = .phone8
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone10,2") {
            type = .phone8Plus
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone10,5") {
            type = .phone8Plus
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone10,3") {
            type = .phoneX
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone10,6") {
            type = .phoneX
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone11,2") {
            type = .phoneXS
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone11,4") {
            type = .phoneXSMax
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone11,6") {
            type = .phoneXSMax
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone11,8") {
            type = .phoneXR
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone12,1") {
            type = .phone11
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone12,3") {
            type = .phone11Pro
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone12,5") {
            type = .phone11ProMax
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone12,8") {
            type = .phoneSE2
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone13,1") {
            type = .phone12Mini
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone13,2") {
            type = .phone12
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone13,3") {
            type = .phone12Pro
        } else if UIDevice.platformIdentifier.hasPrefix("iPhone13,4") {
            type = .phone12ProMax
        } else if UIDevice.platformIdentifier.hasPrefix("iPod1,1") {
            type = .pod1
        } else if UIDevice.platformIdentifier.hasPrefix("iPod2,1") {
            type = .pod2
        } else if UIDevice.platformIdentifier.hasPrefix("iPod3,1") {
            type = .pod3
        } else if UIDevice.platformIdentifier.hasPrefix("iPod4,1") {
            type = .pod4
        } else if UIDevice.platformIdentifier.hasPrefix("iPod5,1") {
            type = .pod5
        } else if UIDevice.platformIdentifier.hasPrefix("iPad") {
            type = .pad
        }
        return type
    }()
    
    static let statusBarHeight: CGFloat = {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }()
    
    static let navigationBarHeight: CGFloat = {
        return 44
    }()
    
    static let navigationBarMaxY: CGFloat = {
        return UIDevice.statusBarHeight + UIDevice.navigationBarHeight
    }()
    
    static let bottomBarHeight: CGFloat = {
        if UIDevice.isIphoneX {
            return 83.0
        }
        return 49.0
    }()
    
    static let safeAreaInsets: UIEdgeInsets = {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
        } else {
            return .zero
        }
    }()
    
    static let isIphoneX: Bool = {
        let deviceType = UIDevice.deviceType
        if deviceType.rawValue >= DeviceType.phoneX.rawValue {
            return true
        }
        return false
    }()
    
    static let screenW: CGFloat = {
        return UIScreen.main.bounds.size.width
    }()
    
    static let screenH: CGFloat = {
        return UIScreen.main.bounds.size.height
    }()
}
