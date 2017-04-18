//
//  LoginVC.swift
//  dineTexas
//
//  Created by Hyun Joong Kim on 3/20/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var alertController:UIAlertController? = nil
    let defaults = UserDefaults.standard
    
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
        email.delegate = self
        password.delegate = self
    }
    
    //tap outside to remove keyboard
    func func_tap(gesture: UITapGestureRecognizer) {
        email.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if (email.text == "" || password.text == ""){
            displayAlert ("You must enter a value for all fields.")
        }
        else {
            // if valid email and password, sequeue to map
            FIRAuth.auth()?.signIn(withEmail: self.email.text!, password: self.password.text!, completion: { (user, error) in
                ///
            })
        }
        let user = FIRAuth.auth()?.currentUser
        if let user = user {
            defaults.set(email.text, forKey: "Email")
            defaults.set(password.text, forKey: "Password")
            defaults.set(true, forKey: "Login")
            defaults.set([], forKey: "Favorites")
            print ("performSegue to map")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "loginToMap", sender: nil)
            }
        }
        else {
            displayAlert("Invalid email or password. Try again.")
        }

        }
    
    func displayAlert (_ message: String){
        self.alertController = UIAlertController(title: message, message: "", preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            print("Ok Button Pressed 1");
        }
        self.alertController!.addAction(OKAction)
        self.present(alertController!, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
