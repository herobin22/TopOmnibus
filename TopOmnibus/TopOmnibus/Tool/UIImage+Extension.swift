//
//  UIImage+Extension.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/21.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit

extension UIImage {
    class func getLauchImage() -> UIImage? {
        let viewSize = mainSize
        var launchImage: String?
        let imagesDict = Bundle.main.infoDictionary?["UILaunchImages"]
        for dict in (imagesDict as! [[String : Any]]) {
            let imageSize = CGSizeFromString((dict["UILaunchImageSize"] as! String))
            if __CGSizeEqualToSize(imageSize, viewSize) {
                launchImage = dict["UILaunchImageName"] as? String
            }
        }

        return UIImage(named: launchImage!)
    }
}
