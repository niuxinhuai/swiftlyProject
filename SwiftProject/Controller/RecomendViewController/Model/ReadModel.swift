//
//  ReadModel.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/19.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
import HandyJSON
import Foundation

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

struct ReturnData: HandyJSON {
    var pageNum: Int = 0
    var pageMax: Int = 0
    var item = Array<Dictionary<String, Any>>() //格式不固定，用范型替代
}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var data = T()// 格式不固定，用范型替代
    

}

class BasicTypes: HandyJSON {
    var source = String()
    var tab: Int = 0
    var me: Int = 0
    var itemIdentifier = String()
    var recommendNum: Int = 0
    var title = String()
    var brief = String()
    var readNum: Int = 0
    var cover = String()
    var issuerNickname = String()
    var type = String()
    
    required init() {}
}
