//
//  TransportVc.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 21/02/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import UIKit

class TransportVc: UIViewController {

    @IBOutlet var startPlace: UITextField!
    
    @IBOutlet var endPlace: UITextField!
    
    @IBOutlet var time: UITextField!
    
    @IBOutlet var get: UIButton!
    
    @IBOutlet var fastest: UISwitch!
    
    @IBOutlet var cheapest: UISwitch!
    
    @IBOutlet var go: UIButton!
    
    var fastestBool:Bool = false
    var cheapestBool:Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.hideKeyboardWhenTappedAround()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        
        let source = defaults.object(forKey: "source") as? String ?? "Potheri"
        let destination = defaults.object(forKey: "destination") as? String ?? "Egmore"
        
        startPlace.text = source
        endPlace.text = destination
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        saveValues()
    }
    
    func saveValues(){
    
        let defaults = UserDefaults.standard
    
        var origin = defaults.object(forKey: "origin") as? String ?? ""
        var destination = defaults.object(forKey: "destination") as? String ?? ""
        var cheap = defaults.object(forKey: "cheapest") as? Bool ?? false
        var fast = defaults.object(forKey: "fastest") as? Bool ?? false
        
        origin = startPlace.text!
        destination = endPlace.text!
        cheap = cheapestBool
        fast = fastestBool
  
        defaults.set(origin, forKey: "origin")
        defaults.set(destination, forKey: "destination")
        defaults.set(cheap, forKey: "cheapest")
        defaults.set(fast, forKey: "fastest")
        
        defaults.synchronize()
        
        
    
    }
    
    @IBAction func fastestValueChanged(_ sender: Any) {
        
        if fastestBool == true{
        
            fastestBool = false
        
        }else{
        
            fastestBool = true
        
        }
        
    }
    
    @IBAction func cheapestValueChanged(_ sender: Any) {
        
        if cheapestBool == true{
            
            cheapestBool = false
            
        }else{
            
            cheapestBool = true
            
        }
    }

    
}




