//
//  ReadModel.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/19.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
import SwiftyJSON
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
