//
//  OYWebViewController.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/11.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit
import AXWebViewController
import GoogleMobileAds

class OYWebViewController: AXWebViewController, GADBannerViewDelegate, UIScrollViewDelegate {
    
    var bannerView: GADBannerView = GADBannerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 增加广告
        bannerView.frame = CGRect(x: 0, y: 64, width: mainWidth, height: 60)
        bannerView.delegate = self
        bannerView.adUnitID = AdMobAdUnitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        self.view.addSubview(bannerView)
        self.webView.scrollView.delegate = self
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var frame = bannerView.frame
        frame.origin.y = -scrollView.contentOffset.y-60
        bannerView.frame = frame
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}

