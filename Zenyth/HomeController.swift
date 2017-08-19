//
//  HomeController.swift
//  Zenyth
//
//  Created by Hoang on 7/21/17.
//  Copyright © 2017 Hoang. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    var toolbar: Navbar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        setupToolbar()
    }
    
    func setupToolbar() {
        toolbar = Navbar(view: self.view)
        view.addSubview(toolbar!)
        view.backgroundColor = UIColor.white
    }
    
    func transitionToFeed() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let controller = FeedController()
        appDelegate.window!.rootViewController = controller
    }
    
    func transitionToNotification() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let controller = NotificationController()
        appDelegate.window!.rootViewController = controller
    }
    
    func transitionToProfile() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let controller = ProfileController()
        appDelegate.window!.rootViewController = controller
    }
    
    func transitionToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        
        let loginController: UINavigationController =
            storyboard.instantiateInitialViewController()
                as! UINavigationController;
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: .transitionCrossDissolve,
                          animations: {
                            appDelegate.window!.rootViewController = loginController
        }, completion: nil)
    }
}
