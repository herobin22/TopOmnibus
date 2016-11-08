//
//  OYCommonsWebVC.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/3.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit
import WebKit

class OYCommonsWebVC: UIViewController {
    
    var webView: WKWebView?
    var contentURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupWebView()
    }

    private func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        webView?.backgroundColor = UIColor.white
        webView?.scrollView.backgroundColor = UIColor.white
        view.addSubview(webView!)
        
        guard (contentURL != nil) else {
            return
        }
        let request = URLRequest(url: URL(string: contentURL!)!)
        let _ = webView?.load(request)
    }
}
