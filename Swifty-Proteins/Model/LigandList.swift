//
//  LigandList.swift
//  Swifty-Proteins
//
//  Created by Patrick RUSSELL on 2018/11/05.
//  Copyright © 2018 Patrick RUSSELL. All rights reserved.
//

import Foundation

class LigandList {
    static var ligands : [String]?
    static let file : String = "ligands.txt"
    private static var initialized : Bool = false
    
    
    init() {
        if let filename = Bundle.main.path(forResource: "ligands", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filename, encoding: String.Encoding.utf8)
                LigandList.ligands = contents.components(separatedBy: "\n")
                LigandList.initialized = true
            }
            catch let error as NSError {
                print(error.localizedDescription)
                LigandList.initialized = false
            }
        }
    }
    
    static func isInit() -> Bool { return LigandList.initialized }
}
