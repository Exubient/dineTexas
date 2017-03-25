//
//  AddLocationViewController.swift
//  dineTexas
//
//  Created by John Madden on 3/24/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController, UITextFieldDelegate {
    var alertController:UIAlertController? = nil
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var hours: UITextField!
    @IBOutlet weak var website: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        address.delegate = self
        hours.delegate = self
        website.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Submit(_ sender: Any) {
        displayAlert("This function will be implemented in the Beta release")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}