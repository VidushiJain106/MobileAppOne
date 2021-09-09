//
//  FeedTableViewController.swift
//  Instagram
//
//  Created by Vidushi Jain on 9/5/21.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController {
    
    var users = [String: String]()
    var comments = [String]()
    var usernames = [String]()
    var imageFiles = [PFFileObject]()
    var images = [UIImage]()
    
    func getImageFromPath(imagePath:String) {
        let url = URL(string: "http://ec2-3-143-204-92.us-east-2.compute.amazonaws.com:8000" + imagePath)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let image = UIImage(data: data)!
                self.images.append(image)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    
    func getPhotosForTopic(topic:String) {
        let url = URL(string: "http://ec2-3-143-204-92.us-east-2.compute.amazonaws.com:5000/search/" + topic.dropFirst(1))!
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = json as? [String: Any] {
                    if let imagePaths = dictionary["images"] as? [String] {
                        for imagePath in imagePaths {
                            self.getImageFromPath(imagePath: imagePath)
                            self.comments.append("")
                            self.usernames.append(topic)
                        }
                    }
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let query = PFUser.query()
        query?.whereKey("username", notEqualTo: PFUser.current()?.username)
        query?.findObjectsInBackground(block: { objects,error in
            if let users = objects {
                for object in users {
                    if let user = object as? PFUser {
                        self.users[user.objectId!] = user.username!
                    }
                }
            }
            
            let getFollowedUsersQuery = PFQuery(className: "Following")
            getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.current()?.objectId)
            getFollowedUsersQuery.findObjectsInBackground { objects,error in
                if let followers = objects {
                    for follower in followers {
                        if let followedUser = follower["following"] {
                            if self.users[followedUser as! String]!.hasPrefix("#") {
                                self.getPhotosForTopic(topic: self.users[followedUser as! String]!)
                            } else {
                                let postsQuery = PFQuery(className: "Post")
                                postsQuery.whereKey("userid", equalTo: followedUser)
                                postsQuery.findObjectsInBackground { objects,error in
                                    if let posts = objects {
                                        
                                        for post in posts {
                                            if let imageFile = post["imageFile"] {
                                                (imageFile as! PFFileObject).getDataInBackground { data, error in
                                                    if let imageData = data {
                                                        if let imageToDisplay = UIImage(data:imageData) {
                                                            self.images.append(imageToDisplay)
                                                            self.comments.append(post["message"] as! String)
                                                            self.usernames.append(self.users[post["userid"] as! String]!)
                                                            self.tableView.reloadData()
                                                        }
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        })
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330.0;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        
        cell.postedImage.image = self.images[indexPath.row]
        cell.comment.text = comments[indexPath.row]
        cell.userInfo.text = usernames[indexPath.row]

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


