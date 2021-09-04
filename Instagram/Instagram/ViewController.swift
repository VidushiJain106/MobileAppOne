//
//  ViewController.swift
//  Instagram
//
//  Created by Vidushi Jain on 9/4/21.
//

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            
        } else {
            print("There was a problem getting the image")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func chooseImage(_ sender: Any) {
        let imagePickercontroller = UIImagePickerController()
        imagePickercontroller.delegate = self
        imagePickercontroller.sourceType = UIImagePickerController.SourceType.photoLibrary;
        imagePickercontroller.allowsEditing = false
        self.present(imagePickercontroller, animated:true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }

}

