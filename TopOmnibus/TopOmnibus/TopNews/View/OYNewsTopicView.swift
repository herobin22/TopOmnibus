//
//  OYNewsTopicView.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/3.
//  Copyright © 2016年 herob. All rights reserved.
//
// 将标题滚动条分离在一个view里

import UIKit

class OYNewsTopicView: UIView {

    var topicArr: [String] = NewsTopics
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: self.bounds, collectionViewLayout: self.flowLayout)
    }()
    
    /// 点击回调
    var didSelectTopic: ((_ num: Int) ->Void)?
    
    /// 当前滚动的进度,用于改变topic的颜色以及偏移量
    var process: CGFloat = 0 {
        didSet {
            let intProcess = Int(process)
            let firstProcess = process - CGFloat(intProcess)
            let secondProcess = CGFloat(intProcess+1) - process
            
            let firstCell = self.collectionView.cellForItem(at: IndexPath(item: intProcess, section: 0)) as? OYNewsTopicCell
            firstCell?.process = 1-firstProcess
            let secondCell = self.collectionView.cellForItem(at: IndexPath(item: intProcess+1, section: 0)) as? OYNewsTopicCell
            secondCell?.process = 1-secondProcess
            
            let offsetX = (process+0.5)*flowLayout.itemSize.width
            let offsetMaxX = (process+1.5)*flowLayout.itemSize.width
            if offsetX < mainWidth/2 || (collectionView.contentSize.width-offsetMaxX) < mainWidth/2 {
                return
            }
            collectionView.contentOffset = CGPoint(x: offsetX+mainWidth, y: 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        self.addSubview(self.collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = #colorLiteral(red: 0.8644071691, green: 0.862745098, blue: 0.862745098, alpha: 1)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        collectionView.register(OYNewsTopicCell.self, forCellWithReuseIdentifier: OYNewsTopicCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
        flowLayout.itemSize = CGSize(width: 50, height: collectionView.bounds.size.height)
    }
}

extension OYNewsTopicView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OYNewsTopicCellID, for: indexPath) as! OYNewsTopicCell
        cell.topic = self.topicArr[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? OYNewsTopicCell
        cell?.process = 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(collectionView.indexPathsForSelectedItems)
        didSelectTopic?(indexPath.item)
        process = CGFloat(indexPath.item)
    }
}
