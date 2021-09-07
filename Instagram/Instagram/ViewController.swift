//
//  ViewController.swift
//  Instagram
//
//  Created by Vidushi Jain on 9/4/21.
//

import UIKit
import Parse

class ViewController: UIViewController{

    var signupModeActive = true
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    func displayAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in
            }))
        self.present(alert, animated: true)
    }
    
    @IBOutlet weak var switchLoginModeLabel: UILabel!
    
    @IBOutlet weak var singUpOrLoginButton: UIButton!
    @IBAction func signUpOrLogin(_ sender: Any) {
        if email.text == "" || password.text == "" {
            displayAlert(title:"Error in form", message:"Please enter a valid email and password")
        } else {
            
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:50, height:50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.large
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
            
            if (signupModeActive) {
                let user = PFUser()
                user.username = email.text
                user.password = password.text
                user.email = email.text

                user.signUpInBackground {(succeeded: Bool, error: Error?) -> Void in
                    activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    
                    if let error = error {
                        let errorString = error.localizedDescription
                        print(errorString)
                        self.displayAlert(title: "Error signing up", message: errorString)
                        // Show the errorString somewhere and let the user try again.
                    } else {
                        print("Signed Up")
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                        // Hooray! Let them use the app now.
                    }
                }
            } else {
                PFUser.logInWithUsername(inBackground:email.text!, password:password.text!) {
                  (user: PFUser?, error: Error?) -> Void in
                  activityIndicator.stopAnimating()
                  self.view.isUserInteractionEnabled = true
                  if user != nil {
                    print("Logged in")
                    self.performSegue(withIdentifier: "showUserTable", sender: self)
                    
                  } else {
                    if error != nil {
                        let errorString = error!.localizedDescription
                        self.displayAlert(title: "Error logging in", message: errorString)
                    } else {
                        self.displayAlert(title: "Error logging in", message: "Unknown Error")
                    }
                  }
                }
            }
        }
    }
    @IBOutlet weak var switchLoginModeButton: UIButton!
    @IBAction func switchLoginMode(_ sender: Any) {
        if (signupModeActive) {
            signupModeActive = false
            singUpOrLoginButton.setTitle("Login", for: [])
            switchLoginModeButton.setTitle("Sign Up", for: [])
            switchLoginModeLabel.text = "Don't have an account?"
        } else {
            signupModeActive = true
            singUpOrLoginButton.setTitle("Sign Up", for: [])
            switchLoginModeButton.setTitle("Login", for: [])
            switchLoginModeLabel.text = "Already have an account?"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            performSegue(withIdentifier: "showUserTable", sender: self)
        }
        
        self.navigationController?.navigationBar.isHidden = true
    }
}
