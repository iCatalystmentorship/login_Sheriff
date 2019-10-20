//
//  DashboardViewController.swift
//  Login App
//
//  Created by Sanusi Sheriff on 20/10/2019.
//  Copyright © 2019 Dev mikzy. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import GoogleSignIn


class DashboardViewController: UIViewController {

    override func viewDidLoad() {
    
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
     @IBAction func logoutBtnClicked(_ sender: Any) {
        if((GIDSignIn.sharedInstance()?.hasPreviousSignIn())!){
             GIDSignIn.sharedInstance().signOut()
        }else{
              LoginManager().logOut()
        }
        navigateToLoginPage()
     }
    
    func navigateToLoginPage()  {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVc") as? ViewController{
            present(vc, animated: true, completion: nil)
        }
    }

}
