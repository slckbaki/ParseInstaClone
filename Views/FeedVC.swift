//
//  FeedVC.swift
//  PR36-ParseInsta
//
//  Created by Selcuk Baki on 4/5/21.
//

import UIKit
import Parse
import OneSignal


class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    
    var postOwnerArray = [String]()
    var postCommentArray = [String]()
    var postUUIDArray = [String]()
    var postImageArray = [PFFileObject]()
    
    
    var playerID = ""
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
        if let deviceState = OneSignal.getDeviceState() {
            let userId = deviceState.userId
            let pushToken = deviceState.pushToken
            
           
            if userId != nil {
                let user = PFUser.current()?.username
                let object = PFObject(className: "PlayerID")
                object["username"] = user
                object["playerID"] = userId
                object.saveEventually()
            }
         }
        
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(FeedVC.getData), name: NSNotification.Name(rawValue: "newPost"), object: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postOwnerArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        
        
        cell.usernameLabel.text = postOwnerArray[indexPath.row]
        cell.commentLabel.text = postCommentArray[indexPath.row]
        cell.postUUID.text = postUUIDArray[indexPath.row]
        postImageArray[indexPath.row].getDataInBackground { data, error in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                cell.postedImage.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    
   @objc func getData (){
        let query = PFQuery(className: "Posts")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                self.postCommentArray.removeAll(keepingCapacity: false)
                self.postUUIDArray.removeAll(keepingCapacity: false)
                self.postOwnerArray.removeAll(keepingCapacity: false)
                self.postImageArray.removeAll(keepingCapacity: false)
                
                if objects!.count > 0{
                    for object in objects! {
                        self.postOwnerArray.append(object.object(forKey: "postowner") as! String )
                        self.postCommentArray.append(object.object(forKey: "postcomment") as! String)
                        self.postUUIDArray.append(object.object(forKey: "postuuid") as! String)
                        self.postImageArray.append(object.object(forKey: "postimage") as! PFFileObject)
                        
                    }
                }
         
                self.tableView.reloadData()
                
            }
        }
    }
    


}
