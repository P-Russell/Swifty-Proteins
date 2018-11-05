//
//  ProteinTableViewController.swift
//  Swifty-Proteins
//
//  Created by Patrick RUSSELL on 2018/11/05.
//  Copyright © 2018 Patrick RUSSELL. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProteinTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    let pdb : ProteinDataBankAPI = ProteinDataBankAPI()
    
    override func viewDidLoad() {
        _ = LigandList.init()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LigandList.isInit() { return LigandList.ligands!.count }
        else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style : UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        if LigandList.isInit() {
            cell.textLabel?.text = LigandList.ligands![indexPath.row]
        }
        else {
            cell.textLabel?.text = "Error"
        }
        return cell
    }
    
    func dosomeStuff() {
        DispatchQueue.global(qos: .userInitiated).async {
            SVProgressHUD.show()
            DispatchQueue.main.async {
//                Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.doSeque), userInfo: nil, repeats: true)
                self.doSeque()
            }
        }
    }
    
    @objc func doSegue() {
        SVProgressHUD.dismiss()
        performSegue(withIdentifier: "showLigand", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.global(qos: .userInitiated).async {
            SVProgressHUD.show(withStatus: "Fetching data for \(LigandList.ligands![indexPath.row]) ligand")
            if self.pdb.oldFetch(ligand: LigandList.ligands![indexPath.row]) {
                DispatchQueue.main.async {
                    self.doSegue()
                }
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if LigandList.isInit(){
//            if pdb.oldFetch(ligand: LigandList.ligands![indexPath.row]) {
//                performSegue(withIdentifier: "showLigand", sender: nil)
//            }
//            else {
//                //todo : Alert the user that something went wrong
//            }
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLigand" {
            let nextScreen = segue.destination as! SceneViewController
            if let ligand = pdb.ligand { nextScreen.ligand = ligand }
        }
    }
}
