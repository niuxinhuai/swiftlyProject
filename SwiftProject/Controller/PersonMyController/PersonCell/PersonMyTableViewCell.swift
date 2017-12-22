//
//  PersonMyTableViewCell.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/22.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
class PersonMyTableViewCell: BaseTableViewCell {
    
    var imageNamed: String! {
        didSet{
            imageV.image = UIImage(named: imageNamed)
        }
    }
    
    var title: String!{
        didSet{
            nameLabel.text = title
        }
    }
    // 配置基本信息
    override func configUI() {
        self.accessoryType = .disclosureIndicator
        contentView.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.equalTo(17)
            make.width.height.equalTo(22)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageV.snp.right).offset(15)
            make.top.equalTo(20)
            make.height.equalTo(14)
            make.width.lessThanOrEqualTo(120)
        }
    }
    
    lazy var imageV : UIImageView = {
        let object = UIImageView()
        
        return object
    }()
    
    lazy var nameLabel : UILabel = {
        let object = UILabel()
        object.font = UIFont.systemFont(ofSize: 14)
        object.textColor = UIColor.hex(hexString: "#333333")
        return object
    }()

}
