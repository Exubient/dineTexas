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
import CoreData

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UITextField!
    var alertController:UIAlertController? = nil
    let locManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    var pointAnnotation:CustomPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    var settings = [NSManagedObject]()
    var ref: FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    var selectedIndex = 0
//    let defaults = UserDefaults.standard
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
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

                    let dropPin = CustomPointAnnotation()
                    dropPin.coordinate = loc
                    dropPin.title = name
                    dropPin.pinCustomImageName = self.customPinImage(type: type!, lineCount: lineCount!, index:Locations.Constructs.Locations.location_array.count)
                    dropPin.value = Locations.Constructs.Locations.location_array.count
                    print("***3: \(dropPin.value)")
                    self.pinAnnotationView = MKPinAnnotationView(annotation: dropPin, reuseIdentifier: "pin")
                    self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
                    let instance = Location(key: index!, name: name!, address: address!, hours: hours!, type: type!, lineCount: lineCount!, outlets: outlets!, food: food!, coffee: coffee!, alcohol: alcohol!, averageRating: averageRating!, webSite: website!, lon:lon!, lat:lat!)
                    Locations.Constructs.Locations.location_array.append(instance)
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
    
    override func viewWillAppear(_ animated: Bool) {
        //remove all the Annotations
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        loadData()
        
        for index in 0 ..< Locations.Constructs.Locations.location_array.count{
            // Drop pins
            let dropPin = CustomPointAnnotation()
            let loc = CLLocationCoordinate2DMake(Locations.Constructs.Locations.location_array[index].lat, Locations.Constructs.Locations.location_array[index].lon)
            dropPin.coordinate = loc
            dropPin.title = Locations.Constructs.Locations.location_array[index].name
            let type = Locations.Constructs.Locations.location_array[index].type
            let lineCount = Locations.Constructs.Locations.location_array[index].lineCount
            dropPin.pinCustomImageName = self.customPinImage(type: type, lineCount: lineCount, index:index)
            dropPin.value = index
            print("***1: \(dropPin.value)")
            self.pinAnnotationView = MKPinAnnotationView(annotation: dropPin, reuseIdentifier: "pin")
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
        }
    }
    
    func customPinImage(type: String, lineCount:Int, index:Int) -> String {
        var gSetting:Int?
        var oSetting:Int?
        if ( settings.count >= 1 ){
        let setting = settings[ settings.count - 1 ]
        gSetting = setting.value(forKey: "greenSetting") as? Int
        oSetting = setting.value(forKey: "orangeSetting") as? Int
        }
        if(gSetting == nil){
            gSetting = 10
            print("g Setting not initialized yet")
        }
        if(oSetting == nil){
            oSetting = 20
            print("o Setting not initialized yet")
        }
        var constructColor = "green"
        var constructType = "restaurant"
        if ( checkIfFavorites(index:index)){
            constructType = "favorite"
        }
        else if ( type == "cafe" ) {
            constructType = "cafe"
        } else if ( type == "restaurant" ) {
            constructType = "restaurant"
        }
        
        if (lineCount < gSetting!){
            constructColor = "green"
        } else if (lineCount < oSetting!) {
            constructColor = "orange"
        } else {
            constructColor = "red"
        }
        return "\(constructType)-\(constructColor).png"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn(_ sender: Any) {
        if self.searchBar.text == ""{
            print("check")
            for index in 0 ..< Locations.Constructs.Locations.location_array.count{
                let dropPin = CustomPointAnnotation()
                    let loc = CLLocationCoordinate2DMake(Locations.Constructs.Locations.location_array[index].lat, Locations.Constructs.Locations.location_array[index].lon)
                    dropPin.coordinate = loc
                    dropPin.title = Locations.Constructs.Locations.location_array[index].name
                let type = Locations.Constructs.Locations.location_array[index].type
                let lineCount = Locations.Constructs.Locations.location_array[index].lineCount
                dropPin.pinCustomImageName = self.customPinImage(type: type, lineCount: lineCount, index:index)
                dropPin.value = index
                print("***2: \(dropPin.value)")
                self.pinAnnotationView = MKPinAnnotationView(annotation: dropPin, reuseIdentifier: "pin")
                self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
            }
            return
        }
        
        for index in 0 ..< Locations.Constructs.Locations.location_array.count{
            if self.searchBar.text == Locations.Constructs.Locations.location_array[index].name{
                //remove all the Annotations
                let allAnnotations = self.mapView.annotations
                self.mapView.removeAnnotations(allAnnotations)
                
            }
        }
        
        for index in 0 ..< Locations.Constructs.Locations.location_array.count{
            if self.searchBar.text == Locations.Constructs.Locations.location_array[index].name{
                let dropPin = CustomPointAnnotation()
                let loc = CLLocationCoordinate2DMake(Locations.Constructs.Locations.location_array[index].lat, Locations.Constructs.Locations.location_array[index].lon)
                dropPin.coordinate = loc
                dropPin.title = Locations.Constructs.Locations.location_array[index].name
                let type = Locations.Constructs.Locations.location_array[index].type
                let lineCount = Locations.Constructs.Locations.location_array[index].lineCount
                dropPin.pinCustomImageName = self.customPinImage(type: type, lineCount: lineCount, index:index)
                
                self.pinAnnotationView = MKPinAnnotationView(annotation: dropPin, reuseIdentifier: "pin")
                self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
            }
        }
    }
    
    func checkIfFavorites(index:Int) -> Bool{
        print("Calling checkIfFavorites")
        let defaults = UserDefaults.standard
        var favorites = (defaults.array(forKey: "Favorites")) as? [Bool]
        if (favorites?.count == 0 ){
            favorites = [Bool]( repeating: false, count: 20 )
            defaults.set(favorites, forKey: "Favorites")
            defaults.synchronize()
        }
        return favorites![index]
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
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            let customPointAnnotation = annotation as! CustomPointAnnotation
            annotationView.image = UIImage(named: customPointAnnotation.pinCustomImageName)//"cafe-green.png")
            print(customPointAnnotation.value)
            let button = UIButton(type: .detailDisclosure)
            button.tag = customPointAnnotation.value
            button.addTarget(self, action: #selector(pressButton(button:)), for: .touchUpInside)
            annotationView.rightCalloutAccessoryView = button
        }
        return annotationView
    }
    func pressButton(button: UIButton) {
        
        selectedIndex = button.tag
        self.performSegue(withIdentifier: "detailSegue", sender: nil)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DetailedViewController {
            destinationViewController.location_array = Locations.Constructs.Locations.location_array[selectedIndex]
            destinationViewController.index = selectedIndex
            destinationViewController.locationArrayLength = Locations.Constructs.Locations.location_array.count
        }
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
