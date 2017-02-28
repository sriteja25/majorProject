/*//
//  ViewController.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 10/10/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseDatabase

class TableViewController: UITableViewController {
    
    open var stringTemp :String = ""
    
    
    var geo:GeoFire!
    
    @IBAction func saveButton(_ sender: AnyObject) {
        
 
    }
    open var stringTime :String = ""
    
    
    var temperatures = [String]()
    
    
    var weatherUrl = "https://api.darksky.net/forecast/14108162800228d2d692bf8d81f0abcd/13.0827,%2080.2707"
    
    typealias JsonStandard = [String : AnyObject]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
               
        callAlmo(weatherUrl)
        
        
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
            
            if let currently = readableJSON["currently"] as? JsonStandard
            {
               
               // print(currently["temperature"])
              
            }
            if let hourly = readableJSON["hourly"] as? JsonStandard
            
            {
            
                if let data = hourly["data"]{
                
                    for i in 6..<10{
                    
                    let datas = data[i] as? JsonStandard
                        
                        
                        let temperature = datas?["temperature"] as! Int
                        
                        let time = datas?["time"] as! Int
                        
                        let summary = datas?["summary"] as! String
                        
                        let icon = datas?["icon"]
                        
                        stringTemp = String(temperature)
                        
                        
                        
                        let date = Date(timeIntervalSince1970: TimeInterval(time))
                        
                          stringTime = String(describing: date)
                        
                        temperatures.append(stringTime)
                        temperatures.append(stringTemp + "ºF")
                        temperatures.append(summary)
                        temperatures.append(icon as! String)
                        
                        let saveTemp  = ["Time" : stringTime , "Temperature" : stringTemp,"Summary":summary]
                        
                        let databaseRef = FIRDatabase.database().reference()
                    
                    
                        self.tableView.reloadData()
                        
                        databaseRef.child("saveTemp").childByAutoId().updateChildValues(saveTemp)
                        
                        
                    }
                
                }
                    
    
            }
            
            
        }
        catch{
        print(error)
        
        }
    
    
    }
    
  /*  func saveTemp()
    {
        
      
    let temp = self.stringTemp
        let time = self.stringTime
    
            
            let saveTemp  = ["Time" : temp , "Temperature" : time]
            
            let databaseRef = FIRDatabase.database().reference()
            
            databaseRef.child("saveTemp").childByAutoId().updateChildValues(saveTemp)
            
       
        
    }*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temperatures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = temperatures[indexPath.row]
        
        return cell!
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stringFromTimeInterval(_ interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }


}

*/
