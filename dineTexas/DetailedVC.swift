//
//  DetailedViewController.swift
//  dineTexas
//
//  Created by Hyun Joong Kim on 3/20/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase
import Foundation



class DetailedViewController: UIViewController {
    var location_array: Location!
    var index: Int!
    var locationArrayLength: Int!
    var alertController:UIAlertController? = nil
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var outlets: UISwitch!
    @IBOutlet weak var food: UISwitch!
    @IBOutlet weak var coffee: UISwitch!
    @IBOutlet weak var alcohol: UISwitch!
    @IBOutlet weak var wifi: UISwitch!
    @IBOutlet weak var favoriteStar: UIImageView!
    @IBOutlet weak var ratings: UISegmentedControl!
    @IBOutlet weak var favoriteButton: UIButton!
    var isFavorite = false
    var old: Int?
    var favorites:[Bool]!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        favorites = defaults.array(forKey: "Favorites")  as? [Bool] ?? [Bool]()
        print(favorites)
        if (favorites.count == 0 ){
            favorites = [Bool]( repeating: false, count: locationArrayLength )
             defaults.set(favorites, forKey: "Favorites")
            defaults.synchronize()
        }
        location_array = Locations.Constructs.Locations.location_array[index]
        old = location_array.current

        self.image.image = UIImage(named: "\(location_array.name).jpg")
        
        if ( favorites[index]) {
            self.favoriteStar.image = UIImage(named: "Star.png")
            favoriteButton.setTitle("Remove from Favorites", for: .normal)
            isFavorite = true
            print("is favorite")
        }
        
        slider.isUserInteractionEnabled = true
        slider.isContinuous = true


        slider.setValue(Float(location_array.lineCount), animated: false)
        print("********* \(Float(location_array.lineCount))")
        if (location_array.food == 1){
            food.setOn(true, animated: false)
        }
        else {
            food.setOn(false, animated: false)
        }
        
        if (location_array.outlets == 1){
            outlets.setOn(true, animated: false)
        }
        else {
            outlets.setOn(false, animated: false)
        }
        
        if (location_array.coffee == 1){
            coffee.setOn(true, animated: false)
        }
        else {
            coffee.setOn(false, animated: false)
        }
        
        if (location_array.alcohol == 1){
            alcohol.setOn(true, animated: false)
        }
        else {
            alcohol.setOn(false, animated: false)
        }
        self.ratings.selectedSegmentIndex = location_array.averageRating/location_array.nRates - 1
        
        self.title = location_array.name
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func save(_ sender: Any) {
        
        let email = FIRAuth.auth()?.currentUser?.email
        print(email!)
        
        let emailCheck = String(email!.characters.suffix(9))
        print(emailCheck)
        if (emailCheck == "gmail.com"){
            
        
            let date = NSDate()
            let calendar = NSCalendar.current
            let hour = calendar.component(.hour, from: date as Date)
            let minutes = calendar.component(.minute, from: date as Date)
            let current = minutes + hour*60
            let currentKey = String(index)
            print(currentKey)
            let ref = FIRDatabase.database().reference()
            ref.child("location").child(currentKey).updateChildValues(["current":current])
            print("current time in mins: ")
            print(current)
            print("time that was last updated: ")
            print(self.old!)
        
        
        //LineCount
            if (current - self.old! > 5){
                print(Int(slider.value))
                ref.child("location").child(currentKey).updateChildValues(["lineCount":Int(slider.value)])
                location_array.lineCount = Int(slider.value)
                print("case1")
            }
            else{
                print(slider.value)
                let newLinecount:Int = (Int(slider.value) + location_array.lineCount)/2
                ref.child("location").child(currentKey).updateChildValues(["lineCount":newLinecount])
                location_array.lineCount = newLinecount
                print("case2")
            }
        
            //averageRating
        
            let nRates:Int = location_array.nRates
            let AppRate = self.ratings.selectedSegmentIndex
            let currentRate = location_array.averageRating
            ref.child("location").child(currentKey).updateChildValues(["averageRating":(currentRate + AppRate)])
            ref.child("location").child(currentKey).updateChildValues(["nRates":nRates+1])


            
            currentRate + AppRate
            
        }
        else{
            displayAlert("you must be a UT student to rate/set line count")

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

    
    
    
    
    @IBAction func favoriteButton(_ sender: Any) {
        if (isFavorite){
            let defaults = UserDefaults.standard
            self.favoriteStar.image = nil
            favorites = defaults.array(forKey: "Favorites") as! [Bool]
            favorites[index] = false
            defaults.set(favorites, forKey: "Favorites")
//            favorites?.remove(at: index)
            favoriteButton.setTitle("Add to Favorites", for: .normal)
            isFavorite = false
            defaults.synchronize()
        }
        else {
            let defaults = UserDefaults.standard
            self.favoriteStar.image = UIImage(named: "Star.png")
            favorites = defaults.array(forKey: "Favorites") as! [Bool]
            favorites[index] = true
            defaults.set(favorites, forKey: "Favorites")
            isFavorite = true
            favoriteButton.setTitle("Remove from Favorites", for: .normal)
            defaults.synchronize()
        }
    }
}
