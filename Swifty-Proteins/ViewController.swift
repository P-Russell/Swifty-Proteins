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
        pdbApi.fetch(ligand : "10S")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
