//
//  BaseViewController.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/14.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.configNav()
        self.configNavgationItem()

//        if #available(iOS 11.0, *) {
//            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
//        } else {
//            extendedLayoutIncludesOpaqueBars = true;
//            edgesForExtendedLayout = .top;
//            automaticallyAdjustsScrollViewInsets = false
//        }
    }
    // 统一管理返回按钮点击事件方法
    func configNav() -> Void {
        if navigationController?.viewControllers.count == 1 {
            return
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Return")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAction))
    }
    
    func configNavgationItem() -> Void {
        
    }
    
    @objc func backAction() {
        
        navigationController?.popViewController(animated: true)
    }
    



}
