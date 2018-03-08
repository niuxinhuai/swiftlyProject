//
//  SignTabBarController.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/13.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit

class SignTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tab = SignTabbar()
        
        setValue(tab, forKey: "tabBar")
        tabBar.isTranslucent = false
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowOffset = CGSize.init(width: 0, height: -3)
        
        // 创建推荐页
        let viewC = ViewController()
        addChildViewControllers(viewC,
                                title: "推荐",
                                image: "tab_item_recommend_un_select",
                                selectedImage: "tab_item_recommend_select")
        // 创建轻读页
        let readC = HaveReadViewController()
        addChildViewControllers(readC,
                                title: "轻读",
                                image:"tab_item_have_un_select",
                                selectedImage:"tab_item_have_select")
        // 创建我的界面
        let myC = MyViewController()
        addChildViewControllers(myC,
                                title: "我的",
                                image: "tab_item_my_un_select",
                                selectedImage:"tab_item_my_select")
        self.selectedIndex = 1

    }
    
    // 封装公共方法
    func addChildViewControllers(_ childController: UIViewController, title:String?, image:String? ,selectedImage:String?) {
        //let image = #imageLiteral(resourceName: "tab_item_my_select")
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: UIImage(named: image!)?.withRenderingMode(.alwaysOriginal),
                                        selectedImage: UIImage(named:selectedImage!)?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
        addChildViewController(NXNavigationController.init(rootViewController: childController))
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
