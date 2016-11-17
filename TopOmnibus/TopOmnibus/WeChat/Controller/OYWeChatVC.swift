//
//  OYWeChatVC.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/2.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit
import MJRefresh
import AXWebViewController

class OYWeChatVC: OYViewController {
    
//    var tableView: UITableView = UITableView()
    var dataSource: [OYWeChatModel] = [OYWeChatModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(OYWeChatCell.self, forCellReuseIdentifier: OYWeChatCellID)
    }
    
    //MARK:-- 初始化TableView
    private func setupTableView() {
//        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(OYWeChatCell.self, forCellReuseIdentifier: OYWeChatCellID)
    }

    //MARK:-- LoadData
    override func loadData() {
        let params = ["pno" : curPage]
        OYAPIManager.sharedManager.loadWeChatData(parameters: params, success: { (models) in
            if self.curPage == 1 {
                self.dataSource = [OYWeChatModel]()
            }
            self.dataSource.append(contentsOf: models)
            self.tableView.reloadData()
            self.tableView.mj_footer.isHidden = false
            self.endRefresh()
        }) { (_, error) in
            self.endRefresh()
        }
    }

}

extension OYWeChatVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OYWeChatCellID) as! OYWeChatCell
        cell.model = self.dataSource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        let webVC = OYWebViewController(address: model.url!)
        webVC.navigationType = .barItem
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
