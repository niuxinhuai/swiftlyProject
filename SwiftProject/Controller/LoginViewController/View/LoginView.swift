//
//  LoginView.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/26.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
import SnapKit
class LoginView: UIView {
    var offHeight:CGFloat = UIScreen.main.bounds.size.height/667
    
    
    override func draw(_ rect: CGRect) {
        self.configUI()
    }
    
    func configUI() {
        addSubview(bgImage);
        bgImage.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        addSubview(logoImageV)
        logoImageV.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(65*offHeight)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize.init(width: 87, height: 118))
        }
        
        addSubview(dissMissButton)
        dissMissButton.snp.makeConstraints { (make) in
            make.left.equalTo(22)
            make.top.equalTo(30)
            make.width.height.equalTo(22)
        }
        
        addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self.snp.left).offset(18)
            make.right.equalTo(self.snp.right).offset(-18)
            make.height.equalTo(313)
        }
      //  bottomView.ff_setCornerType(UIRectCorner.allCorners, cornerRadius: 5)
        
    }
    
    lazy var bgImage : UIImageView = {
        let object = UIImageView()
        object.image = UIImage(named: "LoginBackground")
        return object
    }()
    
    lazy var logoImageV : UIImageView = {
        let object = UIImageView()
        object.image = UIImage(named: "LoginLogo")
        return object
    }()
    
    lazy var dissMissButton : UIButton = {
        let object = UIButton.init(type: UIButtonType.custom)
        object.setImage(UIImage(named: "LoginBack"), for: .normal)
        object.addTarget(self, action: #selector(dissmissVC), for: .touchUpInside)
        object.sizeToFit()
        return object
    }()
    
    lazy var bottomView : LoginWhiteView = {
        let object = LoginWhiteView.init(frame: CGRect.init(x: 18, y: UIScreen.main.bounds.size.height/2+30, width: self.frame.size.width-36, height: UIScreen.main.bounds.size.height/2-30))
        object.backgroundColor = UIColor.white
        return object
    }()

    
    
    @objc func dissmissVC() {
        let tabbarC = UIApplication.shared.delegate?.window??.rootViewController as!UITabBarController
        let vc = tabbarC.selectedViewController
        vc?.dismiss(animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.bottomView.center = CGPoint.init(x: self.bottomView.center.x, y: UIScreen.main.bounds.size.height/2)
    }

}
