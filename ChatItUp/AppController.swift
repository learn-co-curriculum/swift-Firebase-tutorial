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
    
    @IBOutlet weak var containerView: UIView!
    var actingVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialViewController()
        addNotificationObservers()
    }
    
}


// MARK: - Loading VC's
extension AppController {
    
    func loadInitialViewController() {
        
        FIRAuth.auth()?.addStateDidChangeListener { [unowned self] auth, user in
            
            print("-----\(#function)-------\n")
            
            print("Auth is: \(auth)")
            print("user is: \(user)")
            
            print("\n")
            print("--------------------------\n")

            let userIsLoggedIn = user != nil
            let id: StoryboardID = userIsLoggedIn ? .chatsVC : .loginVC
            self.actingVC = self.loadViewController(withID: id)
            self.add(viewController: self.actingVC, animated: true)
        }
    }
    
    func loadViewController(withID id: StoryboardID) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id.rawValue)
    }
    
}


// MARK: - Displaying VC's
extension AppController {
    
    func add(viewController: UIViewController, animated: Bool = false) {
        
        print("======\(#function)=========\n")
        
        print("\n")
        
        print("===========================\n")
        
        self.addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        containerView.alpha = 0.0
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
        
        guard animated else { containerView.alpha = 1.0; return }
        
        UIView.transition(with: containerView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            
            self.containerView.alpha = 1.0
            
        }) { _ in }
        
    }
    
    func switchViewController(with notification: Notification) {
        switch notification.name {
        case Notification.Name.closeLoginVC:
            switchToViewController(with: .chatsVC)
        case Notification.Name.closeChatVC:
            switchToViewController(with: .loginVC)
        default:
            fatalError("\(#function) - Unable to match notficiation name.")
        }
        
    }
    
    private func switchToViewController(with id: StoryboardID) {
        let existingVC = actingVC
        existingVC?.willMove(toParentViewController: nil)
        actingVC = loadViewController(withID: id)
        addChildViewController(actingVC)
        add(viewController: actingVC)
        actingVC.view.alpha = 0.0
    
        UIView.animate(withDuration: 0.8, animations: {
            
            self.actingVC.view.alpha = 1.0
            existingVC?.view.alpha = 0.0
            
        }) { success in
            
            existingVC?.view.removeFromSuperview()
            existingVC?.removeFromParentViewController()
            self.actingVC.didMove(toParentViewController: self)
            
        }
        
    }
    
    
}


// MARK: - Notficiation Observers
extension AppController {
    
     func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeLoginVC, object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeChatVC, object: nil)
    }
    
}


// MARK: - Notification Extension
extension Notification.Name {
    
   // static let closeSafariVC = Notification.Name("close-safari-view-controller")
    static let closeLoginVC = Notification.Name("close-login-view-controller")
    static let closeChatVC = Notification.Name("close-chat-view-controller")
    
}


// MARK: - UIView Extension
extension UIView {
    
    func constrainEdges(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}

