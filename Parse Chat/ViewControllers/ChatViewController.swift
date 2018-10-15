//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Priscilla on 2018/10/15.
//  Copyright © 2018年 Tony. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var messages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50

    }
    
    @IBOutlet weak var chatMessageField: UITextField!
    
    @IBAction func message(_ sender: Any) {
   
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        
        chatMessage["user"] = PFUser.current() as! PFUser
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = nil
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimerRefresh), userInfo: nil, repeats: true)
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages[indexPath.row]
        cell.messageText.text = message["text"] as! String
        if let user = message["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameText.text = user.username
        } else {
            // No user found, set default username
            cell.usernameText.text = "🤖"
        }
        
        return cell
    }
    
    //
    @objc func onTimerRefresh() {
        // construct query
        let query = PFQuery(className:"Message")
        query.includeKey("user")
        query.limit = 30
        query.addDescendingOrder("createdAt")
        // fetch data asynchronously
        query.findObjectsInBackground { (message: [PFObject]?, error: Error?) in
            if message == message {
                self.messages = message!
                for a in self.messages{
                    print(a["text"])
                }
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    

}
