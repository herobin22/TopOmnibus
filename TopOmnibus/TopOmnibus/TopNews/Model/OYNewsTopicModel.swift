//
//  OYNewsTopicModel.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/7.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit

class OYNewsTopicModel: NSObject {
    var topic: String?
    var process: CGFloat = 0
    
    init(topic: String) {
        self.topic = topic
    }
}
