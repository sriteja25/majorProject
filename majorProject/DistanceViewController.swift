//
//  DistanceViewController.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 13/11/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseDatabase

class DistanceViewController: UIViewController {
    
    
    var mapsUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=potheri&destination=egmore&key=AIzaSyC7JtfwyOVZP6J7h8L7OEGvj6h6tPoGmWE"
    
    typealias JsonStandard = [String : AnyObject]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAlmo(mapsUrl)
        
        
        
        Alamofire.request("https://maps.googleapis.com/maps/api/directions/json?origin=potheri&destination=egmore&key=AIzaSyC7JtfwyOVZP6J7h8L7OEGvj6h6tPoGmWE").responseJSON { response in
            
            
             let d = response.result.value as! [String:AnyObject]
            let a =  d["routes"] as! NSArray
            let b = a.firstObject as! [String:AnyObject]
            let c  = b["legs"] as! NSArray
            let k =  c.firstObject as! [String:AnyObject]
            print(k["distance"])
            let textDistance =  k["distance"]?["text"]
            let valueDistance = k["distance"]?["value"]
            print("Text \(textDistance!) - Value \(valueDistance!)")
        }

        // Do any additional setup after loading the view.
    }
    
    func callAlmo(_ url : String)
    {
        
        
        
        Alamofire.request(url).responseJSON(completionHandler: {
            
            response in
            
            self.parsedata(response.data!)
            
        })
        
    }
    
   
    

    func parsedata(_ JSONData:Data)
    {
        do{
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JsonStandard
            }
        catch{
            print(error)
            
        }
        
        
    }
    

    

   
}
