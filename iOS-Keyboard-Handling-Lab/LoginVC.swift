//
//  LoginVC.swift
//  iOS-Keyboard-Handling-Lab
//
//  Created by Tsering Lama on 2/4/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var stackViewConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login.delegate = self
        password.delegate = self
    }
    
    private var isKeyboardThere = false
    
    private var originalState: NSLayoutConstraint!
    
    private func registerForKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterForKeyBoardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
        }
        print(keyboardFrame)
        moveKeyboardUp(height: keyboardFrame.size.height)
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        resetUI()
    }
    
    private func moveKeyboardUp(height: CGFloat) {
        if isKeyboardThere {return}
        originalState = stackViewConstraints
        isKeyboardThere = true
        stackViewConstraints.constant -= height
        
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func resetUI() {
        isKeyboardThere = false
        stackViewConstraints.constant -= originalState.constant
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
