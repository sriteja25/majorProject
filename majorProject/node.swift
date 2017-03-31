//
//  node.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 28/03/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import Foundation

class Node{

    var value:Bool?
    var leftChild:Node?
    var rightChild:Node?
    var myValue:Int?

    init(value:Bool,leftChild:Node?,rightChild:Node?) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
    init(myValue:Int,leftChild:Node?,rightChild:Node?) {
        self.myValue = myValue
        self.leftChild = leftChild
        self.rightChild = rightChild
        
        
    }

}

var isTimeBound:Bool!
var isNormal:Bool!
var isPleasant:Bool!
var isPeak:Bool!
var isEconomical:Bool!




var time = Node(value: isTimeBound, leftChild: nonTimeBound , rightChild:timeBound )


// Time Bound

var timeBound = Node(value: isNormal, leftChild: tbRain, rightChild:tbNormal )

var tbNormal = Node(value: isPleasant, leftChild: NormalHumid, rightChild: NormalPleasant)

var NormalHumid = Node(value: isPeak, leftChild: HumidNonPeak, rightChild: HumidPeak)

var HumidPeak = Node(value: isEconomical, leftChild: HumidPeakNonEconomical, rightChild: HumidPeakEconomical)
var HumidNonPeak = Node(value: isEconomical, leftChild: HumidNonPeakNonEconomical, rightChild: HumidNonPeakEconomical)

var HumidPeakEconomical = Node(myValue: 1, leftChild: nil, rightChild: nil)
var HumidPeakNonEconomical = Node(myValue: 2, leftChild: nil, rightChild: nil)
var HumidNonPeakEconomical = Node(myValue: 3, leftChild: nil, rightChild: nil)
var HumidNonPeakNonEconomical = Node(myValue: 4, leftChild: nil, rightChild: nil)

var NormalPleasant = Node(value: isPeak, leftChild: PleasantNonPeak, rightChild: PleasantPeak)

var PleasantPeak = Node(value: isEconomical, leftChild: PleasantPeakNonEconomical, rightChild: PleasantPeakEconomical)
var PleasantNonPeak = Node(value: isEconomical, leftChild: PleasantNonPeakNonEconomical, rightChild: PleasantNonPeakEconomical)

var PleasantPeakEconomical = Node(myValue: 5, leftChild: nil, rightChild: nil)
var PleasantPeakNonEconomical = Node(myValue: 6, leftChild: nil, rightChild: nil)
var PleasantNonPeakEconomical = Node(myValue: 7, leftChild: nil, rightChild: nil)
var PleasantNonPeakNonEconomical = Node(myValue: 8, leftChild: nil, rightChild: nil)


var tbRain = Node(value: isPleasant, leftChild: RainContinous, rightChild:  RainNormal)

var RainNormal = Node(value: isPeak, leftChild: RainNormalNonPeak, rightChild: RainNormalPeak)

var RainNormalPeak = Node(value: isEconomical, leftChild: RainNormalPeakNonEconomical, rightChild: RainNormalPeakEconomical)
var RainNormalNonPeak = Node(value: isEconomical, leftChild: RainNormalNonPeakNonEconomical, rightChild: RainNormalNonPeakEconomical)

var RainNormalPeakEconomical = Node(myValue: 9, leftChild: nil, rightChild: nil)
var RainNormalPeakNonEconomical = Node(myValue: 10, leftChild: nil, rightChild: nil)
var RainNormalNonPeakEconomical = Node(myValue: 11, leftChild: nil, rightChild: nil)
var RainNormalNonPeakNonEconomical = Node(myValue: 12, leftChild: nil, rightChild: nil)

var RainContinous = Node(value: isPeak, leftChild: RainContinousNonPeak, rightChild: RainContinousPeak)

var RainContinousPeak = Node(value: isEconomical, leftChild: RainContinousPeakNonEconomical, rightChild: RainContinousPeakEconomical)
var RainContinousNonPeak = Node(value: isEconomical, leftChild: RainContinousNonPeakNonEconomical, rightChild: RainContinousNonPeakEconomical)


var RainContinousPeakEconomical = Node(myValue: 13, leftChild: nil, rightChild: nil)
var RainContinousPeakNonEconomical = Node(myValue: 14, leftChild: nil, rightChild: nil)
var RainContinousNonPeakEconomical = Node(myValue: 15, leftChild: nil, rightChild: nil)
var RainContinousNonPeakNonEconomical = Node(myValue: 16, leftChild: nil, rightChild: nil)


// Non Time Bound

var nonTimeBound = Node(value: isNormal , leftChild: ntbRain, rightChild: ntbNormal )

