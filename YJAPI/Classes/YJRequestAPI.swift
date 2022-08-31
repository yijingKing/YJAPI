/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import Foundation
import Alamofire

/// 网络请求
public protocol YJRequestAPI: YJRequestConfig, YJResponseAdapter {
    /// 数据打印(默认开启,可重定义)
    func log(_ data: Data?, error: Error?)
}

public extension YJRequestAPI {
    
    func request(completion: @escaping (_ result: YJResult) -> Void) {
        request { result in
            completion(.success(result))
        } failure: { error in
            completion(.failure(error))
        }
    }
    
    func request(success: ((_ resp: YJResponseType?) -> Void)?, failure: ((_ error: Error) -> Void)?) {
        ///超时
        AF.sessionConfiguration.timeoutIntervalForRequest = self.timeOutIntervel
        var dataRequest: DataRequest?
        
        switch self.encodeType {
        case .encoding:
            var para: [String: Any]?
            if let data = try? JSONEncoder().encode(self.parameters) {
                if let json = try? JSONSerialization.jsonObject(with: data) {
                    para = json as? [String: Any]
                }
            }
            ///JSON参数
            dataRequest = AF.request(self.url, method: self.method, parameters: para, encoding: self.parameterEncoding, headers: HTTPHeaders(self.headers), interceptor: self.interceptor, requestModifier: self.requestModifier(req:))
        case .encoder:
            ///Form参数
            dataRequest = AF.request(self.url, method: self.method, parameters: self.parameters, encoder: self.parameterEncoder, headers: HTTPHeaders(self.headers), interceptor: self.interceptor, requestModifier: self.requestModifier(req:))
            
        default:
            break
        }
        
        dataRequest?.responseData { dataResponse in
            
            var lastError: Error?
            var response: YJResponseType?
            var lastData: Data?
            switch dataResponse.result {
            case .success(let data):
                do {
                    let obj = try JSONDecoder().decode(YJResponseType.self, from: data)
                    lastData = data
                    response = obj
                } catch  {
                    lastError = error
                }
            case .failure(let afError):
                lastError = afError
            }
            log(lastData, error: lastError)
            adapter(response: response, error: lastError, success: success, failure: failure)
        }
    }
    /// 数据打印(默认开启,可重定义)
    func log(_ data: Data?, error: Error?) {
        
        if !openLog {
            return
        }
#if DEBUG
        print("🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼")
        print("""
        接口描述: \(describe)
        url: \(url)
        header: \(headers)
        method: \(method.rawValue)
        param: \(parameters?.toJson() ?? "")
        """)
        print("===============================================")
        if let err = error {
            print("""
            error: \(err)
            """)
        }
        if let data = data {
            print("""
            response: \(toJson(data) ?? ""))
            """)
        }
        print("🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼")
#endif
    }
}

extension YJRequestAPI {
    func toJson(_ data: Data) -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: data) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
extension Encodable {
    func toJson() -> String? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
