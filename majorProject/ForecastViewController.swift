//
//  ForecastViewController.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 21/02/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.isEnabled = false

        viewSetup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func viewSetup(){
    
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.layer.bounds.width, height: self.view.layer.bounds.height))
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "/Users/sriteja/Documents/majorProject/majorProject/BG.jpg")
        let imgView = UIView(frame: CGRect(x: 0, y: 0, width: imageView.layer.bounds.width, height: imageView.layer.bounds.height))
        imgView.backgroundColor = UIColor(red: 49/255, green: 210/255, blue: 255/255, alpha: 0.45)
        imageView.addSubview(imgView)
        self.view.addSubview(imageView)
    
    
    
    }

}
