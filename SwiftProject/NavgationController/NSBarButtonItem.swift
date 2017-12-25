//
//  NSBarButtonItem.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/25.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import Foundation

extension UIBarButtonItem {
    
    class func initNavBarbuttonItems(imageNamed: String, target: Any?, action:Selector) ->UIBarButtonItem{
        let button = UIButton()
        button.addTarget(target, action: action, for: .touchUpInside)
        button.setImage(UIImage(named: imageNamed)?.withRenderingMode(.alwaysOriginal),
                        for: .normal)
        button.sizeToFit()
        
        return UIBarButtonItem.init(customView: button)
    }
    
}
