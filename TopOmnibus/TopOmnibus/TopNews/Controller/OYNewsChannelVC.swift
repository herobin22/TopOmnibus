//
//  OYNewsChannelVC.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/4.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit
import AXWebViewController

class OYNewsChannelVC: OYViewController {

    var type: String?
    var dataSource: [OYNewsModel] = [OYNewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OYNewsListCell.self, forCellReuseIdentifier: OYNewsListCellID)
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
        tableView.register(OYNewsListCell.self, forCellReuseIdentifier: OYNewsListCellID)
    }
    
    override func loadData() {
        guard let param = type else {
            return
        }
        OYAPIManager.sharedManager.loadNewsData(type: param, success: { (models) in
            self.dataSource = models
            self.tableView.reloadData()
            self.endRefresh()
            self.tableView.mj_footer.endRefreshingWithNoMoreData()
        }) { (_, error) in
            print(error)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension OYNewsChannelVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OYNewsListCellID) as! OYNewsListCell
        cell.model = dataSource[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        let webVC = OYWebViewController(address: model.url!)
        webVC.navigationType = .barItem
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
