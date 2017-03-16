//
//  ViewController.swift
//  dineTexas
//
//  Created by Hyun Joong Kim on 2/27/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit

class LogoViewController: UIViewController {
    var LogonStatusInstance:LogonStatus = LogonStatus()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isLoggedIn = LogonStatusInstance.isAuthenticatedStatus()
//        Sleep for 2 sec to show logo
        sleep(2)
        if (isLoggedIn) {
            print ("performSegue")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "logoToApp", sender: nil)
            }
        }
        else {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "logoToRegistration", sender: nil)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

