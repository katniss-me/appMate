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
    var token:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //로그인 버튼 추가
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .custom("user_work_history")])
        loginButton.center = view.center
        loginButton.delegate = self
        view.addSubview(loginButton)
    }
    
    /* 로그인 구현 (로그인버튼 델리게이트) */
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult){
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("Cancelled")
        case .success( _, _, let accessToken):
            DataCenter.sharedInstance.nManager.sendToken(string: accessToken.authenticationToken)
            
            /*1. 서버에서 토큰값을 주면 userdefaults에 저장
             2. 서버에 메일이 없으면 최초 사용자 -> 설정창으로 이동
             3. 서버에 메일이 있으면 경험 사용자 -> 바로 메인창으로 이동 */
            
            // 최초 사용자
            let settingVC:SettingViewController = self.storyboard!.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
            self.navigationController!.pushViewController(settingVC, animated: true)
        }
    }
    
    /* 로그아웃 구현 (로그인버튼 델리게이트) */
    func loginButtonDidLogOut(_ loginButton: LoginButton){
        print("로그아웃!!")
    }
    
}

