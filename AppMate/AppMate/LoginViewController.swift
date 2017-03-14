//
//  ViewController.swift
//  AppMate
//
//  Created by HanYoungsoo on 2017. 3. 14..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController, LoginButtonDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .custom("user_work_history")])
        loginButton.center = view.center
        loginButton.delegate = self
        
        
        view.addSubview(loginButton)
    }
    
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult){
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("Cancelled")
        case .success( _, _, let accessToken):
            print(accessToken)
            facebookLogin()
        }

    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton){
        
        print("로그아웃!!")
        
        
    }
    
    func facebookLogin() {
        if AccessToken.current != nil {
            let params = ["fields": "email, name, picture, work"]
            let graphRequest = GraphRequest(graphPath: "me", parameters: params)
            graphRequest.start { (urlResponse, requestResult) in
                switch requestResult {
                case .failed(let error):
                    print(error)
                case .success(let graphResponse):
                    if let responseDictionary = graphResponse.dictionaryValue {
                        print(responseDictionary["name"]!)
                        if(responseDictionary["work"] != nil){
                            let responseArr =  responseDictionary["work"] as! NSArray
                            for index in 0...responseArr.count-1{
                                print(responseArr[index])
                                print("//////////////////////////")
                            }
                            
                        }
                    }
                }
            }
        } else {
            print("토큰값이 없습니다.")
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

