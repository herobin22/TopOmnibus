//
//  OYNewsTopicView.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/3.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit

class OYNewsTopicView: UIView {

    var topicArr: [String] = NewsTopics
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: self.bounds, collectionViewLayout: self.flowLayout)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        self.addSubview(self.collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: mainWidth, height: 32)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 50, height: 32)
        collectionView.register(OYNewsTopicCell.self, forCellWithReuseIdentifier: OYNewsTopicCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
}
