//
//  ViewController.swift
//  pictogram
//
//  Created by Sriteja Chilakamarri on 15/03/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import GoogleSignIn
import AWSCognito
import AWSCore

class LoginVc: UIViewController,GIDSignInDelegate,GIDSignInUIDelegate ,AWSIdentityProviderManager{
    
    var googleIdToekn = ""
    

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
        
        signInToCognito(user: user)
        }
    }
    
    func logins() -> AWSTask<NSDictionary> {
        let result = NSDictionary(dictionary: [AWSIdentityProviderGoogle:googleIdToekn])
        return AWSTask(result: result)
    }
    
    func signInToCognito(user:GIDGoogleUser){
    
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USWest2,
                                                                identityPoolId:"us-west-2:5a019b74-ee3f-4045-a8ca-73cf8fada15a")
        
        let configuration = AWSServiceConfiguration(region:.USWest2, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        credentialsProvider.getIdentityId().continueWith { (task:AWSTask) -> AnyObject? in
            if (task.error != nil) {
                print(task.error!)
                return nil
            }
            
            let syncClient = AWSCognito.default()
            
            // Create a record in a dataset and synchronize with the server
            let dataset = syncClient.openOrCreateDataset("myDataset")
            dataset.setString("myValue", forKey:"myKey")
            dataset.synchronize().continueWith {(task: AWSTask!) -> AnyObject! in
                // Your handler code here
                return nil
            
            }
            return nil
        }
     
        performSegue(withIdentifier: "logined", sender: nil)
        
    }
}

