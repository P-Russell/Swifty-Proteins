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
        pdbApi.getStubData()
//        pdbApi.fetch(ligand : "10S")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSceneView" {
            let nextScreen = segue.destination as! SceneViewController
            if let ligand = pdbApi.ligand { nextScreen.ligand = ligand }
        }
    }
}
