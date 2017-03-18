/*//
//  DistancesViewController.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 17/11/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseDatabase


class DistancesViewController: UIViewController,CLLocationManagerDelegate {
    
  
    
    
    let locationManager = CLLocationManager()
    
    var startAdress: String = ""
    
    var endAdress:String = ""
    
    var PublicdistanceComparer:String = ""
    
    var PrivatedistanceComparer:String = ""
    
    var currentTemp :String? = ""
    var currentSummary : String? = ""
    
    var recomendationTransport : String = ""
    
    var reasonTextField : String = ""
    
    var reasonForTravelling : String = ""
    
    var onBudget:Int = 0
    
    var publicPeakChecker = 0
    
    var privatePeakChecker  = 0
    
    @IBOutlet weak var reasonTextBox: UITextField!

    @IBOutlet weak var distanceText: UILabel!
    
    @IBOutlet weak var origin: UITextField!
    
    @IBOutlet weak var destination: UITextField!
    
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var labelAdress: UILabel!
    
    
    @IBOutlet weak var publicDistance: UILabel!
    
    @IBOutlet weak var publicDuration: UILabel!
    
    @IBOutlet weak var budgetSegment: UISegmentedControl!
    
    @IBOutlet weak var privatePeak: UILabel!
    @IBOutlet weak var ourRecomendation: UILabel!
    
    @IBOutlet weak var nextTrainTime: UILabel!
    
    
    var weatherUrl = "https://api.darksky.net/forecast/14108162800228d2d692bf8d81f0abcd/13.0827,%2080.2707"
    
    typealias JsonStandard = [String : AnyObject]
    
    var originEntered: String = ""
    
    var destinationEntered :String = ""
    
    var timeNow :Int = 0
    
    //var peakTimeEveningStart = "5"
    
     //var peakTimeEveningEnd = "10 PM"
    
    //var peakTimeMorningStart = "8 AM"
    
    //var peakTimeMorningEnd = "11 AM"
    
    var peakChecker = 0

    
    var trainStartTime :String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        almocall(weatherUrl)
        
        recomendation()
        
        timeNow = Calendar.current.component(.hour, from: Date())
        
        print("Time Now \(timeNow)")
        
        if((timeNow > 8 && timeNow < 11) || (timeNow > 17 && timeNow < 20)){
        
         peakChecker = 0//Peak time
            
            print("It is peak time")
        }else{
        
             peakChecker = 0
            print("it is not peak time")
        
        }
        
    
}




    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
    
    
    
    func almocall(_ url : String)
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
                
             
                
                print("Teja : \(currently["temperature"])")
                
                print("Teja : \(currently["summary"])")
                
                currentTemp = " \(currently["temperature"])"
                
                currentSummary = "\(currently["summary"])"
                
                
               

                
                
                
            }
            
            
            
        }
        catch{
            print(error)
            
        }
        
        
        
        
        
    }

    
   
    
    
    
    func buttonPressed(_ sender: AnyObject) {
        
        
        recomendation()
        
         PrivatedistanceComparer = distanceText.text!
        
        PublicdistanceComparer = publicDistance.text!
        
        ourRecomendation.text = recomendationTransport
        
      /* if(publicPeakChecker == 1){
            
            if(PublicdistanceComparer > "35 km"){
            
            print("It is long ditsnace and peak time")

                publicPeak.text = "~ +1hr"
            }
            else{
                print("It is short ditsnace and peak time")
                
                publicPeak.text = "~ +30 minz"
            
            }
        }
        
        if(privatePeakChecker == 1){
            
            if(PrivatedistanceComparer > "35 km"){
                
                print("It is long ditsnace and peak time")
                
                privatePeak.text = "~ +1hr"
            }
            else{
                print("It is short ditsnace and peak time")
                
                privatePeak.text = "~ +30 minz"
                
            }
        }*/
        
        print("Teja : \(reasonTextField)")
        
        
        originEntered = origin.text!
        
        
        destinationEntered = destination.text!
        
        Alamofire.request("https://maps.googleapis.com/maps/api/directions/json?origin=\(originEntered)&destination=\(destinationEntered)&key=AIzaSyC7JtfwyOVZP6J7h8L7OEGvj6h6tPoGmWE").responseJSON { response in
            
            
            let d = response.result.value as! [String:AnyObject]
            let a =  d["routes"] as! NSArray
            let b = a.firstObject as! [String:AnyObject]
            let c  = b["legs"] as! NSArray
            let k =  c.firstObject as! [String:AnyObject]
            print(k["distance"])
            let textDistance =  k["distance"]?["text"]
            let valueDistance = k["distance"]?["value"]
            
            let z = c.firstObject as! [String:AnyObject]
            
            let textDuration =  k["duration"]?["text"]
            let valueDuration = k["duration"]?["value"]
            
             self.startAdress = k["start_address"] as! String
            
             self.endAdress = k["end_address"] as! String

            
            
            
            
            
            print("Text \(textDistance!) - Value \(valueDistance!)")
            
            
            self.distanceText.text = textDistance as! String?
            
            self.duration.text = textDuration as? String
            
            self.labelAdress.text = "Here's the transportation information for \(self.startAdress) to \(self.endAdress). The current temperature is \(self.currentTemp!) and its \(self.currentSummary!)"
            
            
     
     //       let savePrivate  = ["Start Adress":self.startAdress,"End adress":self.endAdress,"Duration" : textDistance ,"Time":textDuration]
            
    //        let databaseRef = FIRDatabase.database().reference()

   //         databaseRef.child("Private").childByAutoId().updateChildValues(savePrivate)
        }
        
        
        Alamofire.request("https://maps.googleapis.com/maps/api/directions/json?origin=\(originEntered)&destination=\(destinationEntered)&mode=transit&key=AIzaSyC7JtfwyOVZP6J7h8L7OEGvj6h6tPoGmWE").responseJSON { response in
            
            
            let d = response.result.value as! [String:AnyObject]
            let a =  d["routes"] as! NSArray
            let b = a.firstObject as! [String:AnyObject]
            let c  = b["legs"] as! NSArray
            let k =  c.firstObject as! [String:AnyObject]
            print(k["distance"])
            let textDistance =  k["distance"]?["text"]
            let valueDistance = k["distance"]?["value"]
            
            let z = c.firstObject as! [String:AnyObject]
            
            let textDuration =  k["duration"]?["text"]
            let valueDuration = k["duration"]?["value"]
            
            let startAdress = k["start_address"]
            
            let endAdress = k["end_address"]
            
            self.publicDistance.text = textDistance as! String?
            
            self.publicDuration.text = textDuration as! String
            
            
            
            let startTime =  k["departure_time"]?["text"] as! String
            
            self.nextTrainTime.text =  "The next Train \(startTime)"
            
           
            
            
            
            
            
            
            
            
      //      let savePublic  = ["Duration" : textDistance ,"Time":textDuration]
            
      //      let databaseRef = FIRDatabase.database().reference()
            
      //      databaseRef.child("Public").childByAutoId().updateChildValues(savePublic)
            
        }
        
        
        
       
        
       
}
    @IBOutlet weak var reasonSegment: UISegmentedControl!
    
    @IBAction func reasonSegment(_ sender: UISegmentedControl) {
        
        switch reasonSegment.selectedSegmentIndex
        {
        case 0:
            print("Time bound")
            reasonForTravelling = "TimeBound"
        case 1:
            print("Not time bound")
            reasonForTravelling = "NotTimeBound"
        case 2:
            print("Time bound")
            reasonForTravelling = "TimeBound"
        default:
            print("Not time bound")
            reasonForTravelling = "TimeBound"
            break;
        }
        
    }
    @IBAction func budgetAction(_ sender: UISegmentedControl) {
        
        switch budgetSegment.selectedSegmentIndex
        {
        case 0: onBudget = 0
            
        case 1: onBudget = 1
            
        default : onBudget = 0
        break;
            
            }
    }
    
    func recomendation(){
    
    
        if(reasonForTravelling == "TimeBound"){
            
            print("We are in time Bound")
            
            
            if(currentSummary == "Optional(Clear)" || currentSummary == "Optional(Partly Cloudy)" || currentSummary == "Optional(Mostly Cloudy)"){ // Clear sky
            
                if(peakChecker == 1){
                
                    recomendationTransport = "Pleas take public transport (Train)"
                    
                    print("Clear : Peak : Public")
                    
                    
                
                }
                if(peakChecker == 0){
                    
                    if(onBudget == 0){
                     
                        recomendationTransport = "Pleas take Public transport (Train)"
                        
                        print("Clear : Not Peak : Public")
                        
                        
                    
                    }
                    if(onBudget == 1){
                
                        recomendationTransport = "Pleas take Private transport (Cab)"
                        
                        print("Clear :Not Peak : Private")
                        
                        
                    }
                }
                
             }
            
            else if(currentTemp == "Optional(100)"){ //Very humid
            
                if(peakChecker == 1) { //Non Peak Time
                
                recomendationTransport = "Pleas take public transport (Train)"
                    
                    print("Humid : Peak : Public")
                    
                    
                
                }
                if(peakChecker == 0){
                    
                    if(onBudget == 0){ //On budget
                    
                    recomendationTransport = "Pleas take public transport (Bus)"
                        print("Humid : Not Peak : Public")
                        
                    }
                    if(onBudget == 1){
                    recomendationTransport = "Pleas take Private transport (Cab)"
                        
                        print("Humid : Not Peak : Private")
                    
                    }
                    
                }

            
            }
            else if(currentSummary == "Optional(Overcast)" || currentSummary == "Optional(Light rain)"){
            
                if(peakChecker == 1){
                
                 recomendationTransport = "Please take Public transport (Train)"
                    
                    print("Overcast : Peak : Public")
                    
                    
                    
                    
                
                }
                if(peakChecker == 0){
                    
                recomendationTransport = "Pleas take Private transport (Cab)"
                    print("Overcast : Not Peak : Private")
                }

            
            }
            
            else if(currentSummary == "Optional(Overcast throughout the day)" || currentSummary == "Optional(Drizzle)" || currentSummary == "Optional(Heavy rain)"){
            
                if(peakChecker == 0){
                 
                    recomendationTransport = "Please take Public transport (Train)"
                    
                    print("Continous rain : Not Peak : Public")
                
                }
                
                if(peakChecker == 1){
                    
                    recomendationTransport = "Please take Private transport (Cab)"
                    print("Continous rain :  Peak : Private")
                    
                    privatePeakChecker = 1
                    
                }
                
                
            }
            else{
            
            
                if(peakChecker == 1){
                    
                  //  recomendationTransport = "Pleas take public transport (Train)"
                    
                    print("Clear :  Peak : Public")
                    
                    recomendationTransport = "Pleas take public transport (Train)"
                    //testLabel.text = "30"
                    
                   
                    
                }
                if(peakChecker == 0){
                    
                    if(onBudget == 0){
                        
                     
                        
                        print("Clear : Not Peak : Public")
                        
                       // testLabel.text = "Pleas take Public transport (Train)"
                        
                        recomendationTransport = "Pleas take public transport (Train)"
                    }
                    if(onBudget == 1){
                        
                       
                        
                        print("Clear : Not Peak : Private")
                        
                      //  testLabel.text = "Pleas take Private transport (Cab)"
                        
                        recomendationTransport = "Pleas take Private transport (Cab)"
                    }
                }
                
            
            }
            
    }
      
        
        if(reasonForTravelling == "NotTimeBound"){
            
            print("We are not in time bound")
            
            if(currentSummary == "Optional(Clear)" || currentSummary == "Optional(Partly Cloudy)" || currentSummary == "Optional(Mostly Cloudy)"){ // Clear sky
                
                if(peakChecker == 1){
                    
                    if(onBudget == 0){
                    
                    recomendationTransport = "Pleas take public transport (Train)"
                        
                        print("Clear :  Peak : Public")
                        
                        
                    }
                    if(onBudget == 1){
                    recomendationTransport = "Pleas take Private transport (Cab)"
                        
                        print("Clear :  Peak : Private")
                    }
                    
                }
                if(peakChecker == 0){
                    
                    if(onBudget == 0){
                        
                        recomendationTransport = "Pleas take Public transport (Train or Bus)"
                        
                        print("Clear : Not Peak : Public")
                        
                    }
                    if(onBudget == 1){
                        
                        recomendationTransport = "Pleas take Private transport (Cab)"
                        
                        print("Clear : Not Peak : Private")
                    }
                }
                
            }
                
            else if(currentTemp == "Optional(100)"){ //Very humid
                
                if(peakChecker == 1) {
                    if(onBudget == 0){
                    recomendationTransport = "Pleas take public transport (Bus)"
                        print("Humid :  Peak : Public")
                        
                        publicPeakChecker = 1
                    }
                    if(onBudget == 1){
                    recomendationTransport = "Pleas take Private transport (Cab)"
                        print("Humid :  Peak : Private")
                        
                        privatePeakChecker = 1
                    }
                    
                }
                if(peakChecker == 0){
                    
                    if(onBudget == 0){
                        recomendationTransport = "Pleas take public transport (Bus)"
                        print("Humid : Not Peak : Public")
                    }
                    if(onBudget == 1){
                        recomendationTransport = "Pleas take Private transport (Cab)"
                        print("Humid : Not Peak : Private")
                    }
                    
                }
                
                
            }
            else if(currentSummary == "Optional(Overcast)" || currentSummary == "Optional(Light rain)"){
                
                if(peakChecker == 1){
                    
                    if(onBudget == 0){
                    
                    recomendationTransport = "Wait for sometime and take Bus"
                        print("Overcast :  Peak : Bus")
                        
                        publicPeakChecker = 1
                    }
                    if(onBudget == 1){
                    recomendationTransport = "Book a cab"
                        print("Overcast :  Peak : Cab")
                        
                        privatePeakChecker = 1
                    }
                    
                }
                if(peakChecker == 0){
                    
                    recomendationTransport = "Book a cab"
                    print("Overcast : Not Peak : Cab")
                }
                
                
            }
                
            else if(currentSummary == "Optional(Overcast throughout the day)" || currentSummary == "Optional(Drizzle)" || currentSummary == "Optional(Heavy rain)"){
                
                if(peakChecker == 0){
                    
                    recomendationTransport = "Please take Private transport (Cab)"
                    print("Continous rain : Not Peak : Cab")
                }
                
                if(peakChecker == 1){
                    
                    recomendationTransport = "Please take Private transport (Cab)"
                    print("Continous rain :  Peak : Cab")
                    
                    privatePeakChecker = 1
                    
                }
                
                
            }
            else{
                
                
                if(peakChecker == 1){
                    
                    if(onBudget == 0){
                        
                        recomendationTransport = "Pleas take public transport (Train)"
                        print("Default :  Peak : Public")
                    }
                    if(onBudget == 1){
                        recomendationTransport = "Pleas take Private transport (Cab)"
                         print("Default :  Peak : Private")
                    }
                    
                }
                if(peakChecker == 0){
                    
                    if(onBudget == 0){
                        
                        recomendationTransport = "Pleas take Public transport (Train or Bus)"
                         print("Default : Not Peak : Public")
                        
                    }
                    if(onBudget == 1){
                        
                        recomendationTransport = "Pleas take Private transport (Cab)"
                         print("Default : Not Peak : Private")
                    }
                }
                
                
            }
            
            
            
            
        }
        
    
    
    
    }
    
    
}
*/
