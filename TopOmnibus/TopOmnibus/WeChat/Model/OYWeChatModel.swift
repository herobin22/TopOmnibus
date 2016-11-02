//
//  OYWeChatModel.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/2.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit

class OYWeChatModel: NSObject {
    
    var id: String?
    var title: String?
    var source: String?
    var firstImg: String?
    var mark: String?
    var url: String?
    
    /// KVC构造器
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }

}
