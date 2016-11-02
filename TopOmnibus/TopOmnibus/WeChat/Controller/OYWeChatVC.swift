//
//  OYWeChatVC.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/2.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit

class OYWeChatVC: UIViewController, UITableViewDelegate {
    
    var tableView: UITableView!
    var dataSource: [OYWeChatModel] = [OYWeChatModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        loadData()
    }
    
    //MARK:-- 初始化TableView
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView!)
        tableView?.dataSource = self
        tableView?.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(OYWeChatCell.self, forCellReuseIdentifier: OYWeChatCellID)
    }

    //MARK:-- LoadData
    private func loadData() {
        OYAPIManager.sharedManager.loadWeChatData(parameters: nil, success: { (models) in
            self.dataSource = models
            self.tableView.reloadData()
        }) { (_, error) in
            print(error)
        }

    }
}


extension OYWeChatVC: UITableViewDataSource {
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
}
