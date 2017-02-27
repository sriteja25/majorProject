//
//  HomeVc.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 21/02/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import UIKit

class HomeVc: UIViewController {

   
    @IBOutlet var weather: UIButton!
    
    @IBOutlet var transport: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func viewSetup(){
    
        
        
        weather.layer.cornerRadius = 3.33
        weather.layer.borderWidth = 1
        //weather.layer.borderColor = UIColor.green.cgColor
        
        transport.layer.cornerRadius = 3.33
        transport.layer.borderWidth = 1
        //transport.layer.borderColor = UIColor.green.cgColor
    
    
    }
}
