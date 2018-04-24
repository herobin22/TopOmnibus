//
//  AppDelegate.swift
//  TopOmnibus
//
//  Created by Gold on 2016/10/31.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, BaiduMobAdSplashDelegate {

    var window: UIWindow?

    var splash = BaiduMobAdSplash()
    
    var customSplashView = UIImageView()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        setRootVC()
        window?.makeKeyAndVisible()
        
        setupBaiduAd()
        
        return true
    }
    
    func setRootVC() -> Void {
        let tabBarVC = OYTabBarController()
        tabBarVC.tabBar.tintColor = mainRedColor
        let firstNav = OYNavigationController(rootViewController: OYNewsVC())
        firstNav.tabBarItem = UITabBarItem(title: "新闻", image: UIImage(named: "tabbar_icon_news_normal"), selectedImage: UIImage(named: "tabbar_icon_news_highlight"))
        let secondNav = OYNavigationController(rootViewController: OYWeChatVC())
        secondNav.tabBarItem = UITabBarItem(title: "精选", image: UIImage(named: "tabbar_icon_bar_normal"), selectedImage: UIImage(named: "tabbar_icon_bar_highlight"))
        tabBarVC.viewControllers = [firstNav, secondNav]
        
        window?.rootViewController = tabBarVC
    }
    
    func setupBaiduAd() -> Void {
        splash.delegate = self
        splash.adUnitTag = "3098497"
        splash.canSplashClick = true
        splash.loadAndDisplay(usingKeyWindow: window)
        
        /// 自定义开屏的view
        customSplashView.frame = window!.frame
        let width = Int(mainWidth)
        let height = Int(mainHeight)
        customSplashView.image = UIImage.getLauchImage()
        window!.addSubview(customSplashView)
        
        let baiduSplashContainer = UIView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight-80))
        customSplashView.addSubview(baiduSplashContainer)
        
        splash.loadAndDisplay(usingContainerView: baiduSplashContainer)
    }
    
    func publisherId() -> String! {
        return "e271117e"
    }
    
    func splashSuccessPresentScreen(_ splash: BaiduMobAdSplash!) {
        print("splashSuccessPresentScreen")
    }
    
    func splashlFailPresentScreen(_ splash: BaiduMobAdSplash!, withError reason: BaiduMobFailReason) {
        print(reason)
        customSplashView.removeFromSuperview()
    }
    
    func splashDidDismissScreen(_ splash: BaiduMobAdSplash!) {
        print("splashSuccessPresentScreen")
        customSplashView.removeFromSuperview()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

