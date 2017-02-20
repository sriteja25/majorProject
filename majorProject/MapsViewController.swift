//
//  MapsViewController.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 28/10/16.
//  Copyright © 2016 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import MapKit


class MapsViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var maps: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var mapHasCenetredOnce = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        maps.delegate = self
        maps.userTrackingMode = MKUserTrackingMode.follow

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locAuthStatus()
    }
    
    func locAuthStatus(){
    
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
        
        maps.showsUserLocation = true
            }
        else{
        
        locationManager.requestWhenInUseAuthorization()
        
        
        }
    
    
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
        
            maps.showsUserLocation = true
        
        }
    }
    
    func centerMapOnLocation(_ location : CLLocation){
    
    let cordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        
        maps.setRegion(cordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let loc = userLocation.location{
            
            if !mapHasCenetredOnce{
            
                centerMapOnLocation(loc)
                mapHasCenetredOnce = true
                }
        }
    }
    
    
    

    

}
