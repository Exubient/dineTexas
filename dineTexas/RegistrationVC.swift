//
//  RegistrationViewController.swift
//  dineTexas
//
//  Created by John Madden on 3/20/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class RegistrationVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confPassword: UITextField!
    var alertController:UIAlertController? = nil
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //no auto-fill
        firstName.autocorrectionType = UITextAutocorrectionType.no
        lastName.autocorrectionType = UITextAutocorrectionType.no
        email.autocorrectionType = UITextAutocorrectionType.no
        password.autocorrectionType = UITextAutocorrectionType.no
        confPassword.autocorrectionType = UITextAutocorrectionType.no
        
        //add func_tap to viewDidLoad
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.func_tap))
        self.view.addGestureRecognizer(tap)
        
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        password.delegate = self
        confPassword.delegate = self
    }
    
    //tap outside to remove keyboard
    func func_tap(gesture: UITapGestureRecognizer) {
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        email.resignFirstResponder()
        password.resignFirstResponder()
        confPassword.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func createButtonHandler(_ sender: Any) {
        if (firstName.text == "" || lastName.text == "" || email.text == "" || password.text == "" ||
            confPassword.text == ""){
            displayAlert ("You must enter a value for all fields.")
        }
        else {
            if (password.text != confPassword.text){
                displayAlert ("Password and confirmed Password do not match. Try again")
            } else if ((password.text?.characters.count)! < 6){
                 displayAlert ("Password must be at least 6 characters")
            }
            else {
                savePerson(firstName:firstName.text!, lastName:lastName.text!, email:email.text!, password: password.text!)
                //Firebase Sign Up
                FIRAuth.auth()?.createUser(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                    // ...
                }
                displayAlert ("Account created!")
            }
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
    
    // Saves this person created to the core data. Much of this
    // code has been replicated from the code given in class, such as
    // the error checking for checking the managedContext.
    func savePerson(firstName: String, lastName: String, email: String, password: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "Account", in: managedContext)
        
        let account = NSManagedObject(entity: entity!, insertInto:managedContext)
        
        // Set the attribute values
        account.setValue(firstName, forKey: "firstName")
        account.setValue(lastName, forKey: "lastName")
        account.setValue(email, forKey: "email")
        account.setValue(password, forKey: "password")
        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
