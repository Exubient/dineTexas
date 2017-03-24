//
//  LoginVC.swift
//  dineTexas
//
//  Created by Hyun Joong Kim on 3/20/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "forgotPassword"{
            let nextScene = segue.destination as? ForgotPasswordViewController
            //            navigationItem.title = nil
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        email.autocorrectionType = UITextAutocorrectionType.no
        password.autocorrectionType = UITextAutocorrectionType.no
        
        //add func_tap to viewDidLoad
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.func_tap))
        self.view.addGestureRecognizer(tap)
    }
    
    //tap outside to remove keyboard
    func func_tap(gesture: UITapGestureRecognizer) {
        email.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
