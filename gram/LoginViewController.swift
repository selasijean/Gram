//
//  LoginViewController.swift
//  gram
//
//  Created by Jean Adedze on 6/20/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit
import Parse
import Foundation


extension UIImageView{
    
    func makeBlurImage(targetImageView:UIImageView?)
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        blurEffectView.frame = targetImageView!.bounds
        
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        targetImageView?.addSubview(blurEffectView)
    }
    
}


class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameBar: UIView!
    @IBOutlet weak var passwordBar: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    
    var passwordBarColor = UIColor()
    var usernameBarColor = UIColor()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let backgroundView = UIImageView(frame: view.bounds )//CGRectMake(0, 200, 300, 325))
        let backgroundImage:UIImage = UIImage(named: "background")!
        backgroundView.image = backgroundImage
        //backgroundView.makeBlurImage(backgroundView)
        self.view.insertSubview(backgroundView, atIndex: 0)
        
        usernameBarColor = usernameBar.backgroundColor!
        passwordBarColor = passwordBar.backgroundColor!
        signUpButton.enabled = false
        
  
//        self.view.addSubview(backgroundView)
//        self.view.sendSubviewToBack(backgroundView)
        
//        passwordField.addTarget(self, action: #selector(LoginViewController.passwordFieldChanged(_:)), forControlEvents: .EditingDidEnd)
//        
//        usernameField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), forControlEvents: .EditingDidEnd)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func tappedUserF(sender: AnyObject) {
//        print("tapped")
//        usernameBar.backgroundColor = UIColor.whiteColor()
//        passwordBar.backgroundColor = passwordBarColor
//    }

    @IBAction func tappedUserF(sender: AnyObject) {
        usernameBar.backgroundColor = UIColor.whiteColor()
        passwordBar.backgroundColor = passwordBarColor
    }
    @IBAction func tappedPassF(sender: AnyObject) {
        passwordBar.backgroundColor = UIColor.whiteColor()
        usernameBar.backgroundColor = usernameBarColor
    }
    
    @IBAction func tappedOut(sender: AnyObject) {
        print("outside")
        usernameBar.backgroundColor = usernameBarColor
        passwordBar.backgroundColor = passwordBarColor
        view.endEditing(true)
    }
    

    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) in
            if user != nil{
                print("You're logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
    }
    @IBAction func onSignUp(sender: AnyObject) {
        
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackgroundWithBlock { (success:Bool, error: NSError?) in
            if success{
                print("Yayy, created a user")
            self.performSegueWithIdentifier("loginSegue", sender: nil)
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func textFieldEditingChanged(sender: AnyObject) {
        NSLog("user typing")
        
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty {
            signUpButton.enabled = false
        } else {
            signUpButton.enabled = true
        }
    }
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
