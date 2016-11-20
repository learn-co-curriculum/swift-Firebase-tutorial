//
//  LoginManager.swift
//  ChatItUp
//
//  Created by Jim Campagno on 11/20/16.
//  Copyright © 2016 Jim Campagno. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit

class LoginManager: NSObject { }

// MARK: - Google Sign in
extension LoginManager: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        DispatchQueue.main.async {
            
            guard error == nil else { /* TODO */ return }
            
            let authentication = user.authentication
            let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!,
                                                              accessToken: (authentication?.accessToken)!)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                }
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // TODO
    }
    
}

// MARK: - Facebook Log In
extension LoginManager: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        DispatchQueue.main.async {
            
            guard result != nil, !result.isCancelled, error == nil else { /* TODO */  return }
            
            guard let accessToken = FBSDKAccessToken.current()?.tokenString else { /* TODO */ return }
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        // TODO
    }
    
}