var ntbNormal = Node(value: isPleasant, leftChild: ntbNormalHumid, rightChild: ntbNormalPleasant)

var ntbNormalHumid = Node(value: isPeak, leftChild: ntbHumidNonPeak, rightChild: ntbHumidPeak)

var ntbHumidPeak = Node(value: isEconomical, leftChild: ntbHumidPeakNonEconomical, rightChild: ntbHumidPeakEconomical)
var ntbHumidNonPeak = Node(value: isEconomical, leftChild: ntbHumidNonPeakNonEconomical, rightChild: ntbHumidNonPeakEconomical)

var ntbHumidPeakEconomical = Node(myValue: 17, leftChild: nil, rightChild: nil)
var ntbHumidPeakNonEconomical = Node(myValue: 18, leftChild: nil, rightChild: nil)
var ntbHumidNonPeakEconomical = Node(myValue: 19, leftChild: nil, rightChild: nil)
var ntbHumidNonPeakNonEconomical = Node(myValue: 20, leftChild: nil, rightChild: nil)

var ntbNormalPleasant = Node(value: isPeak, leftChild: ntbPleasantNonPeak, rightChild: ntbPleasantPeak)

var ntbPleasantPeak = Node(value: isEconomical, leftChild: ntbPleasantPeakNonEconomical, rightChild: ntbPleasantPeakEconomical)
var ntbPleasantNonPeak = Node(value: isEconomical, leftChild: ntbPleasantNonPeakNonEconomical, rightChild: ntbPleasantNonPeakEconomical)

var ntbPleasantPeakEconomical = Node(myValue: 21, leftChild: nil, rightChild: nil)
var ntbPleasantPeakNonEconomical = Node(myValue: 22, leftChild: nil, rightChild: nil)
var ntbPleasantNonPeakEconomical = Node(myValue: 23, leftChild: nil, rightChild: nil)
var ntbPleasantNonPeakNonEconomical = Node(myValue: 24, leftChild: nil, rightChild: nil)


var ntbRain = Node(value: isPleasant, leftChild: ntbRainContinous , rightChild: ntbRainNormal)

var ntbRainNormal = Node(value: isPeak, leftChild: ntbRainNormalNonPeak, rightChild: ntbRainNormalPeak)

var ntbRainNormalPeak = Node(value: isEconomical, leftChild: ntbRainNormalPeakNonEconomical, rightChild: ntbRainNormalPeakEconomical)
var ntbRainNormalNonPeak = Node(value: isEconomical, leftChild: ntbRainNormalNonPeakNonEconomical, rightChild: ntbRainNormalNonPeakEconomical)

var ntbRainNormalPeakEconomical = Node(myValue: 25, leftChild: nil, rightChild: nil)
var ntbRainNormalPeakNonEconomical = Node(myValue: 26, leftChild: nil, rightChild: nil)
var ntbRainNormalNonPeakEconomical = Node(myValue: 27, leftChild: nil, rightChild: nil)
var ntbRainNormalNonPeakNonEconomical = Node(myValue: 28, leftChild: nil, rightChild: nil)

var ntbRainContinous = Node(value: isPeak, leftChild: ntbRainContinousNonPeak, rightChild: ntbRainContinousPeak)

var ntbRainContinousPeak = Node(value: isEconomical, leftChild: ntbRainContinousPeakNonEconomical, rightChild: ntbRainContinousPeakEconomical)
var ntbRainContinousNonPeak = Node(value: isEconomical, leftChild: ntbRainContinousNonPeakNonEconomical, rightChild: ntbRainContinousNonPeakEconomical)

//var ntbRainContinousPeakEconomical = Node(myValue: 10, leftChild: nil, rightChild: nil)
var ntbRainContinousPeakEconomical = Node(myValue: 29, leftChild: nil, rightChild: nil)
var ntbRainContinousPeakNonEconomical = Node(myValue: 30, leftChild: nil, rightChild: nil)
var ntbRainContinousNonPeakEconomical = Node(myValue: 31, leftChild: nil, rightChild: nil)
var ntbRainContinousNonPeakNonEconomical = Node(myValue: 32, leftChild: nil, rightChild: nil)



// declaration

var count:Int?

func searchMyValue(node:Node?) -> Any{
    
    if (count == 5){
    
       return  node?.myValue
    }
    else{
        
        count = count! + 1
        
        if (node?.value == true){
            return searchMyValue(node:node?.rightChild)
        }else{
           return searchMyValue(node:node?.leftChild)
        }
    
    }
    
}

func initialise(){
    
    count = 0

}



