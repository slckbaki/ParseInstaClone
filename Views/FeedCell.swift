//
//  FeedCell.swift
//  PR36-ParseInsta
//
//  Created by Selcuk Baki on 6/5/21.
//

import UIKit
import Parse
import OneSignal

class FeedCell: UITableViewCell {
    @IBOutlet weak var postedImage: UIImageView!
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    

    @IBOutlet weak var postUUID: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    var playerIDArray = [String]()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        postUUID.isHidden = true
        
        postedImage.isUserInteractionEnabled = true
        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        postedImage.addGestureRecognizer(imageTapped)
        playerIDArray.remove(at: <#T##Int#>)
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButton(_ sender: Any) {
        let likeObject = PFObject(className: "Likes")
        likeObject["from"] = PFUser.current()!.username
        likeObject["to"] = postUUID.text
        
        likeObject.saveInBackground { success, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }else{
                let query = PFQuery(className: "PlayerID")
                query.whereKey("username", equalTo: self.usernameLabel.text)
                query.limit = 1
                query.findObjectsInBackground { objects, error in
                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                        alert.addAction(okButton)
                        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                        
                    }else{
                        self.playerIDArray.removeAll(keepingCapacity: false)
                        
                        for object in objects! {
                            self.playerIDArray.append(object.object(forKey: "playerID") as! String)
                            
                            OneSignal.postNotification(["contents": ["en": "\(PFUser.current()!.username!) liked your photo"], "include_player_ids": ["\(self.playerIDArray.last!)"]])
                            
                        }
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func commentButton(_ sender: Any) {
        let commentObject = PFObject(className: "Comments")
        commentObject["from"] = PFUser.current()!.username
        commentObject["to"] = postUUID.text
        
        commentObject.saveInBackground { success, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }else{
                let query = PFQuery(className: "PlayerID")
                query.whereKey("username", equalTo: self.usernameLabel.text)
                query.limit = 1
                query.findObjectsInBackground { objects, error in
                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                        alert.addAction(okButton)
                        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                        
                        
                    }else{
                        self.playerIDArray.removeAll(keepingCapacity: false)
                        
                        for object in objects! {
                            self.playerIDArray.append(object.object(forKey: "playerID") as! String)
                            
                            OneSignal.postNotification(["contents": ["en": "\(PFUser.current()!.username!) commented your photo"], "include_player_ids": ["\(self.playerIDArray.last!)"], "ios_badgeType" : "Increase", "ios_badgeCount": "1" ])
                            
                        }
                    }
                }
            }
        }
    }
    
    
    
    @objc func imageTapped(){
        print("image Tapped")
        
    }
}
