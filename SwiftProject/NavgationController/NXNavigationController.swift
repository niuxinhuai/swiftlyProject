//
//  NXNavigationController.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/13.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit

class NXNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationBar.shadowImage = UIImage() // 去除导航条底部线条
        navigationBar.barTintColor = UIColor.white //设置导航条背景颜色
        //navigationBar.setBackgroundImage(UIImage(named: "m8.jpg"), for: .default)
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]//设置导航条字体颜色
       // navigationBar.tintColor = UIColor.black  // 改变导航条返回按钮颜色
         
        // Do any additional setup after loading the view.
    }
    // 重写系统方法，保证push界面是，tabbar可以及时隐藏，子类直接调用push方法即可
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
