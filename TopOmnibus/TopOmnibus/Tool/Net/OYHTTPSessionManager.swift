//
//  OYHTTPSessionManager.swift
//  TopOmnibus
//
//  Created by Gold on 2016/11/2.
//  Copyright © 2016年 herob. All rights reserved.
//

import UIKit
import AFNetworking

enum RequestType {
    case GET
    case POST
}

class OYHTTPSessionManager: AFHTTPSessionManager {
    static let sharedManager: OYHTTPSessionManager = {
        let instance = OYHTTPSessionManager()
        
        // failed: unacceptable content-type: text/plain
        // 添加解析类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
    
        return instance
    }()
    
    /// GET/POST请求
    func request(type: RequestType, URLString: String, parameters: Any?, progress: ((Progress) -> Void)?, success: ((URLSessionDataTask, Any?) -> Void)?, failure: ((URLSessionDataTask?, Error) -> Void)?) -> Void {
        /// 封闭联网指示器指示
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let success1 = {
            (task: URLSessionDataTask, result: Any?) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            success?(task, result)
        }
        let failure1 = {
            (task: URLSessionDataTask?, error: Error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            failure?(task, error)
        }
        if type == .GET {
            self.get(URLString, parameters: parameters, progress: progress, success: success1, failure: failure1)
        }else if type == .POST {
            self.post(URLString, parameters: parameters, progress: progress, success: success1, failure: failure1)
        }
    }
    
    /// 不需要进度
    func request(type: RequestType, URLString: String, parameters: Any?, success: ((URLSessionDataTask, Any?) -> Void)?, failure: ((URLSessionDataTask?, Error) -> Void)?) -> Void {
        request(type: type, URLString: URLString, parameters: parameters, progress: nil, success: success, failure: failure)
    }
}
