//
//  LaunchVc.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 20/03/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class LaunchVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "keychain") ?? ""
        
        if (retrievedString != ""){
            
            performSegue(withIdentifier: "noSignIn", sender: nil)
            
        }else{
            
            performSegue(withIdentifier: "toSignIn", sender: nil)
            
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
