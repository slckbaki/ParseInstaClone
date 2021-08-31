//
//  SettingsVC.swift
//  PR36-ParseInsta
//
//  Created by Selcuk Baki on 4/5/21.
//

import UIKit
import Parse

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



    @IBAction func logoutClick(_ sender: Any) {
        PFUser.logOutInBackground { error in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                
                self.performSegue(withIdentifier: "toMain", sender: nil)
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.synchronize()
            }
        }
        
    }
    
    
    @IBAction func detailsClick(_ sender: Any) {
        openUrl(urlStr: "https://tourvidi.com/")
        
    }
    
    func openUrl(urlStr : String!) {
        if let url = URL(string: urlStr), !url.absoluteString.isEmpty{
            UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.init(rawValue: "Website: \(url)"): URL.self], completionHandler: nil)
        }
    }
    
}
