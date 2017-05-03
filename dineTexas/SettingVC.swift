//
//  SettingViewController.swift
//  dineTexas
//
//  Created by Hyun Joong Kim on 3/20/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit
import CoreData
class SettingViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var greenInput: UITextField!
    @IBOutlet weak var orangeInput: UITextField!
    @IBOutlet weak var notifications: UISwitch!
    @IBOutlet weak var rememberLogin: UISwitch!
   
    
    var alertController:UIAlertController? = nil
    var settings = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        greenInput.delegate = self
        orangeInput.delegate = self
        loadData()
        print (settings.count)
        if ( settings.count >= 1 ) {
            let setting = settings[ settings.count - 1 ]
            let gSetting = setting.value(forKey: "greenSetting") as? Int
            let oSetting = setting.value(forKey: "orangeSetting") as? Int
            let gSettingString = String(describing: gSetting)
            let oSettingString = String(describing: oSetting)
            print(gSettingString)
            print(oSettingString)
            if (gSettingString != "" && oSettingString != ""){
                greenInput.text = String(gSetting!)
                orangeInput.text = String(oSetting!)
            }
            else {
                greenInput.text = "10"
                orangeInput.text = "20"
            }
            notifications.setOn((setting.value(forKey: "notifications") as? Bool)!, animated: false)
            rememberLogin.setOn((setting.value(forKey: "rememberLogin") as? Bool)!, animated: false)
        } else {
            greenInput.text = "10"
            orangeInput.text = "20"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateSettings(_ sender: Any) {
        if (greenInput.text != "" && orangeInput.text != ""){
            if (isStringAnInt(string: greenInput.text!) && isStringAnInt(string: orangeInput.text!)){
                if (Int(greenInput.text!)! < Int(orangeInput.text!)! ){
                saveSettings(notifications: notifications.isOn, rememberLogin: rememberLogin.isOn, greenInput: Int(greenInput.text!)!, orangeInput: Int(orangeInput.text!)!)
                    displayAlert("Your Settings have been updated")
                } else {
                displayAlert("The green amount must be smaller than the orange amount")
                }
            } else {
                displayAlert("You must enter a valid number")
            }
        }
        else {
            displayAlert("You must enter a valid number")
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    fileprivate func saveSettings(notifications: Bool, rememberLogin: Bool, greenInput: Int, orangeInput: Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "Settings", in: managedContext)
        
        let setting = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // Set the attribute values
        setting.setValue(greenInput, forKey: "greenSetting")
        setting.setValue(orangeInput, forKey: "orangeSetting")
        setting.setValue(notifications, forKey: "notifications")
        setting.setValue(rememberLogin, forKey: "rememberLogin")
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // Add the new entity to our array of managed objects
            settings.append(setting)
        
    }
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
    
    fileprivate func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Settings")
        
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            settings = results
        } else {
            print("Could not fetch")
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "Login")
    }
}
