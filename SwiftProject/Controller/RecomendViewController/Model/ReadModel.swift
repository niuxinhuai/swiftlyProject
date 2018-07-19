//
//  ReadModel.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/19.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreSpotlight
struct items {
    
    var source: String?
    var tab: String?
    var me: String?
    var id: String?
    var recommend_num: String?
    var title: String?
    var brief: String?
    var read_num: String?
    var cover: String?
    var issuer_nickname: String?
    var type: String?
    
    init(json: JSON) {
        self.source                   = json["source"].stringValue
        self.tab                      = json["tab"].stringValue
        self.me                       = json["me"].stringValue
        self.id                       = json["id"].stringValue
        self.recommend_num            = json["recommend_num"].stringValue
        self.title                    = json["title"].stringValue
        self.brief                    = json["brief"].stringValue
        self.read_num                 = json["read_num"].stringValue
        self.cover                    = json["cover"].stringValue
        self.issuer_nickname          = json["issuer_nickname"].stringValue
        self.type                     = json["type"].stringValue
    }
    
}

struct ReturnData: Codable {
    var pageNum: Int = 0
    var pageMax: Int = 0
   // var item: [items] //格式不固定，用范型替代
}

struct ResponseData: Codable {
    var code: String
    var data: ReturnData
    

}

class SpotlightUtil: NSObject {
    @available(iOS 9.0, *)
    func getSpotlight() {
        let firstSet = CSSearchableItemAttributeSet.init(itemContentType: "firstSet")
        firstSet.title = "中国"
        firstSet.contentDescription = "台湾是中国的固有领土"
        firstSet.contactKeywords = ["first","中国","台湾"]
        firstSet.thumbnailData = UIImageJPEGRepresentation(UIImage.init(named: "m8.jpg")!, 1)
        
        let firstItem = CSSearchableItem.init(uniqueIdentifier: "firstItem", domainIdentifier: "first", attributeSet: firstSet)
        CSSearchableIndex.default().indexSearchableItems([firstItem]) { (error) in
            if error != nil {
                print("spotlight错误提示\(error)")
            }else {
                print("spotlight验证成功")
            }
        }
        
    }
    
    
}
