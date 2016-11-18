//
//  AppController.swift
//  ChatItUp
//
//  Created by James Campagno on 11/17/16.
//  Copyright © 2016 Jim Campagno. All rights reserved.
//

import UIKit
import Firebase

final class AppController: UIViewController {
    
    weak var delegate: ButtonPressDelegate!
    var customView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        delegate = customView
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            
            if user != nil {
                
                
                // User is signed in.
            } else {
                // No user is signed in.
            }
        }
        
        
    }
    
    
    
    
    
    
    
}

extension UIView: ButtonPressDelegate {
    
    func buttonWasTapped(sender: UIButton) {
        print("YOLO")
    }
    
}



protocol ButtonPressDelegate: class {
    
    func buttonWasTapped(sender: UIButton)
    
}



// MARK: - Loading VC's
extension AppController {
    
    
    func loadInitialViewController() {
        
        
        
    }
    
    
    
    func loadViewController(withID id: StoryboardID) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: id.rawValue)
        
    }
    
}
