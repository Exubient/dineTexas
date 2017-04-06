//
//  MapViewController.swift
//  dineTexas
//
//  Created by John Madden on 2/28/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase
import FirebaseAuth
import Firebase


class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UITextField!
    var alertController:UIAlertController? = nil
    let locManager = CLLocationManager()
    
    var ref: FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //firebase reference
        ref = FIRDatabase.database().reference()
        
        //retreive data and listen
        ref?.child("location").child("location0").observeSingleEvent(of: .value, with: { (snapshot) in
            //code to execute when data is retrieved
            
            //convert data to NSDictionary
            let value = snapshot.value as? NSDictionary
            //if there are no error in the database retrieving
            if let actualValue = value{
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                let address = actualValue["address"] as? String
                print(address!)
                let name = actualValue["name"] as? String
                print(name!)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        searchBar.autocorrectionType = UITextAutocorrectionType.no
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.func_tap))
        self.view.addGestureRecognizer(tap)
    }
    
    func func_tap(gesture: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn(_ sender: Any) {
        displayAlert("This feature will be implemented in beta")
    }
    
    func displayAlert (_ message: String){
        self.alertController = UIAlertController(title: message, message: "", preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            print("Ok Button Pressed 1");
        }
        self.alertController!.addAction(OKAction)
        self.present(alertController!, animated: true, completion: nil)
    }
}
