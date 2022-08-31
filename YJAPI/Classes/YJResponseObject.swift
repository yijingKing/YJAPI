//
//  File.swift
//  YJAPI_Example
//
//  Created by 祎 on 2022/8/30.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire

public struct YJResponseObject<T:Codable>: Codable {
    
    public var code: Int?
    
    public var message: String?
    
    public var result: T?
    
    public var error: String?
    
}
