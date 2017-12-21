//
//  ReadModel.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/19.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
import HandyJSON
struct items: HandyJSON {
    
    var source = String()
    var tab = String()
    var me = String()
    var id = String()
    var recommend_num = String()
    var title = String()
    var brief = String()
    var read_num = String()
    var cover = String()
    var issuer_nickname = String()
    var type = String()
    
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
