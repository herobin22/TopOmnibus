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
}
