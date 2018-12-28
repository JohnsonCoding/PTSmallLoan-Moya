//
//  NetworkManager.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/24.
//  Copyright © 2018 johnson. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

// 超时时长
private var requestTimeOut: Double = 30
//成功数据的回调
typealias successCallback = ((String) -> (Void))
//失败的回调
typealias failedCallback = ((String) -> (Void))
//网络错误的回调
typealias errorCallback = (() -> (Void))

struct NetworkErrorDescription {
    static let network = "网络不给力，请检查网络设置"
    static let server  = "网络请求失败，请稍后再试"
    static let parser  = "网络请求异常"
}

enum NetworkErrorType {
    case networkError  // 无网络连接
    case serverError   // 服务异常,非200
    case parserError   // 数据解析错误
    case othersError(description: String)   // 服务器返回的错误描述
    
    var descriptions: String {
        switch self {
        case .networkError:
            return NetworkErrorDescription.network
        case .serverError:
            return NetworkErrorDescription.server
        case .parserError:
            return NetworkErrorDescription.parser
        case .othersError(let description):
            return description
        }
    }
}
// MARK: -- 网络请求的基本设置,这里可以拿到是具体的哪个网络请求，可以在这里做一些设置
private let myEndpointClosure = { (target: API) -> Endpoint in
    //这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug
    let url = target.baseURL.absoluteString + target.path
    
    /*
     如果需要在每个请求中都添加类似token参数的参数请取消注释下面代码
     👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
     */
    //    let additionalParameters = ["token":"888888"]
    //    let defaultEncoding = URLEncoding.default
    //    switch target.task {
    //        ///在你需要添加的请求方式中做修改就行，不用的case 可以删掉。。
    //    case .requestPlain:
    //        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
    //    case .requestParameters(var parameters, let encoding):
    //        additionalParameters.forEach { parameters[$0.key] = $0.value }
    //        task = .requestParameters(parameters: parameters, encoding: encoding)
    //    default:
    //        break
    //    }
    /*
     👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆
     如果需要在每个请求中都添加类似token参数的参数请取消注释上面代码
     */
    
    var endpoint = Endpoint (
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
    )
    requestTimeOut = 30 //每次请求都会调用endpointClosure 到这里设置超时时长 也可单独每个接口设置
//    switch target {
//    case .login:
//        requestTimeOut = 5
//        return endpoint
//
//    }
    return endpoint
    
}

// MARK: -- 网络请求的设置
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do{
        var request = try endpoint.urlRequest()
        // 设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            print("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")"+"请求参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        }else{
            print("\(request.url!)"+"\(String(describing: request.httpMethod))")
        }
        done(.success(request))
        
    }catch{
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

/*   设置ssl
 let policies: [String: ServerTrustPolicy] = [
 "example.com": .pinPublicKeys(
 publicKeys: ServerTrustPolicy.publicKeysInBundle(),
 validateCertificateChain: true,
 validateHost: true
 )
 ]
 */

// 用Moya默认的Manager还是Alamofire的Manager看实际需求。HTTPS就要手动实现Manager了
//private public func defaultAlamofireManager() -> Manager {
//
//    let configuration = URLSessionConfiguration.default
//
//    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//
//    let policies: [String: ServerTrustPolicy] = [
//        "ap.grtstar.cn": .disableEvaluation
//    ]
//    let manager = Alamofire.SessionManager(configuration: configuration,serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
//
//    manager.startRequestsImmediately = false
//
//    return manager
//}

// MARK: -- NetworkActivityPlugin插件用来监听网络请求，界面上做相应的展示. 但这里我没怎么用这个。。。 loading的逻辑直接放在网络处理里面了
private let networkPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
    print("networkPlugin \(changeType)")
    //targetType 是当前请求的基本信息
    switch(changeType){
    case .began:
        print("开始请求网络")
        
    case .ended:
        print("结束")
    }
}

// MARK: -- 网络请求发送的核心初始化方法，创建网络请求对象
let Provider = MoyaProvider<API>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)

// MARK: -- 最常用的网络请求，只需知道正确的结果无需其他操作时候用这个
func NetWorkRequest(_ target: API, completion: @escaping successCallback ){
    NetWorkRequest(target, completion: completion, failed: nil, errorResult: nil)
}
// MARK: -- 需要知道成功或者失败的网络请求， 要知道code码为其他情况时候用这个
func NetWorkRequest(_ target: API, completion: @escaping successCallback , failed:failedCallback?) {
    NetWorkRequest(target, completion: completion, failed: failed, errorResult: nil)
}
// MARK: -- 需要知道成功、失败、错误情况回调的网络请求   像结束下拉刷新各种情况都要判断
func NetWorkRequest(_ target: API, completion: @escaping successCallback, failed:failedCallback? , errorResult: errorCallback?) {
    
    // 先判断网络是否连接,没有的话直接返回
    if !isNetworkConnect {
        print("提示用户网络似乎出现了问题")
        return
    }
    //这里显示loading图
    Provider.request(target) { (result) in
        // 隐藏loading图
        switch result {
        case let .success(response):
            do{
                //这里转JSON用的swiftyJSON框架
                let jsonData = try JSON(data: response.data)
//                print(jsonData)
                //判断后台返回的code码没问题就把数据闭包返回
                if jsonData[RESPONSE_CODE].stringValue == ResponseCode.success {
                    print("返回参数"+"\(jsonData)")
                    // 成功返回的数据是整个返回格式(包括code,msg,result),最好直接返回result???
                    completion(String(data: response.data, encoding: String.Encoding.utf8)!)
                }else{
                    //code!=200 HUD显示错误信息
                    print(" HUD显示后台返回message"+"\(jsonData[RESPONSE_MESSAGE].stringValue)")
                    if failed != nil{
//                        failed!(String(data: response.data, encoding: String.Encoding.utf8)!)
                        failed!(String(jsonData[RESPONSE_MESSAGE].stringValue))
                    }
                }
                
            }catch{
                
            }
        case .failure(_):
            // 在调试的时候总会发现在输出自定义的类与结构体时,会打印很多不想输出的变量,这就有了CustomStringConvertible,CustomDebugStringConvertible这两个协议的用处.
//            guard let error = error as? CustomStringConvertible else {
//                //网络连接失败，提示用户
//                print("网络连接失败")
//                break
//            }
            if errorResult != nil {
                errorResult!()
            }
        }
    }
    
}

// MARK: -- Demo中并未使用，以后如果有数组转json可以用这个。
struct JSONArrayEncoding: ParameterEncoding {
    static let `default` = JSONArrayEncoding()
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        
        guard let json = parameters?["jsonArray"] else {
            return request
        }
        
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        request.httpBody = data
        
        return request
    }
}
