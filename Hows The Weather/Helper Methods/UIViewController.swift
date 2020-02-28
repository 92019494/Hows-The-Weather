//
//  UIViewController.swift
//  Traveller
//
//  Created by Anthony on 26/09/19.
//  Copyright © 2019 EmeraldApps. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    // MARK: - Keyboard Observers
    func addKeyboardObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObservers(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // MARK: - Hide Keyboard
    func hideKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - Nav Bar
    func setNavBarTitle(title: String){
        self.navigationController?.navigationBar.topItem?.title = title
    }

    @objc func popView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Nav Buttons
    func setUpRightBarButtons(){
        if navigationItem.rightBarButtonItem != nil {
            for item in navigationItem.rightBarButtonItems! {
                item.setTitleTextAttributes([.font : UIFont(name: "Futura-Bold", size: 17) as Any], for: .normal)
                item.tintColor = Constants.titleColor
            }
        }
//        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font : UIFont(name: "Futura-Bold", size: 17) as Any], for: .normal)
//        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "AppPrimary")
    }
    
    func setUpNavBackButton(){
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icon-back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icon-back")
        navigationController?.navigationBar.tintColor = UIColor(named: "TitleGrey")
    }
    
    func setUpBackButton(){
        navigationItem.hidesBackButton = true
        let back = UIButton(type: .custom)
        back.setImage(UIImage(named: "icon-back"), for: .normal)
        back.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        back.addTarget(self, action: #selector(popView), for: .touchUpInside)
        let backButton = UIBarButtonItem(customView: back)
        navigationItem.setLeftBarButton(backButton, animated: true)
    }
    
    
    func hideBackButton(){
        navigationItem.hidesBackButton = true
    }
}
