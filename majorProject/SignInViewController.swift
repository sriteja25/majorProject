//
//  ViewController.swift
//  Finance Manager
//
//  Created by Sriteja Chilakamarri on 13/12/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import ProgressHUD

var xyz:String = ""

class SignInViewController: UIViewController/*,GIDSignInDelegate,GIDSignInUIDelegate*/,UITextFieldDelegate {

    @IBOutlet weak var emailIDEntered: UITextField!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var pwdEntered: UITextField!
    @IBOutlet var signInButton: UIButton!
    
    //var ref: FIRDatabaseReference!
    
    var userId : String = ""
    
    var isKeyboardVisible:Bool!
   /* @IBOutlet var facebookSignInButton: UIButton!
    
    @IBOutlet var googleSigninButton: GIDSignInButton!*/
    override func viewWillAppear(_ animated: Bool) {
        //Posting Keyboard Hide/Show Notification.
       
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Removing Keybpard Hide/Show Notification.
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        isKeyboardVisible = false
        self.hideKeyboardWhenTappedAround()
        
        /*GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID*/
        
        self.emailIDEntered.delegate = self
        self.pwdEntered.delegate = self
        
       //ref = FIRDatabase.database().reference()
        
        
        //emailIDEntered.textFieldBorder(textField : emailIDEntered)
        //pwdEntered.textFieldBorder(textField : pwdEntered)
        
        signInButton.layer.cornerRadius = 3.33
        
        
        
        

        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    
// Custom Signin Button pressed. This will also add the email id of the user to new signup if an account Doesn't exist.
    
    @IBAction func signinButtonPressed(_ sender: AnyObject) {
        if let email = emailIDEntered.text, let pwd = pwdEntered.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("JESS: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.userId = user.providerID
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("JESS: Unable to authenticate with Firebase using email")
                        } else {
                            print("JESS: Successfully authenticated with Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                
                                self.userId = user.providerID
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        //DataService.ds.createFirbaseDBUser(uid: id, userData: userData)
        //let keychainResult = KeychainWrapper.setString(id, forKey: KEY_UID)
        let keychainResult = KeychainWrapper.defaultKeychainWrapper.set(userId, forKey: "keychain")
        saveInFirebase()
        print("JESS: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "loggedIn", sender: nil)
    }
    
    func saveInFirebase(){
        
        ref = FIRDatabase.database().reference()
        
        ref.child("users").child(userId)
    
    
    }
    
}

    

