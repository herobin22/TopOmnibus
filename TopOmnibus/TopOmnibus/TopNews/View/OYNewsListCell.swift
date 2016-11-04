//
//  OYNewsListCell.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/4.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit
import SDWebImage

let OYNewsListCellID: String = NSStringFromClass(OYNewsTopicCell.self)

class OYNewsListCell: UITableViewCell {
    
    var model: OYNewsModel? {
        didSet {
            let newModel = model!
            titleLabel.text = newModel.title
            authorLabel.text = newModel.author_name
            dateLabel.text = newModel.date
            let width = (mainWidth-CGFloat(newModel.picArr.count-1)*pictureInterMargin-2*leftRightMargin)/CGFloat(newModel.picArr.count)
            // 更新约束
            picView1.snp.updateConstraints { (make) in
                make.width.equalTo(width)
                make.height.equalTo(width*0.75)
            }
            switch newModel.picArr.count {
            case 1:
                picView2.isHidden = true
                picView3.isHidden = true
                picView1.sd_setImage(with: URL(string: newModel.picArr[0]))
                break
            case 2:
                picView2.isHidden = false
                picView3.isHidden = true
                picView1.sd_setImage(with: URL(string: newModel.picArr[0]))
                picView2.sd_setImage(with: URL(string: newModel.picArr[1]))
                break
            case 3:
                picView2.isHidden = false
                picView3.isHidden = false
                picView1.sd_setImage(with: URL(string: newModel.picArr[0]))
                picView2.sd_setImage(with: URL(string: newModel.picArr[1]))
                picView3.sd_setImage(with: URL(string: newModel.picArr[2]))
                break
            default:
                break
            }
        }
    }
    let titleLabel: UILabel = UILabel()
    let picView1: UIImageView = UIImageView()
    let picView2: UIImageView = UIImageView()
    let picView3: UIImageView = UIImageView()
    let authorLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        contentView.addSubview(titleLabel)
        contentView.addSubview(picView1)
        contentView.addSubview(picView2)
        contentView.addSubview(picView3)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
        let width = (mainWidth-2*pictureInterMargin-2*leftRightMargin)/3
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(topBottomMargin)
            make.left.equalTo(contentView).offset(leftRightMargin)
            make.right.equalTo(contentView).offset(-leftRightMargin)
        }
        picView1.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(interMargin)
            make.left.equalTo(contentView).offset(leftRightMargin)
            make.width.equalTo(width)
            make.height.equalTo(width).multipliedBy(0.75)
        }
        picView2.snp.makeConstraints { (make) in
            make.top.equalTo(picView1)
            make.left.equalTo(picView1.snp.right).offset(pictureInterMargin)
            make.width.height.equalTo(picView1)
        }
        picView3.snp.makeConstraints { (make) in
            make.top.equalTo(picView2)
            make.left.equalTo(picView2.snp.right).offset(pictureInterMargin)
            make.width.height.equalTo(picView2)
        }
        authorLabel.textColor = #colorLiteral(red: 0.8644071691, green: 0.862745098, blue: 0.862745098, alpha: 1)
        authorLabel.font = UIFont.systemFont(ofSize: 13)
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(leftRightMargin)
            make.top.equalTo(picView1.snp.bottom).offset(interMargin)
        }
        dateLabel.textColor = #colorLiteral(red: 0.8644071691, green: 0.862745098, blue: 0.862745098, alpha: 1)
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(authorLabel.snp.right).offset(leftRightMargin)
            make.centerY.equalTo(authorLabel)
            make.bottom.equalTo(contentView).offset(-topBottomMargin)
        }
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}
