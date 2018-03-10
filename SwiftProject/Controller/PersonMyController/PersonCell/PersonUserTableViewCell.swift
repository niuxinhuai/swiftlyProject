//
//  PersonUserTableViewCell.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/22.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
import SnapKit
class PersonUserTableViewCell: BaseTableViewCell {
    // 配置基本信息
    override func configUI() {
        self.accessoryType = .disclosureIndicator
        contentView.addSubview(layerView)
        layerView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(16)
            make.width.height.equalTo(64)
        }
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(layerView.snp.right).offset(20)
            make.top.equalTo(layerView).offset(8)
            make.width.lessThanOrEqualTo(200)
            make.height.equalTo(18)
        }
        
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel);
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.width.lessThanOrEqualTo(220)
            make.height.equalTo(10)
        }
        layerView.signleDragable()
    }
    
    lazy var layerView : UIView = {
        let object = UIView()
        object.layer.shadowOffset = CGSize.init(width: 0, height: 7)
        object.layer.shadowOpacity = 0.3
        object.layer.shadowRadius = 6
        object.layer.cornerRadius = 3
        object.layer.shadowColor = UIColor.black.cgColor
        object.addSubview(imageV)
        imageV.snp.makeConstraints({ (make) in
            make.edges.equalTo(object)
        })
        return object
    }()
    lazy var imageV : UIImageView = {
        let object = UIImageView()
        object.image = UIImage(named: "m8.jpg")
        object.layer.cornerRadius = 32
        object.layer.masksToBounds = true
        
        return object
    }()
    lazy var nameLabel : UILabel = {
        let object = UILabel()
        object.text = "熟透的柚子"
        object.font = UIFont.boldSystemFont(ofSize: 16)
        object.textColor = UIColor.hex(hexString: "#333333")
        
        return object
    }()
    
    lazy var detailLabel : UILabel = {
        let object = UILabel()
        object.text = "ui设计师 | 阿里巴巴"
        object.font = UIFont.systemFont(ofSize: 12)
        object.textColor = UIColor.hex(hexString: "#929292")
        return object
    }()

    

    

    

    

    

    

    


}
