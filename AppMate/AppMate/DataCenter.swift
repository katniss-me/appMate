//
//  DataCenter.swift
//  AppMate
//
//  Created by HanYoungsoo on 2017. 3. 14..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit

class DataCenter: NSObject {
    
    var _logInUserInfo:Dictionary<String, Any>?
    var logInUserInfo:Dictionary<String, Any>?{
        get{
            return _logInUserInfo        }
        set(newVal){
            _logInUserInfo = newVal
        }
    }
    
    static let sharedInstance = DataCenter()
    
}
