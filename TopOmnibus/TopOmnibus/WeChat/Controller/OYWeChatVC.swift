//
//  OYWeChatVC.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/2.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit
import MJRefresh

class OYWeChatVC: UIViewController {
    
    var tableView: UITableView!
    var dataSource: [OYWeChatModel] = [OYWeChatModel]()
    var curPage: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        setupRefresh()
        
        loadData()
    }
    
    //MARK:-- 初始化TableView
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView!)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(OYWeChatCell.self, forCellReuseIdentifier: OYWeChatCellID)
    }
    
    private func setupRefresh() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headRefresh))
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footRefresh))
    }

    //MARK:-- LoadData
    private func loadData() {
        let params = ["pno" : curPage]
        OYAPIManager.sharedManager.loadWeChatData(parameters: params, success: { (models) in
            if self.curPage == 1 {
                self.dataSource = [OYWeChatModel]()
            }
            self.dataSource.append(contentsOf: models)
            self.tableView.reloadData()
            self.endRefresh()
        }) { (_, error) in
            print(error)
        }
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
    
    private func endRefresh() {
        tableView.mj_header.endRefreshing()
        tableView.mj_footer.endRefreshing()
    }
}


extension OYWeChatVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OYWeChatCellID) as! OYWeChatCell
        cell.model = self.dataSource[indexPath.row]
        return cell
    }
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVc = OYCommonsWebVC()
        webVc.contentURL = dataSource[indexPath.row].url
        navigationController?.pushViewController(webVc, animated: true)
    }
}
