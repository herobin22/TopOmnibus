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
        
        sourceLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        sourceLabel.font = UIFont.systemFont(ofSize: 13)
        
        titleLabel.numberOfLines = 0
        
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(topBottomMargin)
            make.right.equalTo(contentView).offset(-leftRightMargin)
            make.width.equalTo(mainWidth/4.0)
//            make.height.equalTo(iconView.snp.width)
            make.bottom.equalTo(self).offset(-topBottomMargin)
        }
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
        contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
}
