//
//  Tiger.swift
//  LionsAndTigers
//
//  Created by Ed Dikotope on 2014/09/24.
//  Copyright (c) 2014 Morwamoche. All rights reserved.
//

import Foundation
import UIKit

struct Tiger {
    var name:String = "";
    var age:Int = 0;
    var breed:String = "";
    var image:UIImage = UIImage(named: "")!;
    
    func chuff(){
        print("chuff");
    }
    
    func chuffANumberOfTimes(numberOfTimes:Int){
        for _ in 0...numberOfTimes {
            self.chuff();
        }
    }
}