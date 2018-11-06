//
//  Atom.swift
//  Swifty-Proteins
//
//  Created by Patrick RUSSELL on 2018/10/31.
//  Copyright © 2018 Patrick RUSSELL. All rights reserved.
//

import Foundation

class Atom {
    let index : Int
    let symbol : String
    let x : Float
    let y : Float
    let z : Float
    
    init(index : Int, symbol : String, x : Float, y : Float, z : Float) {
        self.index = index
        self.symbol = symbol
        self.x = x
        self.y = y
        self.z = z
    }
    
    init() {
        self.index = 0
        self.symbol = "undefined"
        self.x = 0.0
        self.y = 0.0
        self.z = 0.0
    }
}
