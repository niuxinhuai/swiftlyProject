//
//  LoginViewController.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/25.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录界面"
        view.addSubview(bgView)
        
    }

    lazy var bgView : LoginView = {
        let object = LoginView()
        object.frame = view.bounds
        return object
    }()

}
