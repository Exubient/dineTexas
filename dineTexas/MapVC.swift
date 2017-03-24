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

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UITextField!
    let locManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
