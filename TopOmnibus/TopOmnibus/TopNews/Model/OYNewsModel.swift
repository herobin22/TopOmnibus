//
//  OYNewsModel.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/3.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit

class OYNewsModel: NSObject {
    
    var title: String?
    var date: String?
    var author_name: String?
    var thumbnail_pic_s: String?
    var thumbnail_pic_s02: String?
    var thumbnail_pic_s03: String?
    var url: String?
    var uniquekey: String?
    var type: String?
    var realtype: String?
    var category: String?
    var picArr: [String] {
        var arr = [String]()
        if let pic1 = self.thumbnail_pic_s {
            arr.append(pic1)
        }
        if let pic2 = self.thumbnail_pic_s02 {
            arr.append(pic2)
        }
        if let pic3 = self.thumbnail_pic_s03 {
            arr.append(pic3)
        }
        // 去重
        let set = Set(arr)
        return Array(set)
    }
    
    /// KVC构造器
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
         print(key)
    }
}
