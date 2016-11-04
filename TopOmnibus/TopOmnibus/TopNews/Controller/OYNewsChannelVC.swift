//
//  OYNewsChannelVC.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/4.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit

class OYNewsChannelVC: UIViewController {

    var type: String?
    let tableView = UITableView()
    var dataSource: [OYNewsModel] = [OYNewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    }
    
    private func setupUI() {
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(OYNewsListCell.self, forCellReuseIdentifier: OYNewsListCellID)
    }
    
    private func loadData() {
        guard let param = type else {
            return
        }
        OYAPIManager.sharedManager.loadNewsData(type: param, success: { (models) in
            self.dataSource = models
            self.tableView.reloadData()
        }) { (_, error) in
            print(error)
        }
    }
}

extension OYNewsChannelVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OYNewsListCellID) as! OYNewsListCell
        cell.model = dataSource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        let vc = OYCommonsWebVC()
        vc.contentURL = model.url
        navigationController?.pushViewController(vc, animated: true)
    }
}
