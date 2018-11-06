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

class ProteinTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func shareButton(_ sender: Any) {
    }
    
    @IBAction func backToLogin(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginScreen") as! LoginViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    var userSelection : String?
    var searchList : [String] = [String]()
    var searching : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = LigandList.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let ligandList = LigandList.ligands {
            searchList = ligandList.filter({$0.prefix(searchText.count) == searchText})
            searching = true
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LigandList.isInit() {
            if searching { return searchList.count }
            else { return LigandList.ligands!.count }
        }
        else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! LigandCell
        cell.ligandLabel?.adjustsFontSizeToFitWidth = true
        cell.indexLabel?.adjustsFontSizeToFitWidth = true
        if LigandList.isInit() {
            if searching {
                cell.indexLabel.text = String(indexPath.row + 1)
                cell.ligandLabel?.text = searchList[indexPath.row]
            }
            else {
                cell.indexLabel.text = String(indexPath.row + 1)
                cell.ligandLabel?.text = LigandList.ligands![indexPath.row]
            }
        }
        else {
            cell.textLabel?.text = "Error"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if LigandList.isInit() {
            if searching { userSelection = searchList[indexPath.row] }
            else { userSelection = LigandList.ligands![indexPath.row] }
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
