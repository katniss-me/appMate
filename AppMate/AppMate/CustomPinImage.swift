//
//  CustomPinImage.swift
//  AppMate
//
//  Created by HanYoungsoo on 2017. 3. 17..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit

class CustomPinImage: UIImage {
    private var  _user_id:String?
    var user_id:String?{
        get{
            return _user_id
        }
        set(newVal){
            _user_id = newVal
        }
        
    }
    override init?(data: Data){
        super.init(data: data)
    }
    
    convenience init(data:Data,id user_id:String) {
        self.init(data:data)!
        print(user_id)
        _user_id = user_id
        
        
    }
    
    required convenience init(imageLiteralResourceName name: String) {
        fatalError("init(imageLiteralResourceName:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
