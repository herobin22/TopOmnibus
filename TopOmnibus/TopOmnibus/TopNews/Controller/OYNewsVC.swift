//
//  OYNewsVC.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/3.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit

class OYNewsVC: UIViewController {
    
    lazy var topicView: OYNewsTopicView = OYNewsTopicView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        topicView.frame = CGRect(x: 0, y: 64, width: mainWidth, height: 32)
        view.addSubview(topicView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        topicView.collectionView.reloadData()
    }
}
