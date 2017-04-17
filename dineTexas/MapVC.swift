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
    let annotation = MKPointAnnotation()
//    var location_array = [Location]()
    var ref: FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation()
        self.mapView.delegate = self
        //need to iterate over the number of locations
        var index:Int?
        index = 0
        //firebase reference
        ref = FIRDatabase.database().reference()
        //retreive data and listen

        while (index! < 10){
            ref?.child("location").child("\(index!)").observeSingleEvent(of: .value, with: { (snapshot) in
                //code to execute when data is retrieved
                
                //convert data to NSDictionary
                let value = snapshot.value as? NSDictionary
                //if there are no error in the database retrieving
                if let actualValue = value{
                    let name = actualValue["name"] as? String
                    print (name!)
                    let address = actualValue["address"] as? String
                    let hours = actualValue["hours"] as? String
                    let type = actualValue["type"] as? String
                    let lineCount = actualValue["lineCount"] as? Int
                    let outlets = actualValue["outlets"] as? Int
                    let food = actualValue["food"] as? Int
                    let coffee = actualValue["coffee"] as? Int
                    let alcohol = actualValue["alcohol"] as? Int
                    let averageRating = actualValue["averageRating"] as? Int
                    let website = actualValue["website"] as? String
                    let lat = actualValue["latitude"] as? Double
                    let lon = actualValue["longitude"] as? Double
                    let loc = CLLocationCoordinate2DMake(lat!, lon!)
                    
                    // Drop a pin
                    let dropPin = MKPointAnnotation()
                    dropPin.coordinate = loc
                    dropPin.title = name
                    self.mapView.addAnnotation(dropPin)
                    
                    let instance = Location(key: index!, name: name!, address: address!, hours: hours!, type: type!, lineCount: lineCount!, outlets: outlets!, food: food!, coffee: coffee!, alcohol: alcohol!, averageRating: averageRating!, webSite: website!, lon:lon!, lat:lat!)
                    Locations.Constructs.Locations.location_array.append(instance)
//                    self.location_array.append(instance)
                    print(Locations.Constructs.Locations.location_array.count)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        index = index! + 1
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
    
    func centerMapOnLocation() {
//        TODO: Need to remove hard code, update with radius seting... 1609m in a mile
        let latitudeMeters = 1.0*1609.34
        let longitudeMeters = 1.0*1609.34
        
        // The first argument - location - is the centerpoint.
        // The second and third arguments indicate the distance in meters from that centerpoint to show.
        let centerLocation = CLLocation(latitude: 30.286218, longitude: -97.739388)
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(centerLocation.coordinate, latitudeMeters, longitudeMeters)
        
        // setRegion tells mapView to display the defined region
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "Identifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "cafe-green.png")
        }
        return annotationView
    }
}

extension MapViewController: MKMapViewDelegate {
    // This method returns a view for the drawing of the travel path.
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let lineView = MKPolylineRenderer(overlay: overlay)
        lineView.strokeColor = UIColor.green
        
        return lineView
    }
}
