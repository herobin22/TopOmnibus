//
//  OYNewsVC.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/3.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit

class OYNewsVC: UIViewController {
    
    /// 标题滚动条
    lazy var topicView: OYNewsTopicView = OYNewsTopicView()
    let topicArr = NewsTopicKeys
    
    /// 新闻列表用collection包裹
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
    }()
    
    /// 控制器缓存
    var channelVcCache: [String : OYNewsChannelVC] = [String : OYNewsChannelVC]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTitleView()
    }

    private func setupUI() -> Void {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        topicView.frame = CGRect(x: 0, y: 64, width: mainWidth, height: 40)
        weak var weakSelf = self
        topicView.didSelectTopic = {
            (num) in
            let indexPath = IndexPath(item: num, section: 0)
            weakSelf!.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        }
        topicView.process = 0
        view.addSubview(topicView)
        
        collectionView.frame = CGRect(x: 0, y: 104, width: mainWidth, height: view.bounds.size.height-104-49)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = collectionView.bounds.size
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "OYChannelCell")
        view.addSubview(collectionView)
    }
    
    private func setupTitleView() {
        let imageView = UIImageView(image: UIImage(named: "titleBus"))
        imageView.contentMode = .scaleAspectFit
        imageView.bounds = CGRect(x: 0, y: 0, width: 150, height: 44)
        navigationItem.titleView = imageView
    }
}

extension OYNewsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OYChannelCell", for: indexPath)
        for view in cell.subviews {
            guard view != cell.contentView else {
                continue
            }
            view.removeFromSuperview()
        }
        let vc = channelVc(withTopic: topicArr[indexPath.item])
        vc.tableView.scrollsToTop = true
        cell.contentView.addSubview(vc.view)
        vc.view.frame = cell.bounds

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // 通过topic找出控制器
        let vc = channelVc(withTopic: topicArr[indexPath.row])
        // 将点击状态栏滚动至顶的功能关闭
        vc.tableView.scrollsToTop = false
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        guard offsetX >= 0 && offsetX <= scrollView.contentSize.width-mainWidth else {
            return
        }
        let process = offsetX / mainWidth
        topicView.process = process
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let processInt = Int(scrollView.contentOffset.x / mainWidth)
        topicView.processInt = processInt
    }
    
    private func channelVc(withTopic topic: String) -> OYNewsChannelVC {
        guard let vc = channelVcCache[topic] else {
            let newVc = OYNewsChannelVC()
            // 强引用控制器并缓存
            addChildViewController(newVc)
            channelVcCache[topic] = newVc
            newVc.type = topic
            return newVc
        }
        return vc
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

}
