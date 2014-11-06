//
//  TreasuredWordUtils.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/5/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import Foundation

class TreasuredWordUtils {
    class func getLoginViewController() -> UIViewController {
//        var loginViewController = LoginViewController()
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var loginViewController = storyboard.instantiateInitialViewController() as LoginViewController
        loginViewController.fields = PFLogInFields.UsernameAndPassword
            | PFLogInFields.LogInButton
            | PFLogInFields.SignUpButton
            | PFLogInFields.PasswordForgotten
            | PFLogInFields.Facebook
//            | PFLogInFields.Twitter

        loginViewController.delegate = loginViewController

        loginViewController.facebookPermissions = [
            "email",
            "public_profile",
            "user_friends",
            //            "user_about_me",
            //            "user_relationships",
            //            "user_birthday",
            //            "user_location",
        ]

        return loginViewController
    }
}
