//
//  WeatherForecaseViewController.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 20/02/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import SwiftLocation
import Alamofire
import ProgressHUD

class WeatherForecaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var time = [Date]()
    var icon = [String]()
    var temperature = [Float]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ProgressHUD.show("Getting Temperature")
        gettingWeather()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func gettingWeather(){
    
        var weatherUrl = "https://api.darksky.net/forecast/14108162800228d2d692bf8d81f0abcd/13.0827,%2080.2707"
        
        Alamofire.request(weatherUrl)
            .responseJSON { response in
                
                if let json = response.result.value as? [String:Any]{
                    
                    if let hourly = json["hourly"] as? [String:Any]{
                        
                        //let icon = hourly["icon"] as! String
                        
                        if let data = hourly["data"] as? [[String:Any]]{
                        
                            for i in 0..<4{
                            
                                let items = data[i]
                                var time = items["time"] as! TimeInterval
                                var myTime = Date(timeIntervalSince1970: TimeInterval(time))
                                
                                
                                // myTime = myTime.remove(at: 5)
                                let icon = items["icon"] as! String
                                let temperature = items["temperature"] as! Float
                                
                                self.time.append(myTime)
                                self.icon.append(icon)
                                self.temperature.append(temperature)

                            }
                        
                        ProgressHUD.dismiss()
                        self.tableView.reloadData()
                        }
                        
                        
                        
                    }
                }
        }
    }

    func stringFromTimeInterval(_ interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600) + 6
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return time.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WeatherTableViewCell
        
        cell.iconLabel.text = icon[indexPath.row]
        cell.tempLabel.text = "\(temperature[indexPath.row])"
        cell.timeLabel.text = "\((time[indexPath.row]))"
        
        return cell
    }
    
    
}

