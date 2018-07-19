//
//  ALBCUtil.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2018/7/13.
//  Copyright © 2018年 牛新怀. All rights reserved.
//

import UIKit

class ALBCUtil: NSObject {

    static let shared = ALBCUtil.init()
    var feedbackKit: BCFeedbackKit
    
    private override init() {

        feedbackKit = BCFeedbackKit.init(appKey: "23426911", appSecret: "683ee4b0aa7482de6187def4dbecd1c1")
    }
    
//    var feedbackKit =
    
    
}

extension ALBCUtil {
    
    func openBCFeedback(c: UIViewController) {
//        self.feedbackKit.extInfo = ["contact": ["ZM": "guest", "studentid": "0"]]
        self.feedbackKit.extInfo = ["loginTime":[Date.init().description]]
        self.feedbackKit.makeFeedbackViewController( completionBlock: { (viewController, error) in
            if viewController != nil {
                let nav = UINavigationController.init(rootViewController: viewController!)
                nav.navigationBar.barStyle = .black
                c.present(nav, animated: true, completion: nil)
                
            } else {}
        })
    }
}
