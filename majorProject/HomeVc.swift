//
//  HomeVc.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 21/02/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import MarqueeLabel
import Alamofire
import ProgressHUD


class HomeVc: UIViewController {

    
    @IBOutlet var transport: UIButton!
    
    
    @IBOutlet var mLabel: MarqueeLabel!
   
    @IBOutlet var dateLabel: UILabel!
    
    
    
    var time = [Date]()
    var icon = [String]()
    var temperature = [Float]()
    var myHours = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
        gettingWeather()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "source")
        defaults.removeObject(forKey: "destination")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func viewSetup(){
    
        transport.layer.cornerRadius = 3.33
        transport.layer.borderWidth = 1
        //transport.layer.borderColor = UIColor.green.cgColor
    
    
    }
    
    func gettingWeather(){
        
        let weatherUrl = "https://api.darksky.net/forecast/14108162800228d2d692bf8d81f0abcd/13.0827,%2080.2707"
        
        Alamofire.request(weatherUrl)
            .responseJSON { response in
                
                if let json = response.result.value as? [String:Any]{
                    
                    if let hourly = json["hourly"] as? [String:Any]{
                        
                        //let icon = hourly["icon"] as! String
                        
                        if let data = hourly["data"] as? [[String:Any]]{
                            
                            for i in 0..<4{
                                
                                let items = data[i]
                                let time = items["time"] as! TimeInterval
                                var myTime = Date(timeIntervalSince1970: TimeInterval(time))
                                
                                self.myFormatter(date:myTime)
                                
                                let calendar = Calendar.current
                                let hour = calendar.component(.hour, from: myTime)
                                let minutes = calendar.component(.minute, from: myTime)
                                let year = calendar.component(.year, from: myTime)
                                let month = calendar.component(.month, from: myTime)
                                let day = calendar.component(.day, from: myTime)
                                
                               
                                
                                
                                // myTime = myTime.remove(at: 5)
                                let icon = items["icon"] as! String
                                let temperature = items["temperature"] as! Float
                                let tempCel = self.convertToCelsius(temperature)
                                
                                //self.time.append(myTime)
                                
                                
                                
                                print(day + month + year)
                                print("\(hour): \(tempCel)")
                                
                                self.myHours.append(hour)
                                self.temperature.append(tempCel)
                                
                                self.dateLabel.text = "\(day) / \(month) / \(year)"
                                //self.mLabel.text =  "\(hour): \(tempCel)"
                                
                                
                                self.icon.append(icon)
                                self.temperature.append(tempCel)
                                
                            }
                            
                            ProgressHUD.dismiss()
                            self.myMarquee()
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
        
        print(hours)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    func format(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        
        if duration >= 3600 {
            formatter.allowedUnits = [.hour, .minute, .second]
        } else {
            formatter.allowedUnits = [.minute, .second]
        }
        
        return formatter.string(from: duration) ?? ""
    }
    
    func myFormatter(date:Date){
    
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd yyyy"
        
        let myDate = dateFormatterPrint.string(from: date)
    
    }
    
    
    func convertToCelsius(_ fahrenheit: Float) -> Float {
        return Float(5.0 / 9.0 * (Double(fahrenheit) - 48.0))
    }
    func myMarquee(){
    
        
        
        
        mLabel.text = "\(myHours[0]) AM : \(temperature[0]) ºC     \(myHours[1]) AM : \(temperature[1]) ºC    \(myHours[2]) AM : \(temperature[2]) ºC     \(myHours[3]) AM : \(temperature[3]) ºC"
        
        
    
    
    }
    
    
    
    
    
}
