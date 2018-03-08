//
//  LoginWhiteView.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/26.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
import SnapKit
class LoginWhiteView: UIView {

    override func draw(_ rect: CGRect) {
        print("输入框视图被调用了")
        self.configUI()
    }
    
    func configUI() -> Void {
        self.addSubview(self.phoneLabel)
        self.phoneLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(30)
            make.top.equalTo(self).offset(20)
            make.height.equalTo(30)
            make.width.lessThanOrEqualTo(80)
        }
        
        self.addSubview(self.phoneTextField)
        self.phoneTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.phoneLabel.snp.right).offset(0)
            make.right.equalTo(self.snp.right).offset(-20)
            make.top.equalTo(self.phoneLabel.snp.top)
            make.height.equalTo(self.phoneLabel.snp.height)
        }
        
        self.addSubview(self.passwordLabel)
        self.passwordLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(30)
            make.top.equalTo(self.phoneLabel.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.lessThanOrEqualTo(80)
        }
        
        self.addSubview(self.passwordTextField)
        self.passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.phoneTextField.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(-20)
            make.top.equalTo(self.passwordLabel.snp.top)
            make.height.equalTo(self.passwordLabel.snp.height)
        }

    }
    
    
    lazy var phoneLabel : UILabel = {
        let object = UILabel()
        object.text = "手机号"
        object.textColor = UIColor.black
        return object
    }()

    lazy var passwordLabel : UILabel = {
        let object = UILabel()
        object.text = "密码"
        object.textColor = UIColor.black
        return object
    }()
    
    lazy var phoneTextField : UITextField = {
        let object = UITextField()
        object.placeholder = "请输入手机号"
        object.keyboardType = .numberPad
        
        let imageV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 22, height: 22))
        imageV.image = UIImage(named: "Loginphone")
        imageV.contentMode = .scaleAspectFill
        let views = UIView.init(frame: CGRect.init(x: 20, y: 0, width: 30, height: 20))
        views.addSubview(imageV)
        object.leftViewMode = .always
        object.leftView = views
        let layers = CALayer()
        layers.frame = CGRect.init(x: 0, y: 29, width: 200, height: 1)
        layers.backgroundColor = UIColor.black.cgColor
        object.layer.addSublayer(layers)

        return object
    }()

    lazy var passwordTextField : UITextField = {
        let object = UITextField()
        object.placeholder = "请输入密码"
        let imageV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 22, height: 22))
        imageV.image = UIImage(named: "LoginPassword")
        imageV.contentMode = .scaleAspectFill
        let views = UIView.init(frame: CGRect.init(x: 20, y: 0, width: 30, height: 20))
        views.addSubview(imageV)
        object.leftViewMode = .always
        object.leftView = views
        let layers = CALayer()
        layers.frame = CGRect.init(x: 0, y: 29, width: 200, height: 1)
        layers.backgroundColor = UIColor.black.cgColor
        object.layer.addSublayer(layers)
        return object
    }()

    
    

}
