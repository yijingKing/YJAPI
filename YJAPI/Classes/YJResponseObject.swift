/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import Foundation
import Alamofire

public struct YEXError: Codable {
    
    public var code: Int?
    public var msg: String?
    
    public static let unReachAbleCode = 999999
    public init(code: Int? = nil, msg: String? = nil) {
        self.code = code
        self.msg = msg
    }
}

extension YEXError: LocalizedError {
    
    public var errorDescription: String? {
        return msg
    }
}

public struct YJResponseObject<T:Codable>: Codable {
    
    public var code: Int?
    
    public var msg: String?
    
    public var result: T?
    
    public var error: String?
    
}

extension YJResponseObject: LocalizedError {
    public var errorDescription: String? {
        return error ?? msg
    }
    
    public var yexError: YEXError {
        return YEXError(code: code ?? -1, msg: errorDescription ?? "")
    }
}
