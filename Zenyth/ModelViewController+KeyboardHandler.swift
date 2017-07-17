//
//  ModelViewController+KeyboardHandler.swift
//  Zenyth
//
//  Created by Hoang on 7/7/17.
//  Copyright © 2017 Hoang. All rights reserved.
//

import UIKit

extension ModelViewController {
    
    /* Hides keyboard when clicking outside of the keyboard
     */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                        action: #selector(ModelViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /* Dismisses keyboard, called by hideKeyboardWhenTappedAround
     */
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /* When keyboard is shown, pushes the screen up so none of the text fields
     * are hidden
     */
    func keyboardWillShow(notification:NSNotification) {
    
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]
                                as? NSValue)?.cgRectValue {
            scrollView.contentSize.height =
                            view.frame.height + keyboardSize.height
        }
        
    }
    
    /* Pulls the view back down when keyboard is hidden
     */
    func keyboardWillHide(notification:NSNotification) {
    
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]
                                as? NSValue)?.cgRectValue {
            scrollView.contentSize.height =
                            scrollView.contentSize.height - keyboardSize.height
        }
        
    }
}