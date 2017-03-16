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
        
        if AccessToken.current != nil{
            getUserInfo()
        }
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
            getUserInfo()
        }
    }
    
    
    func loginButtonDidLogOut(_ loginButton: LoginButton){
        
        
    }
    func getUserInfo() {
        let params = ["fields":"name,email,work"]
        let graphRequest = GraphRequest(graphPath: "me", parameters: params)
        graphRequest.start { (urlResponse, requestResult) in
            switch requestResult {
            case .failed(let error):
                print(error)
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    DataCenter.sharedInstance.logInUserInfo = responseDictionary
                    
                    let mapVC : MapViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                    
                    self.navigationController?.pushViewController(mapVC, animated: true)
                    
                }
            }
        }
    }
}
