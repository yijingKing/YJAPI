//
//  ViewController.swift
//  YJAPI
//
//  Created by 1091676312@qq.com on 08/30/2022.
//  Copyright (c) 2022 1091676312@qq.com. All rights reserved.
//

import UIKit
import Alamofire
import YJAPI
import JKAPI


struct Home: BaseAPI {
    
    typealias RequestType = LoginModel
    
    var urlPath: String {
        return "/app/login/auth/pwd"
    }
    
    struct ParamType: YJParamType {
        var loginName: String?
        var password: String?
    }
    
    var describe: String {
        return "密码登录"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var parameters: ParamType?
}

protocol BaseAPI: YJRequestAPI where YJResponseType == YJResponseObject<RequestType> {
    
    associatedtype RequestType: Codable
    
    var urlPath: String { get }
    
}

extension BaseAPI {
    
    var url: String {
        return "https://pre.chaoxiangmai.cn/api" + urlPath
    }
    
    var headers: [HTTPHeader] {
        return [HTTPHeader(name: "phoneType", value: "ios"),HTTPHeader(name: "xPlatform", value: "5"),HTTPHeader(name: "xVersion", value: "1.2.0")]
    }
    var encodeType: YJEncodeType? {
        return .encoding
    }
    var openLog: Bool {
        return true
    }
    
}

//struct Interceptor: RequestInterceptor {
//
//    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        completion(.success(urlRequest))
//    }
//
//
//    func adapt(_ urlRequest: URLRequest, using state: RequestAdapterState, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        // token
//        var request = urlRequest
//        request.headers.add(HTTPHeader(name: "phoneType", value: "ios"))
//        request.headers.add(HTTPHeader(name: "xPlatform", value: "5"))
//        request.headers.add(HTTPHeader(name: "xVersion", value: "1.2.0"))
//        completion(.success(request))
//    }
//}

struct LoginModel: Codable {
    var token: String?
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Home(parameters: .init(loginName: "18250808695", password: "qwer1234")).request { result in
            switch result {
            case .success(let obj):
                print("131231212123====\(obj?.result?.token)")
                
            case .failure(let error): print("wqeqweqweewqe=====\(error)")
            }
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


