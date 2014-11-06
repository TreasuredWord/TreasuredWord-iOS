//
//  LoginViewController.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/3/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleLoginWithFacebook(sender: AnyObject) {
        // Set permissions required from the facebook user account
        var permissions = [
            "email",
            "public_profile",
            "user_friends",
//            "user_about_me",
//            "user_relationships",
//            "user_birthday",
//            "user_location",
        ]

        // Login PFUser using Facebook
        PFFacebookUtils.logInWithPermissions(permissions, block: {
            (user: PFUser!, error: NSError?) -> Void in
//            _activityIndicator.stopAnimating()
            if user == nil {
                var errorMessage: String? = nil
                if (error != nil) {
                    NSLog("Uh oh. The user cancelled the Facebook login.")
                    errorMessage = "Uh oh. The user cancelled the Facebook login."
                } else {
                    NSLog("Uh oh. An error occurred: \(error)")
                    errorMessage = error?.localizedDescription
                }
                var alert: UIAlertView = UIAlertView(
                    title: "Log In Error",
                    message: errorMessage,
                    delegate: nil,
                    cancelButtonTitle: "Dismiss"
                )
                alert.show()
            } else {
                if user.isNew {
                    NSLog("User signed up and logged in through Facebook!")
                } else {
                    NSLog("User logged in through Facebook!")
                }
                self.performSegueWithIdentifier("loggedInSegue", sender: self)
            }
        })
//        _activityIndicator.startAnimating() // Show loading indicator until login is finished
    }

    func acquireFBPermissions() {
//        PFFacebookUtils.reauthorizeUser(PFUser.currentUser(), withPublishPermissions:["publish_actions"],
//            audience:FBSessionDefaultAudienceFriends, {
//                (succeeded: Bool!, error: NSError!) -> Void in
//                if succeeded {
//                    // Your app now has publishing permissions for the user
//                }
//        })
    }

//        @IBAction func onSignUp(sender: AnyObject) {
//        var user = PFUser()
//        var email = self.emailField.text
//        var username = email
//        var password = self.passwordField.text
//        user.username = username
//        user.password = password
//        user.email = email
//        // other fields can be set just like with PFObject
//        //        user["phone"] = "415-555-1212"

//        user.signUpInBackgroundWithBlock {
//            (succeeded: Bool!, error: NSError!) -> Void in
//            if error == nil {
//                // Hooray! Let them use the app now.
//                println("Successfully signed up")
//                self.performSegueWithIdentifier("loggedInSegue", sender: self)
//            } else {
//                let errorString = error.userInfo?["error"] as? NSString
//                // Show the errorString somewhere and let the user try again.
//            }
//        }
//    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        var email = self.emailField.text
        var username = email
        var password = self.passwordField.text
        PFUser.logInWithUsernameInBackground(username, password:password) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                println("successfully signed in")
                self.performSegueWithIdentifier("loggedInSegue", sender: self)
            } else {
                // The login failed. Check error to see why.
            }
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
