//
//  NetworkAPI.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/25.
//  Copyright © 2018 johnson. All rights reserved.
//

import Foundation
import Moya

// MARK: -- 域名设置
struct BaseUrl {
    static let product: String = "http://apiv2.zjbird.com/"
    static let develop: String = "http://apiv2.e2.fat.zjbird.com/"
}
// MARK: -- 定义返回的JSON数据字段key名称
let RESPONSE_CODE = "code"     //状态码
let RESPONSE_MESSAGE = "msg"  //返回信息描述
let RESPONSE_RESULT = "result" //具体数据

// MARK: -- 返回状态码设置
struct ResponseCode {
    static let success = "200"
}
// MARK: -- 请求头设置
struct Header {
    static let os: String = "iOS"

    static var osVersion: String {
        return UIDevice.jy_systemVersion
    }

    static var appVersion:String {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }
    // 一些登录状态还没有放进去
    static func toDictionary() -> Dictionary<String, String> {
        return ["platform": os]
    }
}
// MARK: -- 接口定义
enum API {
//    case noParamsApi // 无参数接口
//    case allParamsApi(param1: String, param2:String) // 全部参数分开写的接口
//    case dicParamsApi(Dict:[String:Any]) // 将参数包装成字典传入的接口
    case login(mobile:String, password:String)
    
}

// TargetType是moya里面的协议
extension API: TargetType {
    
    var baseURL: URL {
        #if DEBUG
        return URL.init(string: BaseUrl.develop)!
        #else
        return URL.init(string: BaseUrl.product)!
        #endif
    }
    
    var path: String {
        switch self {
        case .login(_,_):
            return "api/worker/login" // 密码登录
            
        }
    }
//    var fullPath: String {
//        return baseURL + path
//    }
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    // 这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    // 这个就是API里面的核心。类似理解为AFN里的URLRequest
    var task: Task {
        switch self {
        case let .login(mobile, password):
            return .requestParameters(parameters: ["mobile":mobile, "password":password], encoding: JSONEncoding.default)
            //["mobile":mobile, "password":password]
        }
    }
    
    var headers: [String : String]? {
        return Header.toDictionary()
    }
    
    
    
}
