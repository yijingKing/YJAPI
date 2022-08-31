//
//  YJResponseAdapter.swift
//  YJAPI
//
//  Created by 祎 on 2022/8/30.
//

import Foundation

/// 请求适配器
public protocol YJResponseAdapter {
    associatedtype YJResponseType: Codable
    typealias YJResult = Result<YJResponseType?, Error>
    
    func adapter(response: YJResponseType?, error: Error?, success:((YJResponseType?) -> Void)?, failure: ((Error) -> Void)?)
}

public extension YJResponseAdapter {
    
    func adapter(response: YJResponseType?, error: Error?, success:((YJResponseType?) -> Void)?, failure: ((Error) -> Void)?) {
        if let response = response {
            success?(response)
        } else {
            if let error = error {
                failure?(error)
            }
        }
    }
}
