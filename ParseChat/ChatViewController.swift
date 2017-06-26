//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Maxine Kwan on 6/26/17.
//  Copyright © 2017 Maxine Kwan. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

   
    @IBOutlet weak var chatMessageField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendButton(_ sender: Any) {
        let chatMessage = PFObject(className: "Message_fbuJuly2017")
        chatMessage["text"] = chatMessageField.text ?? ""
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving the message: \(error.localizedDescription)")
            }
    }

}
}
