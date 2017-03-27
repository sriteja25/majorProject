//
//  TestViewController.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 23/03/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import Alamofire

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTimings()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getTimings(){
    
    
        if let path :String = Bundle.main.path(forResource: "test", ofType: "json"){
        
            do{
                
                
                let data = try(NSData(contentsOfFile: path, options: NSData.ReadingOptions.dataReadingMapped))
                
                let jsonDisctionary = try(JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)) as! [Any]
                //print("Teja \(jsonDisctionary)")
                
                for i in 0..<1{
                
                    let items = jsonDisctionary[i] as! [String:Any]
                    let Destination = items["Destination"] as! String
                    let Source = items["Source"] as! String
                    let timings = items["Timings"] as! [Any]
                    
                   // print(Destination,Source,timings)
                    
                    for j in 0..<timings.count{
                    
                    let items = timings[j] as! String
                        //print(items)
                    
                        
                        
                        let date = Date()
                        let calendar = Calendar.current
                        let hour = calendar.component(.hour, from: date) //8
                        let minute = calendar.component(.minute, from: date) //55
                        
                        let myTime = items.components(separatedBy: ":")
                        let myHour = myTime[0]
                        let myMinute = myTime[1]
                        
                        var a:Bool?

                        //print(myHour,myMinute)
                        
                        if (Int(myHour) == hour){
                        
                            if(Int(myMinute)! > minute){
                            
                            print(myHour,myMinute)
                            
                            }else{
                            
                                a = true
                                
                            }
                     
                        }
                        if (Int(myHour) ==  hour + 1){
                        
                        if (a == true){
                            
                            print(myHour,myMinute)
                            
                        
                            }
                        }
                        
                        
                    }
                
                }
                
                
                
            }catch let err{
            
            print(err)
            }
        
        }
        
        
        
    }
    
    func alamo(){
    
    
    
    
    }
    
    
}





