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
    
    /// KVC构造器
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}
