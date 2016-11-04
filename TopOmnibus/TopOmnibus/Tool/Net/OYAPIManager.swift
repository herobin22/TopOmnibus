//
//  OYAPIManager.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/2.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit
import YYModel

//MARK: API
let WeChatAPI: String = String("http://v.juhe.cn/weixin/query")
let WeChatKey: String = "1d3df1efbd6fccc5d2a1a9338d36ccdf"

let NewsAPI: String = "http://v.juhe.cn/toutiao/index"
let NewsKey: String = "857b3edf87eb698c078c297eb04b6cfa"
let NewsTopicKeys: [String] = ["top", "shehui", "guonei", "guoji", "yule", "tiyu", "junshi", "keji", "caijing", "shishang"]
let NewsTopics: [String] = ["头条", "社会", "国内", "国际", "娱乐", "体育", "军事", "科技", "财经", "时尚"]

class OYAPIManager: NSObject {
    static let sharedManager: OYAPIManager = {
        let instance = OYAPIManager()
        return instance
    }()
    
    func loadWeChatData(parameters:Any? ,success:(([OYWeChatModel]) ->Void)? , failure:((URLSessionDataTask?, Error) ->Void)?) -> Void {
        var params = [String : Any]()
        if let param = parameters {
            params = param as! [String : Any]
        }
        params["key"] = WeChatKey
        OYHTTPSessionManager.sharedManager.request(type: .POST, URLString: WeChatAPI, parameters: params, success: { (_, object) in
            let resultObject = object as! [String : AnyObject]
            if resultObject["error_code"] as! Int == 0 {// 成功
                let result = (resultObject["result"] as! [String : AnyObject])
                let list = result["list"] as! [AnyObject]
                var models: [OYWeChatModel] = [OYWeChatModel]()
                for i in 0..<list.count {
                    let model = OYWeChatModel(dict: list[i] as! [String : Any])
                    models.append(model)
                }
                success?(models)
            }
            }, failure: failure)
    }
    
    func loadNewsData(type:String? ,success:(([OYNewsModel]) ->Void)? , failure:((URLSessionDataTask?, Error) ->Void)?) -> Void {
        var params = [String : Any]()
        if type != nil {
            params["type"] = type!
        }
        params["key"] = NewsKey
        params["pno"] = 2
        OYHTTPSessionManager.sharedManager.request(type: .GET, URLString: NewsAPI, parameters: params, success: { (_, object) in
            let resultObject = object as! [String : Any]
            let result = (resultObject["result"] as! [String : AnyObject])
            let list = result["data"] as! [AnyObject]
            var models: [OYNewsModel] = [OYNewsModel]()
            for i in 0..<list.count {
                let model = OYNewsModel(dict: list[i] as! [String : AnyObject])
                models.append(model)
            }
            success?(models)
            }, failure: failure)
    }
}
