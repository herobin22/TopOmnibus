//
//  OYWeChatCell.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/2.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import WebKit
let OYWeChatCellID = NSStringFromClass(OYWeChatVC.self)

class OYWeChatCell: UITableViewCell {

    private lazy var iconView: UIImageView = UIImageView()
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var sourceLabel: UILabel = UILabel()
    
    var model: OYWeChatModel? {
        didSet {
            iconView.sd_setImage(with: URL(string: (model?.firstImg)!), placeholderImage: UIImage(named: "colorBg"))
            titleLabel.text = model?.title
            sourceLabel.text = "微信公众号: \((model?.source)!)"
            
            titleLabel.sizeToFit()
            sourceLabel.sizeToFit()
            layoutIfNeeded()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: leftRightMargin, bottom: 0, right: leftRightMargin)
        self.selectionStyle = .none
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK:-- SetupUI
    private func setupUI() {
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(sourceLabel)
        
        sourceLabel.textColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        sourceLabel.font = UIFont.systemFont(ofSize: 13)
        
        titleLabel.numberOfLines = 0
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(topBottomMargin)
            make.left.equalTo(contentView).offset(leftRightMargin)
            make.right.equalTo(iconView.snp.left).offset(-interMargin)
        }
        sourceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(interMargin)
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalTo(contentView).offset(-topBottomMargin)
        }
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel)
            make.right.equalTo(contentView).offset(-leftRightMargin)
            make.width.equalTo(mainWidth/4.0)
            /// 这里要注意,两种约束方式都有问题:
            /// 1.与contentView的底部进行约束:make.bottom.equalTo(contentView).offset(-topBottomMargin)
            /// 2.与sourceLabel的底部进行约束:make.bottom.equalTo(sourceLabel)
            /// 这两种写法的本质是一样的,导致的问题: contentView的底部与imageview有约束,当图片加载后,图片本身也有高度,就会导致cell的高度变高, 与预期不符
            /// 正确的做法: 与self进行约束, 当contentview的约束正确后,整个cell的高度也有自动计算出来了,那么再跟self底部约束, 也可以得到正确的布局
            make.bottom.equalTo(self).offset(-topBottomMargin)
        }
        contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
}
