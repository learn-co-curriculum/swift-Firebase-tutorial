//
//  CreateChannelViewController.swift
//  ChatItUp
//
//  Created by Jim Campagno on 11/15/16.
//  Copyright © 2016 Jim Campagno. All rights reserved.
//

import UIKit
import Firebase

class CreateChannelViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    
    var chatRef: FIRDatabaseReference!
    var membersRef: FIRDatabaseReference!
    var messagesRef: FIRDatabaseReference!
    
    var member: Member!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        circleTheButtons()
    }
    
    @IBAction func createChannel(_ sender: UIButton) {
        createChatRoom()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - Firebase
extension CreateChannelViewController {
    
    func createChatRoom() {
        
        guard let title = nameTextField.text else { return }
        let uniqueID = UUID().uuidString
        let timestamp = FIRServerValue.timestamp()
        
        let chat = Chat(uniqueID: uniqueID, title: title, timestamp: timestamp, members: [member])
        
        let newChatsRef = chatRef.child(uniqueID)
        let newMembersRef = membersRef.child(uniqueID)
        
        newChatsRef.setValue(chat.chatsSerialize()) { error, ref in
            
            DispatchQueue.main.async {
                
                newMembersRef.setValue(chat.membersSerialize()) { [unowned self] error, ref in
                    
                    DispatchQueue.main.async {
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                }
            }
        }
    }
    
}


// MARK: - Buttons
extension CreateChannelViewController {
    
    func circleTheButtons() {
        circle(button: greenButton)
        circle(button: redButton)
    }
    
    private func circle(button: UIButton) {
        button.layer.cornerRadius = greenButton.frame.size.height / 2
        button.layer.masksToBounds = true
    }
    
}
