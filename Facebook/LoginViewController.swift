//
//  LoginViewController.swift
//  Facebook
//
//  Created by Cemre Güngör on 10/27/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonView: UIButton!

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activityIndicatorView.hidden = true
        buttonView.enabled = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var alertView: UIAlertView!
    
    @IBAction func outsideOnTap(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.formView.frame.origin.y = 247
        })
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func textFieldEditingDidBegin(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.formView.frame.origin.y = 35
        })
        
    }
    
    @IBAction func textFieldEditingChanged(sender: AnyObject) {
        if (emailTextField.text.isEmpty && passwordTextField.text.isEmpty) {
            buttonView.enabled = false
        } else {
            buttonView.enabled = true
        }
    }
    
    @IBAction func signInButtonTouchUp(sender: AnyObject) {
        if (emailTextField.text.isEmpty) {
            alertView = UIAlertView(title: "Email required", message: "Please enter an email address", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        } else if (passwordTextField.text.isEmpty) {
            alertView = UIAlertView(title: "Password required", message: "Please enter your password", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        } else {
            buttonView.setBackgroundImage(UIImage(named: "logging_in_button.png"), forState: UIControlState.Normal)
            activityIndicatorView.hidden = false
            activityIndicatorView.startAnimating()
            delay(2) {
                self.checkPassword()
            }
        }
    }
    
    func checkPassword() {
        activityIndicatorView.hidden = true
         buttonView.setBackgroundImage(UIImage(named: "login_button_enabled.png"), forState: UIControlState.Normal)
        
        if (emailTextField.text.lowercaseString == "tim@thecodepath.com" && passwordTextField.text.lowercaseString == "swiftisfun") {
            performSegueWithIdentifier("signedInSegue", sender: self)
        } else {
            alertView = UIAlertView(title: nil, message: "Username or password is incorrect", delegate: self, cancelButtonTitle: "OK")
            alertView.show()

        }
    }


}
