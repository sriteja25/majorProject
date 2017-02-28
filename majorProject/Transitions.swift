//
//  Transitions.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 20/02/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import Foundation

extension CAGradientLayer{
    
    
    func viewGradient(_ topColour:UIColor,bottomColour : UIColor) -> CAGradientLayer{
        
        let gradientColor: [CGColor] = [topColour.cgColor, bottomColour.cgColor]
        let gradientLocations: [Float] = [0.0/1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColor
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        return gradientLayer

    }

    
}

extension UIButton{
    
    func roundedCorners(_ button:UIButton){
        
        button.layer.cornerRadius = 3.33
        button.layer.borderWidth = 0
        
        
    }
    
    
}
