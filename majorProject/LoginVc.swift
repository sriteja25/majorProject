//
//  ViewController.swift
//  pictogram
//
//  Created by Sriteja Chilakamarri on 15/03/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginVc: UIViewController,GIDSignInDelegate,GIDSignInUIDelegate {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error != nil){
        
        print(error.localizedDescription)
        
        }else{
        
        let idtoken = user.authentication.idToken
        let name = user.profile.name
        let email = user.profile.email
        
        
        }
    }


}

