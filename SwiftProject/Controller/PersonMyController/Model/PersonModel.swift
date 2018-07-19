//
//  PersonModel.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/22.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit

class PersonModel: NSObject {
    static var data = ["我的动态",
                "我的关注",
                "我的粉丝",
                "我的合集",
                "我的订阅",
                "我的消息",
                "意见反馈"]
    static var imgNamedArray = ["personal_dynamic",
                         "personal_attention",
                         "personal_fensi",
                         "personal_compilations",
                         "personal_subscription",
                         "personal_message",
                         "personal_attention"]
    
    class var CanOpenQQ: Bool {
        
        return UIApplication.shared.canOpenURL(URL.init(string: "mqqapi://")!)
    }
    


}

