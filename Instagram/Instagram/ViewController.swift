//
//  ViewController.swift
//  Instagram
//
//  Created by Vidushi Jain on 9/4/21.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let gameScore = PFObject(className:"GameScore")
        gameScore["score"] = 1337
        gameScore["playerName"] = "Sean Plott"
        gameScore["cheatMode"] = false
        gameScore.saveInBackground { (succeeded, error)  in
            if (succeeded) {
                print("Success!")
            } else {
                print("Failed!")
            }
        }

        
    }


}

