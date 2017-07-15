//
//  RegisterController.swift
//  Zenyth
//
//  Created by Hoang on 7/14/17.
//  Copyright © 2017 Hoang. All rights reserved.
//

import UIKit

class RegisterController: ModelViewController, UINavigationControllerDelegate {
    
    var username: String?
    var email: String?
    var password: String?
    var confirmPassword: String?
    var gender: String?
    var dateOfBirth: String?
    
    let usernameTakenMessage = "is already taken!"
    let usernameAvailableMessage = "is available!"
    let emailTakenMessage = "Email is already taken!"
    let emailAvailableMessage = "Email is available!"
    let activityIndicatorChecking = "     Checking"
    let invalidEmailMessage = "This field must be an email"
    let usernameRules = "Username must be between 3 to 20 characters"
    let checkEmailMessage = "Please Check Your Email"
    let signupSuccessfulMessage = "Signup Successful"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
