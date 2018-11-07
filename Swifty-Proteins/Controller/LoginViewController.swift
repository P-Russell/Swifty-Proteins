//
//  LoginViewController.swift
//  Swifty-Proteins
//
//  Created by Daniel BARROW on 2018/11/05.
//  Copyright © 2018 Patrick RUSSELL. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {


    @IBOutlet weak var invalidLabel: UILabel!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if (loginField.text == "dbarrow" && passwordField.text == "password") {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        else {
            loginField.text = ""
            passwordField.text = ""
            invalidLabel.isHidden = false
        }
    }
    @IBAction func touchID(_ sender: UIButton) {
        // 1
        let context = LAContext()
        var error: NSError?
        
        // 2
        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 3
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                {(success, error) in
                    // 4
                    if success {
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    }
                    else {
                        self.showAlertController("Touch ID Authentication Failed")
                    }
                    } as (Bool, Error?) -> Void)
        }
            // 5
        else {
            showAlertController("Touch ID not available")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.isHidden = true
        let context = LAContext()
        var error: NSError?
        
        // 2
        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 3
            self.loginButton.isHidden = false
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //moveToTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
