//
//  OYViewController.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/11.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit
import MJRefresh
import GoogleMobileAds//广告

class OYViewController: UIViewController, GADBannerViewDelegate {
    
    let tableView = UITableView()
    var curPage: Int = 1
    var bannerView: GADBannerView = GADBannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupRefresh()
        setupTitleView()
    }

    private func setupUI() {
        view.backgroundColor = UIColor.white
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.scrollsToTop = true
    }
    
    private func setupRefresh() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headRefresh))
        tableView.mj_header.beginRefreshing()
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footRefresh))
        tableView.mj_footer.isHidden = true
    }
    
    private func setupTitleView() {
        let imageView = UIImageView(image: UIImage(named: "titleBus"))
        imageView.contentMode = .scaleAspectFit
        imageView.bounds = CGRect(x: 0, y: 0, width: 150, height: 44)
        navigationItem.titleView = imageView
    }
    
    @objc private func headRefresh() {
        curPage = 1
        refreshAction()
    }
    
    @objc private func footRefresh() {
        curPage = curPage + 1
        refreshAction()
    }
    
    private func refreshAction() -> Void {
        loadData()
    }
    
    func endRefresh() {
        tableView.mj_header.endRefreshing()
        tableView.mj_footer.endRefreshing()
    }
    
    func loadData() {
        
    }
}

extension OYViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
