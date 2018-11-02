//
//  ViewController.swift
//  Swifty-Proteins
//
//  Created by Patrick RUSSELL on 2018/10/31.
//  Copyright © 2018 Patrick RUSSELL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let pdbApi : ProteinDataBankAPI = ProteinDataBankAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        pdbApi.fetch(ligand : "0RU")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.testGetData()
        }
        // Dispose of any resources that can be recreated.
    }
    
    func testGetData() {
        if let url = URL(string: "https://www.hackingwithswift.com") {
            do {
                let contents = try String(contentsOf: url)
                print(contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }
}
