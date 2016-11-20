//
//  LoginViewController.swift
//  ChatItUp
//
//  Created by James Campagno on 11/17/16.
//  Copyright © 2016 Jim Campagno. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin
import FacebookCore
import FBSDKLoginKit


class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    var googleSignInButton: UIButton!
    var facebookSignInButton: LoginButton!
    var testFacebookButton: FBSDKLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        googleButton()
        facebookButton()
    }
    
    func googleButton() {
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
    
    func facebookButton() {
        let width = googleSignInButton.layer.frame.size.width
        let height = googleSignInButton.layer.frame.size.height
        var origin = googleSignInButton.layer.frame.origin
        origin.y += height + 10
        let frame = CGRect(x: origin.x, y: origin.y, width: width, height: height)
        
        testFacebookButton = FBSDKLoginButton()
        
        testFacebookButton.delegate = self
        
        
        testFacebookButton.frame = frame
        
        
        view.addSubview(testFacebookButton)
        
        view.layoutIfNeeded()
        
        
        
    }
    
    
    
    func signIn(sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
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


// MARK: - Facebook Log In
extension LoginViewController: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        DispatchQueue.main.async {
            
        
        
        if result.isCancelled { return }
        
        print("-----------------------\(#function)------------------\n")
        print("Button: \(loginButton)")
        print("\n")
        print("Result: \(result)")
        print("\n")
        print("Error: \(error)")
        
        if let result = result {
            
            
            
            
            
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let accessToken = FBSDKAccessToken.current()
            
            print("Access token: \(accessToken)")
            
            
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken!.tokenString)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                
                DispatchQueue.main.async {
                    
                
                
                NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                
                }
                
            }
            
        } else {
            
            print("Bad")
            
        }
        
        
        print("----------------------------------------------------------\n")

        }
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        
        
    }
    
    
    
    
    
    
    
    
}
