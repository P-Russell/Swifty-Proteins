//
//  ProteinTableViewController.swift
//  Swifty-Proteins
//
//  Created by Patrick RUSSELL on 2018/11/05.
//  Copyright © 2018 Patrick RUSSELL. All rights reserved.
//

import UIKit
import SVProgressHUD

class LigandCell : UITableViewCell {
    @IBOutlet weak var ligandLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
}

class ProteinTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!

    @IBAction func backToLogin(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginScreen") as! LoginViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    var userSelection : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = LigandList.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LigandList.isInit() { return LigandList.ligands!.count }
        else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! LigandCell
        cell.ligandLabel?.adjustsFontSizeToFitWidth = true
        cell.indexLabel?.adjustsFontSizeToFitWidth = true
        if LigandList.isInit() {
            cell.indexLabel.text = String(indexPath.row + 1)
            cell.ligandLabel?.text = LigandList.ligands![indexPath.row]
        }
        else {
            cell.textLabel?.text = "Error"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if LigandList.isInit() {
            userSelection = LigandList.ligands![indexPath.row]
            performSegue(withIdentifier: "showLigand", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLigand" {
            let nextScreen = segue.destination as! SceneViewController
            if let ligand = userSelection { nextScreen.displayLigand = ligand }
        }
    }
}
