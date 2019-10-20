//  ViewController.swift
//  Login App
//
//  Created by Sanusi Sheriff on 20/10/2019.
//  Copyright © 2019 Dev mikzy. All rights reserved.
//
import UIKit
import GoogleSignIn
import FacebookCore
import FacebookLogin

class ViewController: UIViewController,GIDSignInDelegate {

    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTf.customizeTextField(iconName: "Username")
        passwordTf.customizeTextField(iconName: "Password")

        GIDSignIn.sharedInstance().clientID = "940172268211-assdkj5k6g2sidm8dne2m1gok089ms6c.apps.googleusercontent.com"

        // Automatically sign in the user if signed in.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    // This is the methof used to customise the buttons
    override func viewWillAppear(_ animated: Bool) {
        //setGradientBackground()
        super.viewWillAppear(animated)
        
        loginBtn.customizeButtonWithRoundedCorners()
        googleBtn.customizeButtonWithRoundedCorners()
        facebookBtn.customizeButtonWithRoundedCorners()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if((GIDSignIn.sharedInstance()?.hasPreviousSignIn())!){
            navigateToDashboardPage()
        }else if (AccessToken.isCurrentAccessTokenActive){
            navigateToDashboardPage()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let idToken = user.authentication.idToken // Can send to the server/Keep
        navigateToDashboardPage()
    }
    
    //facebook login
    @IBAction func fbLoginBtnClicked(_ sender: Any) {
        LoginManager().logIn(permissions: ["email", "public_profile"], from: self) { result, error in
            
            // If an error occured return from the block
            if error != nil {
                print(error ?? "Facebook authentication failed")
                return
            }
            
            //Login successful
            self.navigateToDashboardPage()
        }
    }
    
    //Google SDK for login authentication
    @IBAction func googleSignInClicked(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 237.0/255.0, green: 127.0/255.0, blue: 106.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 233.0/255.0, green: 81.0/255.0, blue: 98.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.contentView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    // This is the method to move to a new Page using segue
    func navigateToDashboardPage(){
        performSegue(withIdentifier: "gotoDashboard", sender: nil)
    }
}

