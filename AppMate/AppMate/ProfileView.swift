//
//  ProfileView.swift
//  googleMapTest
//
//  Created by HanYoungsoo on 2017. 3. 11..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
//    var button:UIButton!
    var profileIme:UIImageView!
    var primary_ID:Int!
    var isFlag:Bool!
    
    override init (frame:CGRect) {
        super.init(frame : frame)
        self.layer.cornerRadius = (self.frame.size.width / 2)
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.5
        
    }
    convenience init(imgString: String, primary_ID: Int, isFlag: Bool){
        
        self.init(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
        self.primary_ID = primary_ID
        self.isFlag = isFlag
        profileIme = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        profileIme.image = UIImage(named: imgString)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(profileIme)
    
    }
    
    func getUserInfo()->(primary_ID:Int, isFlag:Bool)?{
        
        print(primary_ID)
        return (primary_ID , isFlag)
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
