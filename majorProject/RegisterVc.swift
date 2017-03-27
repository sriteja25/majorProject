//
//  RegisterVc.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 20/03/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

var ref: FIRDatabaseReference!




class RegisterVc: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    
    
    
    
    var pickerView = UIPickerView()
    var pickerTravelType = ["Private - Cab","Public - Bus","Public - Train","Personal"]
    
    @IBOutlet var name: UITextField!
    
    @IBOutlet var employement: UITextField!
    
    @IBOutlet var officeTimings: UITextField!
    
    @IBOutlet var travelType: UITextField!
    
    @IBOutlet var age: UITextField!
    
    
    @IBOutlet var scrolView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        createPickerView()
        
        name.tag = 0
        employement.tag = 1
        officeTimings.tag = 2
        travelType.tag = 3
        age.tag = 4
        
        scrolView.contentSize.height = 1000
        // Do any additional setup after loading the view.
        
        ref = FIRDatabase.database().reference()
    }

    
    @IBAction func nameField(_ sender: Any) {
    }

    @IBAction func employementField(_ sender: Any) {
    }
    
    @IBAction func timingsField(_ sender: Any) {
    }
    
    @IBAction func travelTypeField(_ sender: Any) {
        
        scrolView.contentOffset = CGPoint(x: 0, y: 70)
    }
   
    @IBAction func ageField(_ sender: Any) {
    }
   
    func createPickerView(){
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(RegisterVc.doneGender))
        toolbar.setItems([doneButton], animated: false)
        
        pickerView.frame = CGRect(x: 10, y: 520, width: self.view.frame.width, height: 200)
        
        pickerView.backgroundColor = UIColor.white
        
        
        
        // Add an event to call onDidChangeDate function when value is changed.
        travelType.inputAccessoryView = toolbar
        
        travelType.inputView = pickerView
        
        //self.view.addSubview(pickerView)
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerTravelType[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerTravelType.count
        
    }
    
    func doneGender(){
        
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        travelType.text = pickerTravelType[row]
    }
    
    func saveDetails(){
    
    let myName = name.text ?? ""
    let myEmployement = employement.text ?? ""
    let myTimings = officeTimings.text ?? ""
    let myTravel = travelType.text ?? ""
    let myAge = age.text ?? ""
        
        
        let details = ["Name": myName,"My Job": myEmployement,"Office Timings":myTimings,"Transport type":myTravel,"Age" : myAge]
        
        let userId: String? = KeychainWrapper.standard.string(forKey: "keychain") ?? ""
        
        
        ref.child("users").child(userId!).child("Profile").setValue(details)
    
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        saveDetails()
    }
    
    
    
}
