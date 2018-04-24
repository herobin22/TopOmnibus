//
//  OYTabBarController.swift
//  TopOmnibus
//
//  Created by Gold on 2016/12/9.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit

class OYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var shouldAutorotate: Bool {
        return self.selectedViewController!.shouldAutorotate
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.selectedViewController!.supportedInterfaceOrientations
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.selectedViewController!.preferredInterfaceOrientationForPresentation
    }
}
