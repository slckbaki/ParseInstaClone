//
//  ViewController.swift
//  PR36-ParseInsta
//
//  Created by Selcuk Baki on 4/5/21.
//

import UIKit
import Parse

class SignInVC: UIViewController {


    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//PARSE VERI OLUSTURMA
        
        
        /*
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "muz"
        parseObject["claries"] = 150
        parseObject.saveInBackground { success, error in
            if error != nil{
                print(error?.localizedDescription ?? "Error")
            }else{
                print("saved")
            }
            
        }
        
        
        
//PARSE VERI CEKME
        let query = PFQuery(className: "Fruits")
        query.whereKey("claries", greaterThan: 100)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            }else{
                print(objects)
            }
        }


         */
        
        
    }

    @IBAction func signInClick(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" && emailText.text != "" {
            
            
            
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { user, error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    
//REMEMBER USER FUNC
                    
                    UserDefaults.standard.setValue(self.usernameText.text!, forKey: "username")
                    UserDefaults.standard.synchronize()
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        
        } else {
            let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func signupClick(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" && emailText.text != "" {
            
        let user = PFUser()
        user.email = emailText.text!
        user.password = passwordText.text!
        user.username = usernameText.text!
            
            user.signUpInBackground { success, error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    UserDefaults.standard.setValue(self.usernameText.text!, forKey: "username")
                    UserDefaults.standard.synchronize()
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                    

                    
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}

