//
//  Colors.swift
//  Swifty-Proteins
//
//  Created by Patrick RUSSELL on 2018/11/02.
//  Copyright © 2018 Patrick RUSSELL. All rights reserved.
//

/*
 brightly colored plastic balls with holes in them.
 A box of ball-and-stick model pieces colored to represent several of the common elements.
 Typical CPK color assignments include:
 
 hydrogen (H)    white
 carbon (C)    black
 nitrogen (N)    dark blue
 oxygen (O)    red
 fluorine (F), chlorine (Cl)    green
 bromine (Br)    dark red
 iodine (I)    dark violet
 noble gases (He, Ne, Ar, Xe, Kr)    cyan
 phosphorus (P)    orange
 sulfur (S)    yellow
 boron (B), most transition metals    peach, salmon
 alkali metals (Li, Na, K, Rb, Cs, Fr)    violet
 alkaline earth metals (Be, Mg, Ca, Sr, Ba, Ra)    dark green
 titanium (Ti)    gray
 iron (Fe)    dark orange
 other elements    pink
 
 Common elements besides carbon (C) that are found in organic compounds include hydrogen (H), oxygen (O), nitrogen (N), phosphorus (P), and sulfur (S
 */
import UIKit

class Colors {
    static let map : Dictionary = [
        "H" : UIColor.white,
        "C" : UIColor.darkGray, //deviation from CPK coloring should be black
        "N" : UIColor.init(red: 0.1137254902, green: 0.1294117647, blue: 1.0, alpha: 1), // Darkblue
        "O" : UIColor.red,
        "F" : UIColor.green,
        "Cl" : UIColor.green,
        "Br" : UIColor.init(red: 0.6078431373, green: 0.1294117647, blue: 0.0, alpha: 1), // Darkred
        "I" : UIColor.init(red: 0.4039215686, green: 0.0, blue: 0.7450980392, alpha: 1), //DarkViolet
        "He" : UIColor.cyan,
        "Ne" : UIColor.cyan,
        "Ar" : UIColor.cyan,
        "Xe" : UIColor.cyan,
        "Kr" : UIColor.cyan,
        "P" : UIColor.orange,
        "S" : UIColor.yellow,
        "B" : UIColor.init(red: 0.9803921569, green: 0.5019607843, blue: 0.4352941176, alpha: 1), //Salmon
        "Li" : UIColor.init(red: 0.4666666667, green: 0.0, blue: 1.0, alpha: 1), //Violet
        "Na" : UIColor.init(red: 0.4666666667, green: 0.0, blue: 1.0, alpha: 1), //Violet
        "K" : UIColor.init(red: 0.4666666667, green: 0.0, blue: 1.0, alpha: 1), //Violet
        "Rb" : UIColor.init(red: 0.4666666667, green: 0.0, blue: 1.0, alpha: 1), //Violet
        "Cs" : UIColor.init(red: 0.4666666667, green: 0.0, blue: 1.0, alpha: 1), //Violet
        "Fr" : UIColor.init(red: 0.4666666667, green: 0.0, blue: 1.0, alpha: 1), //Violet
        "Be" : UIColor.init(red: 0, green: 0.4705882353, blue: 0, alpha: 1), //Dark Green
        "Mg" : UIColor.init(red: 0, green: 0.4705882353, blue: 0, alpha: 1), //Dark Green
        "Ca" : UIColor.init(red: 0, green: 0.4705882353, blue: 0, alpha: 1), //Dark Green
        "Sr" : UIColor.init(red: 0, green: 0.4705882353, blue: 0, alpha: 1), //Dark Green
        "Ba" : UIColor.init(red: 0, green: 0.4705882353, blue: 0, alpha: 1), //Dark Green
        "Ra" : UIColor.init(red: 0, green: 0.4705882353, blue: 0, alpha: 1), //Dark Green
        "Ti" : UIColor.gray,
        "Fe" : UIColor.init(red: 0.8745098039, green: 0.4666666667, blue: 0.0, alpha: 1) //Dark Orange
    ]
}
