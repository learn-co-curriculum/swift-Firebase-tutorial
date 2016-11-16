//
//  ViewController.swift
//  ChatItUp
//
//  Created by Jim Campagno on 11/15/16.
//  Copyright © 2016 Jim Campagno. All rights reserved.
//

import UIKit
import Firebase

final class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var chatButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func enterChat(_ sender: UIButton) {
        signIntoFirebase()
    }
    
}


// MARK: - Firebase
extension ViewController {
    
    func signIntoFirebase() {
        guard nameTextField.text != nil else { return }
        
        FIRAuth.auth()?.signInAnonymously { [unowned self] user, error in
            
            DispatchQueue.main.async {
                
                guard error == nil else { print(error!.localizedDescription); return }
                
                guard let newUser = user else { print("No user."); return }
                
                self.performSegue(withIdentifier: "ChatSegue", sender: newUser)
                
            }
        }
    }
    
}


// MARK: - Segue
extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let user = sender as! FIRUser
        
        let navC = segue.destination as! UINavigationController
        
        let destVC = navC.topViewController! as! ChatViewController
        
        let member = Member(name: nameTextField.text!, userID: user.uid)
        
        destVC.member = member
        
        destVC.user = user
        
    }
    
}
