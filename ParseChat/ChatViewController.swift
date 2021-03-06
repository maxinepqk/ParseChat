//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Maxine Kwan on 6/26/17.
//  Copyright © 2017 Maxine Kwan. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource{
    
    var messages: [PFObject]?
    
    @IBOutlet weak var ChatTableView: UITableView!
    @IBOutlet weak var chatMessageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatTableView.dataSource = self
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.refresh), userInfo: nil, repeats: true)

        ChatTableView.rowHeight = UITableViewAutomaticDimension
        ChatTableView.estimatedRowHeight = 50
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendButton(_ sender: Any) {
        let chatMessage = PFObject(className: "Message_fbu2017")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()

        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving the message: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages?[indexPath.row] //How do we get a message from messages??
        if let user = message?["user"] as? PFUser {
            cell.usernameLabel.text = user.username
        } else {
            cell.usernameLabel.text = "🤖"
        }
        
        cell.chatLabel.text = message?["text"] as! String
        
        
        return cell
        
    }
    
    func refresh() {
        let query = PFQuery(className: "Message_fbu2017")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (chatMessages: [PFObject]?, error: Error?) in
            self.messages = chatMessages
            self.ChatTableView.reloadData()
        
        }

    }
    
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.dismiss(animated: true, completion: nil)
                print("Logout successful")
            }
        }
    }

}
