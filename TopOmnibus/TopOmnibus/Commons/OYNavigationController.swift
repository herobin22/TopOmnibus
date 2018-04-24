//
//  OYNavigationController.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/8.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit

class OYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        navigationBar.barTintColor = mainRedColor
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
//        self.delegate = WTKTransition.shareManager()
//        WTKTransition.shareManager().animationType = .diffNavi;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count != 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.viewControllers.last!.supportedInterfaceOrientations
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.viewControllers.last!.preferredInterfaceOrientationForPresentation
    }
}
