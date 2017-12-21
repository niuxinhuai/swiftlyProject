//
//  RecomendTableViewCell.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/14.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import SDWebImage

class RecomendTableViewCell: BaseTableViewCell {

    var model: items?{
        didSet {
            
            //guard let model = model else { return }
            bgImageView.sd_setImage(with: NSURL(string: (model?.cover)!)! as URL, placeholderImage: UIImage(named: "m8.jpg"))
            titleLabel.text = model?.title
            nickLabel.text = "\(String(describing: model!.issuer_nickname))   ⠂  \(String(describing: model!.read_num))人读过"
            recommendLabel.text = "\(String(describing: model!.recommend_num))位同行推荐"
            if model!.type == "article" {
                atricleTypeLabel.text = "文章"
                atricleTypeLabel.backgroundColor = UIColor.hex(hexString: "#ffffff").withAlphaComponent(0.85)
            }else if model!.type == "collection"{
                atricleTypeLabel.text = "合集"
                atricleTypeLabel.backgroundColor = UIColor.hex(hexString: "#a2efec").withAlphaComponent(0.8)
            }
            
            let labelHeight: CGFloat = titleLabel.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            if labelHeight > 30 {
                redView.snp.updateConstraints { (make) in
                    make.height.equalTo((UIScreen.main.bounds.size.width-40)*175/335+112)
                    make.bottom.equalTo(contentView.snp.bottom).offset(-10)
                }
                contentView.layoutIfNeeded()
            }else{
                redView.snp.updateConstraints { (make) in
                    make.height.equalTo((UIScreen.main.bounds.size.width-40)*175/335+82)
                    make.bottom.equalTo(contentView.snp.bottom).offset(-10)
                }
                contentView.layoutIfNeeded()
            }
            
        }
    }
    override func configUI() {
        contentView.addSubview(redView)
        redView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(redView)
            make.height.equalTo((UIScreen.main.bounds.size.width-40)*175/335)
        })
        
        redView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgImageView.snp.left).offset(15)
            make.right.equalTo(bgImageView)
            make.height.lessThanOrEqualTo(52)
            make.top.equalTo(bgImageView.snp.bottom).offset(20)
        }
        
        redView.addSubview(nickLabel)
        nickLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.height.equalTo(11)
            make.width.equalTo(250)
        }
        
        redView.addSubview(recommendLabel)
        recommendLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nickLabel)
            make.right.equalTo(bgImageView.snp.right).offset(-14)
            make.height.equalTo(11)
            make.width.equalTo(90)
        }
        
        redView.addSubview(layerLabel)
        layerLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgImageView).offset(15)
            make.bottom.equalTo(bgImageView.snp.bottom).offset(-15)
            make.width.equalTo(56)
            make.height.equalTo(24)
        }
        layerLabel.addSubview(atricleTypeLabel)
        atricleTypeLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(layerLabel)
        }
        
        redView.snp.makeConstraints { (make) in
            //make.edges.equalTo(self).inset(UIEdgeInsetsMake(10, 20, 10, 20))
            make.top.equalTo(contentView.snp.top).offset(28)
            make.left.equalTo(19)
            make.right.equalTo(contentView).offset(-21)
            make.height.equalTo((UIScreen.main.bounds.size.width-40)*175/335+82)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        contentView.layoutIfNeeded()
        
        bgImageView.ff_setRoundedRect(CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width-40, height: (UIScreen.main.bounds.size.width-40)*175/335),
                                      cornerType: UIRectCorner(rawValue: UIRectCorner.RawValue(UInt8(UIRectCorner.topLeft.rawValue) | UInt8(UIRectCorner.topRight.rawValue))),
                                      cornerSizeRadius: CGSize.init(width: 5, height: 5))
        
    }
    lazy var redView : UIView = {
        let redView = UIView()
        redView.backgroundColor = UIColor.white
        redView.layer.cornerRadius = 5.0
        redView.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        redView.layer.shadowOpacity = 1
        redView.layer.shadowRadius = 5
        redView.layer.shadowColor = UIColor.hex(hexString: "#eaeaea").cgColor
        return redView
    }()
    
    lazy var bgImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleToFill
        return imageView
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var nickLabel : UILabel = {
       let label = UILabel()
        label.textColor = UIColor.hex(hexString: "#929292")
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var recommendLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .right
        label.textColor = UIColor.hex(hexString: "#929292")
        
        return label
    }()
    
    private lazy var layerLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        label.layer.shadowOpacity = 0.7
        label.layer.shadowRadius = 1
        label.layer.shadowColor = UIColor.hex(hexString: "#000000").withAlphaComponent(0.2).cgColor

        return label
    }()
    
    private lazy var atricleTypeLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.hex(hexString: "#a2efec").withAlphaComponent(0.8)
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = UIColor.hex(hexString: "#333333")
        label.font = UIFont.systemFont(ofSize: 12)
        return label
        
    }()
}
