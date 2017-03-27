//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by Robert Chen on 12/23/15.
//  Copyright © 2015 Thorn Technologies. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch: class {
    func dropPinZoomIn(_ placemark:MKPlacemark)
}

class ViewController: UIViewController {
    
    var selectedPin: MKPlacemark?
    var resultSearchController: UISearchController!
    
    let locationManager = CLLocationManager()
    
    var mySelectedPlace:String = ""
    var searchBar = UISearchBar()
    var b:Int?
    var a:Int?
    var myLocation:String?
    var myDestination:String?
     let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func button3(_ sender: AnyObject) {
        getDirections()
    }
    
    
    @IBOutlet var nextButton: UIBarButtonItem!
    
    @IBOutlet var doneButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let myAdress = defaults.object(forKey: "myAdress") as? String ?? ""
        
        myLocation = myAdress
        searchBar.text = myAdress
    }

    
    
    func storeValues() {
        a = defaults.object(forKey: "a") as? Int ?? 0
        
        if (a == 1){
            
            
            
            let myAdress = defaults.object(forKey: "myAdress") as? String ?? ""
            
            myLocation = myAdress
            
        }
        if (a==2){
            
            let myAdress = defaults.object(forKey: "myAdress") as? String ?? ""
            searchBar.text = myAdress
            myDestination = myAdress
            
            
        }
    }
    
    func getDirections(){
        guard let selectedPin = selectedPin else { return }
        let mapItem = MKMapItem(placemark: selectedPin)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        storeValues()
        
        defaults.set(myLocation, forKey: "source")
        
        defaults.synchronize()
        
        performSegue(withIdentifier: "myLocationTo", sender: nil)
        
        
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        storeValues()
      
        defaults.set(myDestination, forKey: "destination")
        defaults.synchronize()
        
        performSegue(withIdentifier: "myDestinationTo", sender: nil)
        
    }
    
    
}

extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }

}

extension ViewController: HandleMapSearch {
    
    func dropPinZoomIn(_ placemark: MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
                annotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
}

extension ViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        let reuseId = "pin"
        guard let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView else { return nil }
        
        pinView.pinTintColor = UIColor.orange
        pinView.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        var button: UIButton?
        button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button?.setBackgroundImage(UIImage(named: "car"), for: UIControlState())
        button?.addTarget(self, action: #selector(ViewController.getDirections), for: .touchUpInside)
        pinView.leftCalloutAccessoryView = button
        
        return pinView
    }
    
    
    
}
