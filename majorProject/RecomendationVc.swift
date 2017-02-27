//
//  RecomendationVc.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 21/02/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD


class RecomendationVc: UIViewController {
    
    var origin:String = ""
    var destination:String = ""
    var currentWeather:Float = 0
    var icon:String = ""
    var cheapest:Bool = false
    var fastest:Bool = false
    var iconCat:Float = 0
    var humidity:Float = 0
    var peakTime:Float = 0
    
    var privateDistance:String = ""
    var privateDuration:String = ""
    var publiceDistance:String = ""
    var publicDuration:String = ""

    
    
    @IBOutlet var wayPoints: UILabel!
    
    @IBOutlet var temperature: UILabel!
    
    
    @IBOutlet var recomendation: UILabel!
    
    @IBOutlet var distance: UILabel!
    
    @IBOutlet var duration: UILabel!
    
    @IBOutlet var nextTrain: UILabel!
    
    @IBOutlet var otherDistance: UILabel!
    
    @IBOutlet var otherDuration: UILabel!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peakTimeCheck()
        
        retreiveValues()
        
        getWeather()
        
        privateTransport()
        transit()
        
       
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        ProgressHUD.show("Recomendation")
         recomendationForTransport()
        ProgressHUD.dismiss()
    }
    

    func retreiveValues(){
    
        let defaults = UserDefaults.standard
        
        var origin = defaults.object(forKey: "origin") as? String ?? ""
        var destination = defaults.object(forKey: "destination") as? String ?? ""
        var cheap = defaults.object(forKey: "cheapest") as? Bool ?? false
        var fast = defaults.object(forKey: "fastest") as? Bool ?? false
        
        self.origin = origin
        self.destination = destination
        self.cheapest = cheap
        self.fastest = fast
        
        checkIcon()
        
    
    }

    
    
    
    func getDistance(){
        
    }
    
    func getWeather(){
    
        var weatherUrl = "https://api.darksky.net/forecast/14108162800228d2d692bf8d81f0abcd/13.0827,%2080.2707"
        
        Alamofire.request(weatherUrl)
            .responseJSON { response in
                
                if let json = response.result.value as? [String:Any]{
                    
                    if let currently = json["currently"] as? [String:Any]{
                    
                        var temperature = currently["temperature"] as! Float
                        var humidity = currently["humidity"] as! Float
                        self.humidity = humidity
                        
                        temperature = self.convertToCelsius(fahrenheit: temperature)
                        temperature = round(temperature*10)/10
                        self.currentWeather = temperature
                        let icon = currently["icon"] as! String
                        self.icon = icon
                        
                        
                    
                    }
                    
                    self.wayPoints.text = "Here's the transportation information for \(self.origin) to \(self.destination)"
                    self.temperature.text = "The weather is \(self.currentWeather)ºC and ther is \(self.icon)"
                 
                        
                   
                }
        }
    }
    
    
    func transit(){
    
    var transitUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=\(self.origin)&destination=\(self.destination)&mode=transit&key=AIzaSyC7JtfwyOVZP6J7h8L7OEGvj6h6tPoGmWE"
        
        Alamofire.request(transitUrl)
            .responseJSON { response in
                
                if let json = response.result.value as? [String:Any]{
                    
                    let d = response.result.value as! [String:AnyObject]
                    let a =  d["routes"] as! NSArray
                    let b = a.firstObject as! [String:AnyObject]
                    let c  = b["legs"] as! NSArray
                    let k =  c.firstObject as! [String:AnyObject]
                    let textDistance =  k["distance"]?["text"] as! String
                    //let valueDistance = k["distance"]?["value"] as! Float
                    
                    let z = c.firstObject as! [String:AnyObject]
                    
                    let textDuration =  k["duration"]?["text"] as! String
                    //let valueDuration = k["duration"]?["value"] as! String
                    
                    
                    
                    //print("Private Transport - \(textDistance!)\(textDuration)")
                    
                    self.publiceDistance = textDistance
                    self.publicDuration = textDuration
                    
                    print(self.publicDuration)
                    print(self.publiceDistance)
                    
                }
        }
    }
    
    func privateTransport(){
    
        var transitUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=\(self.origin)&destination=\(self.destination)&key=AIzaSyC7JtfwyOVZP6J7h8L7OEGvj6h6tPoGmWE"
    
        Alamofire.request(transitUrl)
            .responseJSON { response in
                
                let d = response.result.value as! [String:AnyObject]
                let a =  d["routes"] as! NSArray
                let b = a.firstObject as! [String:AnyObject]
                let c  = b["legs"] as! NSArray
                let k =  c.firstObject as! [String:AnyObject]
                let textDistance =  k["distance"]?["text"] as! String
                //let valueDistance = k["distance"]?["value"] as! Float
                
                let z = c.firstObject as! [String:AnyObject]
                
                let textDuration =  k["duration"]?["text"] as! String
                //let valueDuration = k["duration"]?["value"] as! String
                
                
                
                //print("Private Transport - \(textDistance!)\(textDuration)")
                
                self.privateDistance = textDistance
                self.privateDuration = textDuration
                
                print(self.privateDuration)
                print(self.privateDistance)

                }
        }
    
   


    func convertToCelsius(fahrenheit: Float) -> Float {
        return Float(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
    
    func recomendedPrivate(){
    
        distance.text = privateDistance
        duration.text = privateDuration
        otherDistance.text = publiceDistance
        otherDuration.text = publicDuration
        
        
        recomendation.text = "We recomend Taking a Cab"
    
    
    }
    func recomendedPublic(){
        
        otherDistance.text = privateDistance
        otherDuration.text = privateDuration
        distance.text = publiceDistance
        duration.text = publicDuration
        
        recomendation.text = "We recomend Taking a Public Transport"
        
        
    }
    
    func recomendationForTransport(){
    
        if (self.fastest == true){
        
            if(iconCat == 0){
                
                if (peakTime == 0){
                    
                    if (cheapest == true){
                    
                        recomendedPublic()
                    
                    }else{
                    
                        recomendedPrivate()
                    }
                
                
                }else{
                
                    if (cheapest == true){
                        
                        recomendedPublic() //Train
                        
                    }else{
                       
                        recomendedPrivate()
                        
                    }
                }
            
            
            }else if(iconCat == 1){
                if (peakTime == 0){
                    if (cheapest == true){
                        
                        recomendedPublic()
                    }else{
                        
                         recomendedPublic() //Train
                        
                    }
                    
                }else{
                    if (cheapest == true){
                        
                        recomendedPublic()
                    }else{
                        recomendedPrivate()
                        
                    }
                    
                }
            
            
            }else if(iconCat == 2){
                if (peakTime == 0){
                    if (cheapest == true){
                        
                        recomendedPrivate()
                    }else{
                        recomendedPrivate()
                        
                    }
                    
                }else{
                    
                    if (cheapest == true){
                        
                        recomendedPublic()//Train
                        
                    }else{
                        
                        recomendedPublic()//Train
                        
                    }
                }
            
            
            }else{
                
                if (peakTime == 0){
                    if (cheapest == true){
                        
                        recomendedPrivate()
                        
                    }else{
                        
                        recomendedPrivate()
                        
                    }
                    
                }else{
                    if (cheapest == true){
                        
                        recomendedPublic() //Train
                        
                    }else{
                        
                        recomendedPublic() //Train
                        
                    }
                    
                }
            
            
            }
            
        
        
        }else{
        
            if(iconCat == 0){
                
                if (peakTime == 0){
                    if (cheapest == true){
                        
                        recomendedPublic() //Next Train
                    }else{
                        
                        recomendedPublic()
                    }
                    
                }else{
                    if (cheapest == true){
                        
                        recomendedPublic() //Train
                    }else{
                        
                        recomendedPrivate()
                    }
                    
                }
                
            }else if(iconCat == 1){
                if (peakTime == 0){
                    if (cheapest == true){
                        
                        recomendedPublic()
                        
                    }else{
                        
                        recomendedPrivate()
                    }
                    
                }else{
                    if (cheapest == true){
                        
                        recomendedPublic()
                        
                    }else{
                        
                        recomendedPrivate()
                        
                    }
                    
                }
                
            }else if(iconCat == 2){
                if (peakTime == 0){
                    if (cheapest == true){
                        
                        recomendedPrivate()//Wait for a while
                    }else{
                        recomendedPrivate()
                        
                    }
                    
                }else{
                    
                    if (cheapest == true){
                        
                        recomendedPrivate()
                        
                    }else{
                        
                        recomendedPrivate()
                    }
                }
                
            }else{
                
                if (peakTime == 0){
                    
                    if (cheapest == true){
                        
                        recomendedPrivate() //Cheapest
                        
                    }else{
                        
                        recomendedPrivate() //Fastest
                    }
                }else{
                    
                    if (cheapest == true){
                        
                        recomendedPrivate() //Cheapest
                        
                    }else{
                        
                        recomendedPrivate() //Fastest
                    }
                }
                
            }
        
        
        }
    
    
    
    
    }
    
    func checkIcon(){
    
        if (self.icon == "rain"){
            
            iconCat = 2
            
            
        }
        else if (self.icon == "thunderstorm"){
        
            iconCat = 3
        
        }else{
            
            if(self.humidity > 0.4){
            
                iconCat = 1
            
            }else{
            
                iconCat = 0
            }
            
        
        }
        
    
    
    }
    //Default - 0 , Very humid - 1, Rain - 2, C rain - 3
    
    
    func peakTimeCheck(){
    
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        print(hour)
        
        if((hour > 8 && hour < 11) || (hour > 17 && hour < 20)){
        
            peakTime = 1
        
        }else{
        
            peakTime = 0
        
        }
    
    }
    
    
}
