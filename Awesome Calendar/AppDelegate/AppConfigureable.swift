//
//  AppConfigureable.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/15.
//

import Foundation
import UIKit

protocol AppConfigurable: AnyObject {
    
    func configureAppAppearance()
}

extension AppConfigurable where Self: AppDelegate {
    
    //    func configureRootView() {
    //        window = UIWindow(frame: UIScreen.main.bounds)
    //        let rootViewController: UIViewController?
    //        if YPUserLoginManager.shared.isLogin {
    //            rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    //        } else {
    //            rootViewController = CTMediator.sharedInstance().YPAuth_showLogin()
    //        }
    //        window?.rootViewController = rootViewController
    //        window?.makeKeyAndVisible()
    //    }
    //
    func configureAppAppearance() {
        let shadow: NSShadow = {
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.white
            shadow.shadowOffset = CGSize(width: 0, height: 0)
            return shadow
        }()
        
        let textAttributes: [NSAttributedString.Key: AnyObject] = [
            .foregroundColor: UIColor.red,
            .shadow         : shadow,
            .font           : UIFont.boldSystemFont(ofSize: 19)
        ]
        
        if #available(iOS 15.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.shadowImage = UIImage()
            navBarAppearance.backgroundImage = UIImage.imageWithColor(color: .asRed)
            navBarAppearance.titleTextAttributes = textAttributes
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        } else {
            UINavigationBar.appearance().titleTextAttributes = textAttributes
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().setBackgroundImage(UIImage.imageWithColor(color: .asRed), for: .default)
        }
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "navigationbar_back_gray")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "navigationbar_back_gray")

        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ], for: UIControl.State.normal)
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.font:  UIFont.boldSystemFont(ofSize: 10),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ], for: UIControl.State.selected)
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = .red
        
        UITableView.appearance().backgroundColor = .lightGray
        //分割线
        UITableView.appearance().separatorColor = UIColor.black
        UITableView.appearance().estimatedRowHeight = 0
        UICollectionView.appearance().backgroundColor = .lightGray
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
    }
}
