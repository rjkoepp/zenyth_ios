//
//  HomeDatasourceController.swift
//  Zenyth
//
//  Created by Hoang on 7/3/17.
//  Copyright © 2017 Hoang. All rights reserved.
//


import LBTAComponents
import Alamofire

class RegisterController: UIViewController {
    
    var gender:String? = nil
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var errorMessages: UITextView!
    
    @IBAction func maleButtonAction(_ sender: UIButton) {
        femaleButton.backgroundColor = .clear
        maleButton.backgroundColor = buttonBlue
        gender = "Male"
    }
    
    @IBAction func femaleButtonAction(_ sender: UIButton) {
        maleButton.backgroundColor = .clear
        femaleButton.backgroundColor = buttonBlue
        gender = "Female"
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        var parameters = [String:String]()
        parameters["first_name"] = firstName.text
        parameters["last_name"] = lastName.text
        parameters["email"] = email.text
        parameters["password"] = password.text
        parameters["password_confirmation"] = confirmPassword.text
        parameters["gender"] = gender
        let urlString = serverAddress + "register"
        let url = URL(string: urlString)
        Alamofire.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            response in
            
            if let JSON = response.result.value as? [String:[String]] {
                self.self.errorMessages.text = ""
                for value in JSON["errors"]! {
                    self.self.errorMessages.insertText(value + "\n")
                }
                self.self.errorMessages.isHidden = false
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView: UIImageView = {
            let imageView = UIImageView(frame: view.frame)
            imageView.image = background
            imageView.contentMode = .scaleAspectFill
            imageView.center = self.view.center
            imageView.clipsToBounds = true
            return imageView
        }()
        
        self.view.insertSubview(backgroundView, at: 0)
        setupViews()
        
    }
    
    func setupViews() {
        firstName.backgroundColor = .clear
        lastName.backgroundColor = .clear
        email.backgroundColor = .clear
        password.backgroundColor = .clear
        confirmPassword.backgroundColor = .clear
        
        firstName.layer.borderColor = twitterBlue.cgColor
        lastName.layer.borderColor = twitterBlue.cgColor
        email.layer.borderColor = twitterBlue.cgColor
        password.layer.borderColor = twitterBlue.cgColor
        confirmPassword.layer.borderColor = twitterBlue.cgColor
        
        maleButton.layer.borderWidth = 1
        maleButton.layer.cornerRadius = 5
        maleButton.layer.borderColor = twitterBlue.cgColor
        
        femaleButton.layer.borderWidth = 1
        femaleButton.layer.cornerRadius = 5
        femaleButton.layer.borderColor = twitterBlue.cgColor
        
        registerButton.backgroundColor = buttonBlue
        errorMessages.isHidden = true
        errorMessages.backgroundColor = .clear
        
        formatTextField(textField: firstName)
        formatTextField(textField: lastName)
        formatTextField(textField: email)
        formatTextField(textField: password)
        formatTextField(textField: confirmPassword)
    }
}
