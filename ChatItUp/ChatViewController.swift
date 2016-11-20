//
//  ChatViewController.swift
//  ChatItUp
//
//  Created by Jim Campagno on 11/15/16.
//  Copyright © 2016 Jim Campagno. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UITableViewController {
    
    var user: FIRUser!
    var member: Member!
    
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    lazy var chatRef: FIRDatabaseReference = self.ref.child("chats")
    lazy var membersRef: FIRDatabaseReference = self.ref.child("members")
    lazy var messagesRef: FIRDatabaseReference = self.ref.child("messages")
    
    
    @IBAction func addChatRoom(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CreateChannel", sender: nil)
    }
    
}


// MARK: - TableView Data Source
extension ChatViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }
    
    
}

// MARK: - Segue
extension ChatViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! CreateChannelViewController
        
        // Test Member
        member = Member(name: "Frodo", userID: "12345-67890")
        
        destVC.chatRef = chatRef
        destVC.membersRef = membersRef
        destVC.messagesRef = messagesRef
        destVC.member = member
    }
    
}
