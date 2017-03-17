//
//  ProfileView.swift
//  googleMapTest
//
//  Created by HanYoungsoo on 2017. 3. 11..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    private var profileIme:UIImageView!
    private var _user_id:String?
    var user_id:String{
        get{
            return _user_id!
        }
        set(newVal){
            _user_id = newVal
        }
    }
    override init (frame:CGRect) {
        super.init(frame : frame)
        self.layer.cornerRadius = (self.frame.size.width / 2)
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 1.5
    }
    
    convenience init(imgString: String, user_id: String){
        self.init(frame:CGRect(x: 0, y: 0, width: 70, height: 70))
        self.user_id = user_id
        profileIme = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        profileIme.image = UIImage(named: imgString)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(profileIme)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
