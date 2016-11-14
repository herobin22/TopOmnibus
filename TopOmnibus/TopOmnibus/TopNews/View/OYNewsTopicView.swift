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

    lazy var dataSource: [OYNewsTopicModel] = {
        var arr = [OYNewsTopicModel]()
        for topic in NewsTopics {
            let model = OYNewsTopicModel(topic: topic)
            arr.append(model)
        }
        return arr
    }()
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: self.bounds, collectionViewLayout: self.flowLayout)
    }()
    
    /// 点击回调
    var didSelectTopic: ((_ num: Int) ->Void)?
    
    /// 当前滚动的进度,用于改变topic的颜色
    var process: CGFloat = 0 {
        didSet {
            let intProcess = Int(process)
            let firstProcess = process - CGFloat(intProcess)
            let secondProcess = CGFloat(intProcess+1) - process
            
            let firstModel = self.dataSource[intProcess]
            firstModel.process = 1-firstProcess
            if intProcess == self.dataSource.count-1 {// 防止数组越界
                collectionView.reloadItems(at: [IndexPath(item: intProcess, section: 0)])
                return
            }
            let secondModel = self.dataSource[intProcess+1]
            secondModel.process = 1-secondProcess
            collectionView.reloadItems(at: [IndexPath(item: intProcess, section: 0), IndexPath(item: intProcess+1, section: 0)])
        }
    }
    /// 当前滚动的进度,用于改变topic的偏移量
    var processInt: Int = 0 {
        didSet {
            /// 记录indexPath
            lastIndexPath = IndexPath(item: processInt, section: 0)
            let offsetX = (CGFloat(processInt)+0.5)*flowLayout.itemSize.width
            if offsetX < mainWidth/2 {
                collectionView.setContentOffset(CGPoint.zero, animated: true)
                return
            }
            if (collectionView.contentSize.width-offsetX) < mainWidth/2 {
                collectionView.setContentOffset(CGPoint(x: collectionView.contentSize.width-mainWidth, y: 0), animated: true)
                return
            }
            collectionView.setContentOffset(CGPoint(x: offsetX-mainWidth/2, y: 0), animated: true)
        }
    }
    /// 记录上一个点击的item
    fileprivate var lastIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        self.addSubview(self.collectionView)
        collectionView.contentInset = UIEdgeInsets.zero
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.scrollsToTop = false
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
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OYNewsTopicCellID, for: indexPath) as! OYNewsTopicCell
        cell.model = self.dataSource[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 刷新上一个cell
        let model = self.dataSource[lastIndexPath.item]
        model.process = 0
        collectionView.reloadItems(at: [lastIndexPath])
        
        didSelectTopic?(indexPath.item)
        lastIndexPath = indexPath
        processInt = indexPath.item
    }
}
