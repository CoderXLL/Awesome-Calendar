//
//  ASBaseViewController.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/15.
//

import Foundation
import UIKit

open class ASBaseViewController: UIViewController {
        
    /// 页面是否隐藏 YPNotificationBanner，如消息页面、付款页面
    open var prefersNotificationBannerHidden: Bool {
        return false
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.backBarButtonItem = UIBarButtonItem(
//            title: "",
//            style: .plain,
//            target: nil,
//            action: nil
//        )
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        
        if navigationController?.children.first !== self || navigationController?.presentingViewController !== nil {
            //..设置返回按钮图标
            setLeftBarItem(selector: #selector(onBack(_:)), normalImageName: "navigationbar_back_gray", highlightImageName: "navigationbar_back_gray")
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    deinit {
        
    }
    
    private func setLeftBarItem(selector: Selector, normalImageName: String, highlightImageName: String) {

        let leftBarBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 47, height: 44))
        leftBarBtn.setImage(UIImage(named: normalImageName), for: .highlighted)
        leftBarBtn.setImage(UIImage(named: highlightImageName), for: .normal)
        leftBarBtn.addTarget(self, action: selector, for: .touchUpInside)

        leftBarBtn.contentHorizontalAlignment = .left
        leftBarBtn.imageEdgeInsets = UIEdgeInsets(top: 9, left: 0, bottom: 9, right: 5)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarBtn)
    }
    
    // MARK: - can be overrided methods
    @objc @IBAction open func onBack(_ sender: Any) {

        guard let navVC = self.navigationController else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        navVC.popViewController(animated: true)
    }
}
