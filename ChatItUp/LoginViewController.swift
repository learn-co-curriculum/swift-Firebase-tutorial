//
//  LoginViewController.swift
//  ChatItUp
//
//  Created by James Campagno on 11/17/16.
//  Copyright © 2016 Jim Campagno. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        // Uncomment to automatically sign in the user.
        // GIDSignIn.sharedInstance().signInSilently()
    }
    
}


// MARK: - Google Sign In
extension LoginViewController {
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: false, completion: { _ in
            NotificationCenter.default.post(name: .closeLoginVC, object: nil)
        })
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        present(viewController, animated: true, completion: nil)
    }
    
}
