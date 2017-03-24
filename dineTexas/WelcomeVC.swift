//
//  WelcomeViewController.swift
//  dineTexas
//
//  Created by Hyun Joong Kim on 3/20/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "createSegue"{
            let nextScene = segue.destination as? RegistrationVC
//            navigationItem.title = nil
        }
        if segue.identifier == "loginSegue"{
            let nextScene = segue.destination as? LoginViewController
//            navigationItem.title = nil
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
