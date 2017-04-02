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
import UberRides
import CoreLocation


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
    
    var c:Bool = false
    
    var privateDistance:String = ""
    var privateDuration:String = ""
    var publiceDistance:String = ""
    var publicDuration:String = ""
    var pubDeptTime:String = ""
    var pubTrain:String = ""
    var trainDuration:String = ""
    var trainDistance:String = ""
    var pubTrainArray = [String]()
    
    
    

    
    
    @IBOutlet var wayPoints: UILabel!
    
    @IBOutlet var temperature: UILabel!
    
    
    @IBOutlet var recomendation: UILabel!
    
    @IBOutlet var distance: UILabel!
    
    @IBOutlet var duration: UILabel!
    
    @IBOutlet var otherDistance: UILabel!
    
    @IBOutlet var otherDuration: UILabel!

    
    
    @IBOutlet var nextBestTime: UILabel!
    
    
    @IBOutlet var otherBestLabel: UILabel!
    
    
    @IBOutlet var view1: UIView!
    
    @IBOutlet var view2: UIView!
    
    let cab1 = RideRequestButton()
    let cab2 = RideRequestButton()
    let ridesClient = RidesClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProgressHUD.show("Recomendation")
        
        peakTimeCheck()
        
        retreiveValues()
        
        getWeather()
        
        privateTransport()
        
        getTimings()
        transit()
        
        cab1.isHidden = true
        cab2.isHidden = true
        
        
        setup()
        
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }
    
    func setup(){
        
        let pickupLocation = CLLocation(latitude: 37.775159, longitude: -122.417907)
        let dropoffLocation = CLLocation(latitude: 37.6213129, longitude: -122.3789554)
        
        var builder = RideParametersBuilder()
            .setPickupLocation(pickupLocation).setDropoffLocation(dropoffLocation,
                                nickname: "San Francisco International Airport")
        
        ridesClient.fetchCheapestProduct(pickupLocation: pickupLocation, completion: {
            product, response in
            if let productID = product?.productID { //check if the productID exists
               
                builder = builder.setProductID(productID)
                self.cab1.rideParameters = builder.build()
                self.cab2.rideParameters = builder.build()
                
                // show estimates in the button
                self.cab1.loadRideInformation()
                self.cab2.loadRideInformation()
            }
        })
        
        
    
        ridesClient.fetchPriceEstimates(pickupLocation: pickupLocation, dropoffLocation: dropoffLocation) { (product, response) in
            
            print(product)
        }
        
        
        
        
        cab1.rideParameters  = builder.build()
        cab2.rideParameters  = builder.build()
        
        cab1.colorStyle = .black
        cab2.colorStyle = .black
        
        view1.addSubview(cab1)
        view2.addSubview(cab2)
        
        
    
    }
    

    func retreiveValues(){
    
        let defaults = UserDefaults.standard
        
        var origin = defaults.object(forKey: "origin") as? String ?? ""
        origin = origin.replacingOccurrences(of: " ", with: "-")
        var destination = defaults.object(forKey: "destination") as? String ?? ""
        destination = destination.replacingOccurrences(of: " ", with: "-")
        let cheap = defaults.object(forKey: "cheapest") as? Bool ?? false
        let fast = defaults.object(forKey: "fastest") as? Bool ?? false
        
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
                        
                        temperature = self.convertToCelsius(temperature)
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
                    let deptTime = k["departure_time"]?["text"] as! String
                    let textDistance =  k["distance"]?["text"] as! String
                    //let valueDistance = k["distance"]?["value"] as! Float
                    
                    self.pubDeptTime = deptTime
                    
                    let z = c.firstObject as! [String:AnyObject]
                    
                    let textDuration =  k["duration"]?["text"] as! String
                    //let valueDuration = k["duration"]?["value"] as! String
                    
                    
                    
                    //print("Private Transport - \(textDistance!)\(textDuration)")
                    
                    self.publiceDistance = textDistance
                    self.publicDuration = textDuration
                    
                    print(self.publicDuration)
                    print(self.publiceDistance)
                    
                    self.myValues()
                    self.myTree()
                    ProgressHUD.dismiss()
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
    
    
   


    func convertToCelsius(_ fahrenheit: Float) -> Float {
        return Float(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
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
    //Default - 0 , Very humid - 1, Rain - 2, Continous rain - 3
    
    
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
    
    func getTimings(){
        
        
        var source = self.origin
        
        if source == ("Potheri-Railway-Station"){
        
            source = "Potheri"
        }
        
        let destination = self.destination
        
        if destination == ("Potheri-Railway-Station"){
            
            source = "Potheri"
        }

        
        let myPlace = "\(source)To\(destination)"
        
        if let path :String = Bundle.main.path(forResource: "\(myPlace)", ofType: "json"){
            
            do{
                
                
                let data = try(NSData(contentsOfFile: path, options: NSData.ReadingOptions.dataReadingMapped))
                
                let jsonDisctionary = try(JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)) as! [Any]
                //print("Teja \(jsonDisctionary)")
                
                for i in 0..<1{
                    
                    let items = jsonDisctionary[i] as! [String:Any]
                    let Destination = items["Destination"] as! String
                    let Source = items["Source"] as! String
                    let duration = items["Duration"] as! String
                    let distance = items["Distance"] as! String
                    
                    self.trainDistance = distance
                    self.trainDuration = duration
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
                            
                                if(Int(myMinute)! > minute )
                                {
                                print(myHour,myMinute)
                                pubTrain = myHour + ": " + myMinute
                                pubTrainArray.append(pubTrain)
                                }
                            
                        }
                        if(pubTrainArray.count == 1){
                        
                            if(Int(myHour) == (hour+1)){
                            
                                
                                
                                if (c == false){
                                pubTrain = myHour + ": " + myMinute
                                pubTrainArray.append(pubTrain)
                                c = true
                                }
                            
                            }
                        }else if(pubTrainArray.count == 0){
                            
                            if(Int(myHour) == (hour+1)){
                            
                            pubTrain = myHour + ": " + myMinute
                            pubTrainArray.append(pubTrain)
                            }
                        
                        }
                        
                        
                    }
                    
                }
                
                
                
            }catch let err{
                
                print(err)
            }
            
        }
        
        
        
    }
    
    func myValues(){
    
       
        
        //Time bound
        if (fastest == true){
        
            isTimeBound = true
        }else{
        
            isTimeBound = false
        }
        
        // Climate    Default - 0 , Very humid - 1, Rain - 2, Continous rain - 3
        if (iconCat == 1){
        
            isNormal = true
            isPleasant = false
        }else if(iconCat == 2){
        
            isNormal = false
            isPleasant = true
        
        }else if(iconCat == 3){
        
            isNormal = false
            isPleasant = false
            
        }else{
        
            isNormal = true
            isPleasant = true
        
        }
        
        // Peak check
        
        if (peakTime == 0){
        
            isPeak = false
        }else{
        
            isPeak = true
        }
        
        //economical
        
        if(cheapest == true){
        
            isEconomical = true
        }else{
        
            isEconomical = false
        }
        
        
        
    
    
    }
    
    
    
    func myTree(){
        
        initialise()
        
        
        let value =  searchMyValue(node:time) as! Int
        myRecomendation(myvalue : value)
        
        
        print("isTimeBound : \(isTimeBound)")
        print("isNormal : \(isNormal)")
        print("isPleasant : \(isPleasant)")
        print("isPeak : \(isPeak)")
        print("isEconomical : \(isEconomical)")
        
        print(value)
        
        
    }
    
    
    func cabBus(){
        
        distance.text = "Distance  " + privateDistance
        duration.text = "Duration  " + privateDuration
        otherDistance.text = "Distance  " + publiceDistance
        otherDuration.text = "Duration  " + publicDuration
        
        recomendation.text = "We recomend Taking a Cab"
        
        nextBestTime.text = "Next Available Cab " + " "
        otherBestLabel.text = "Next Bus is at    " + pubDeptTime
        cab1.isHidden = false
        cab2.isHidden = true
        
        
        recomendation.text = "We recomend Taking a Cab"
        
        
    }
 
    func busCab(){
        
        otherDistance.text = "Distance  " + privateDistance
        otherDuration.text = "Duration  " + privateDuration
        distance.text = "Distance  " + publiceDistance
        duration.text = "Duration  " + publicDuration
        
        recomendation.text = "We recomend Taking a Bus"
        nextBestTime.text = "Nex Available Bus is at     " + pubDeptTime
        otherBestLabel.text = "Next Available Cab " + ""
        cab1.isHidden = true
        cab2.isHidden = false
        
        
    }
    
    func trainCab(){
        
        distance.text = "Distance  " + trainDistance
        duration.text = "Duration  " + trainDuration
        otherDistance.text = "Distance  " + privateDistance
        otherDuration.text = "Duration  " + privateDuration
        
        recomendation.text = "We recomend Taking a Train"
        
        nextBestTime.text = "Next Available Trains " + pubTrainArray[pubTrainArray.count - 2] + "    " + pubTrainArray[pubTrainArray.count - 1]
        otherBestLabel.text = "Next Cab is at    " + " "
        
        cab1.isHidden = true
        cab2.isHidden = false
   
    
    }
    
    func CabTrain(){
        
        distance.text = "Distance  " + privateDistance
        duration.text = "Duration  " + privateDuration
        otherDistance.text = "Distance  " + trainDistance
        otherDuration.text = "Duration  " + trainDuration
        
        recomendation.text = "We recomend Taking a Cab"
        
        nextBestTime.text = "Next Available Cab "
        otherBestLabel.text = "Next Available Trains  " + pubTrainArray[pubTrainArray.count - 2] + "    " + pubTrainArray[pubTrainArray.count - 1]
        
        cab1.isHidden = false
        cab2.isHidden = true
        
    }
    
    func TrainBus(){
        
        distance.text = "Distance  " + trainDistance
        duration.text = "Duration  " + trainDuration
        otherDistance.text = "Distance  " + publiceDistance
        otherDuration.text = "Duration  " + publicDuration
        
        recomendation.text = "We recomend Taking a Train"
        
        nextBestTime.text = "Next Available Trains " + pubTrainArray[pubTrainArray.count - 2] + "    " + pubTrainArray[pubTrainArray.count - 1]
        otherBestLabel.text = "Next Available Bus  " + pubDeptTime
  
    }
    
    func BusTrain(){
    
        distance.text = "Distance  " + publiceDistance
        duration.text = "Duration  " + publicDuration
        otherDistance.text = "Distance  " + trainDistance
        otherDuration.text = "Duration  " + trainDuration
        
        recomendation.text = "We recomend Taking a Bus"
        
        nextBestTime.text = "Next Available Bus " + pubDeptTime
        otherBestLabel.text = "Next Available Trains  " + pubTrainArray[pubTrainArray.count - 2] + "    " + pubTrainArray[pubTrainArray.count - 1]
    
    }
    
    func myRecomendation(myvalue : Int){
        
        switch myvalue {
        case 32,31,30,28,20,24,4:
            cabBus()
            break
        case 19,3:
            busCab()
            break
        case 5,6,1,2,9,10,11,13,14,15:
            trainCab()
            break
            
        case 8,12,16,22,18,26,29 :
            CabTrain()
            break
            
        case 7,21,17,25 :
            TrainBus()
            break
        default :
            BusTrain()
            break
        }
        
        
        
        
        
    }

    
}
