/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import Foundation
import Alamofire


/// 编码方式
public enum YJEncodeType {
    /// JSON参数
    case encoding
    /// Form参数
    case encoder
}
/// 请求配置
public protocol YJRequestConfig {
    /// 描述
    var describe: String { get }
    /// 请求参数
    associatedtype ParamType: YJParamType
    /// 请求路径
    var url: String { get }
    /// 请求方式
    var method: HTTPMethod { get }
    /// 请求参数
    var parameters: ParamType? { get }
    /// 请求头
    var headers: [HTTPHeader] { get }
    /// 编码方式(JSON参数编码器 Content-Type 为 application/json)
    var parameterEncoder: ParameterEncoder { get }
    /// 编码方式(Form参数编码器 Content-Type 为application/x-www-form-urlencoded; charset=utf-8)
    var parameterEncoding: ParameterEncoding { get }
    /// 超时时间
    var timeOutIntervel: TimeInterval { get }
    /// 拦截器
    var interceptor: RequestInterceptor? { get }
    /// 编码方式(默认encoder)
    var encodeType: YJEncodeType? { get }
    /// 单独隐藏log打印(默认开启)
    var openLog: Bool { get }
}

public extension YJRequestConfig {
    /// 超时时间
    var timeOutIntervel: TimeInterval {
        return 30
    }
    /// 请求修饰符
    func requestModifier(req: inout URLRequest) throws {
        req.timeoutInterval = timeOutIntervel
    }
    /// 编码方式(JSON参数编码器)
    var parameterEncoder: ParameterEncoder {
        return self.method == .get ? URLEncodedFormParameterEncoder.urlEncodedForm : JSONParameterEncoder.json
    }
    /// 编码方式(Form参数编码器)
    var parameterEncoding: ParameterEncoding {
        return self.method == .get ? URLEncoding.default : JSONEncoding.default
    }
    ///拦截器
    var interceptor: RequestInterceptor? {
        return nil
    }
    /// 编码方式
    var encodeType: YJEncodeType? {
        return .encoder
    }
    /// 单独隐藏log打印(默认开启)
    var openLog: Bool {
        return true
    }
}

public protocol YJParamType: Codable {
    var param: [String: Any]? { get }
}

public extension YJParamType {
    var param: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data) else { return nil }
        return json as? [String: Any]
    }
}
