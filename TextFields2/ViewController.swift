//
//  ViewController.swift
//  TextFields2
//
//  Created by Azamat Igiman on 4/12/20.
//  Copyright © 2020 Azamat Igiman. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var secondtextfield: UITextField!
    var posy:CGFloat = 0.0
    var activeTextField = UITextField()
    var keyboardHeight:CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField.delegate = self
        secondtextfield.delegate = self
        
        let notificationCenter = NotificationCenter.default
           notificationCenter.addObserver(self, selector: #selector(adjustForKeyboardHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
           notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        posy = self.view.frame.origin.y
       
    }
  
    @objc func adjustForKeyboard(notification: Notification)
    {
//        let y = self.view.frame.origin.y
//        print ("hello from observer")
//        self.view.frame.origin.y = y - 200
        if let keyboardRectValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
             keyboardHeight = keyboardRectValue.height
        }
        
        
    }
    @objc func adjustForKeyboardHide(notification: Notification)
      {
//          print ("hello from observer")
//        self.view.frame.origin.y = self.posy
        
    }
    
     
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
        
        print (activeTextField)
        print ("begin editing")
        print (self.view.frame.height-keyboardHeight-20," ---  ",activeTextField.frame.origin.y)
        
        if ((self.view.frame.height-keyboardHeight)<(activeTextField.frame.origin.y)){
        UIView.animate(withDuration: 0.25, animations: {
               
                 self.view.frame.origin.y = self.view.frame.origin.y - 200
        })}
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.activeTextField = textField
        print (activeTextField)
        print ("finish editing")
        UIView.animate(withDuration: 0.25, animations: {
          self.view.frame.origin.y = self.posy
        })
        
    }
           
       
}


