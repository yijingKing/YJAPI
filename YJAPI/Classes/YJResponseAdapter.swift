/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import Foundation

/// 请求适配器
public protocol YJResponseAdapter {
    associatedtype YJResponseType: Codable
    typealias YJResult = Result<YJResponseType?, Error>
    
    /// 数据结果处理
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
