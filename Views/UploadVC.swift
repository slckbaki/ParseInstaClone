//
//  UploadVC.swift
//  PR36-ParseInsta
//
//  Created by Selcuk Baki on 4/5/21.
//

import UIKit
import Parse

class UploadVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var commentText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(hidekeyboard))
        self.view.addGestureRecognizer(keyboardRecognizer)


        postImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        postImage.addGestureRecognizer(gestureRecognizer)

    }
    
    @objc func hidekeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func choosePhoto(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        postImage.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    

  
    @IBAction func logOutClick(_ sender: Any) {
        PFUser.logOutInBackground { error in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                self.performSegue(withIdentifier: "fromUpload", sender: nil)
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.synchronize()
            }
        }
      
    }
    
    @IBAction func uploadClick(_ sender: Any) {
        
        let object = PFObject(className: "Posts")
        let data = postImage.image?.jpegData(compressionQuality: 0.5)
        let pfImage = PFFileObject(name: "image", data: data!)
        
        let uuid = UUID().uuidString
        let uuidpost = "\(uuid) \(PFUser.current()?.username!)"
        
        
        object["postimage"] = pfImage
        object["postcomment"] = commentText.text
        object["postowner"] = PFUser.current()!.username
        object["postuuid"] = uuidpost
        object["uuidImage"] = uuid
        
        object.saveInBackground { success, error in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                self.commentText.text = ""
                self.postImage.image = UIImage(named: "image.png")
                self.tabBarController?.selectedIndex = 0
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPost"), object: nil)
                
                
            }
        }
        
        
        
        
        
    }
    
  
}
