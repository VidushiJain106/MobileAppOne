//
//  PostViewController.swift
//  Instagram
//
//  Created by Vidushi Jain on 9/5/21.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:50, height:50))
    
    @IBOutlet weak var chooseImageButton: UIButton!
    @IBAction func chooseImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageToPost.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in
            }))
        self.present(alert, animated: true)
    }
    
    func showLoadingIcon() {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        chooseImageButton.isHidden = true
        
    }
    
    @IBAction func postImage(_ sender: Any) {
        print("trying to post")
        if let image = imageToPost.image {
        
            let post = PFObject(className: "Post")
            post["message"] = comment.text
            post["userid"] = PFUser.current()?.objectId
            print(post)
            if let imageData = image.pngData() {
                let imageFile = PFFileObject(name: "image.png", data: imageData)
                post["imageFile"] = imageFile
                showLoadingIcon()
                
                post.saveInBackground { (success,error) in
                    self.activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    self.chooseImageButton.isHidden = false
                    if success {
                        self.displayAlert(title: "Image Posted!", message: "Your image has been posted successfully")
                        self.comment.text = ""
                        self.imageToPost.image = nil
                    }
                    else {
                        self.displayAlert(title: "Post Failed!", message: "Please try again")
                    }
                }
            } else {
                print("couldnt convert image to png")
            }
        } else {
            print("need to select an image")
        }
    }
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var imageToPost: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
