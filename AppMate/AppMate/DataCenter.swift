//
//  DataCenter.swift
//  AppMate
//
//  Created by HanYoungsoo on 2017. 3. 16..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit

class DataCenter: NSObject {
    //singletone 생성
    static let sharedInstance = DataCenter()
    
    //singletone 초기화
    private override init(){
        _userdefaults = UserDefaults.standard
        _nManager = NetworkManager()
    }


    /* getter, setter 설정 */
    private var _userdefaults:UserDefaults;
    var userdefaults:UserDefaults{
        get{
            return _userdefaults
        }
        set(newVal){
            _userdefaults = newVal
        }
    }
    
    private var _nManager:NetworkManager;
    var nManager:NetworkManager{
        get{
            
            return _nManager
        }
        set(newVal){
            _nManager = newVal
        }
    }
}
