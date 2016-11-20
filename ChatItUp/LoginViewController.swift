//
//  LoginViewController.swift
//  ChatItUp
//
//  Created by James Campagno on 11/17/16.
//  Copyright © 2016 Jim Campagno. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit


class LoginViewController: UIViewController {
    
    var googleSignInButton: UIButton!
    var facebookSignInButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        createGoogleButton()
        createFacebookButton()
    }
    
}

// MARK: - Creating Buttons
extension LoginViewController {
    
    func createGoogleButton() {
        googleSignInButton = UIButton(type: .system)
        googleSignInButton.setBackgroundImage(#imageLiteral(resourceName: "RedGoogleButton"), for: .normal)
        googleSignInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(googleSignInButton)
        
        let constant: CGFloat = -24
        googleSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        googleSignInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        googleSignInButton.widthAnchor.constraint(equalToConstant: 193).isActive = true
        googleSignInButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        view.layoutIfNeeded()
    }
    
    func createFacebookButton() {
        let width = googleSignInButton.layer.frame.size.width
        let height = googleSignInButton.layer.frame.size.height
        var origin = googleSignInButton.layer.frame.origin
        origin.y += height + 10
        let frame = CGRect(x: origin.x, y: origin.y, width: width, height: height)
        
        facebookSignInButton = FBSDKLoginButton()
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        facebookSignInButton.delegate = appdelegate.loginManager
        facebookSignInButton.frame = frame
        
        view.addSubview(facebookSignInButton)
        view.layoutIfNeeded()
    }
}


// MARK: - Google UI Delegate
extension LoginViewController: GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: false, completion: { _ in
        })
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        present(viewController, animated: true, completion: nil)
    }
    
    func signIn() {
        GIDSignIn.sharedInstance().signIn()
    }
    
}


