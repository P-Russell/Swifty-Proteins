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
    let name : String
    let symbol : String
    let x : Float
    let y : Float
    let z : Float
    
    init(index : Int, name: String, symbol : String, x : Float, y : Float, z : Float) {
        self.index = index
        self.name = name
        self.symbol = symbol
        self.x = x
        self.y = y
        self.z = z
    }
}
