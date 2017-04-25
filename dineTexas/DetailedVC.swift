//
//  DetailedViewController.swift
//  dineTexas
//
//  Created by Hyun Joong Kim on 3/20/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var location_array: Location!
    var index: Int!
    var locationArrayLength: Int!
    
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
        self.image.image = UIImage(named: "\(location_array.name).jpg")
        
        if ( favorites[index]) {
            self.favoriteStar.image = UIImage(named: "Star.png")
            favoriteButton.setTitle("Remove from Favorites", for: .normal)
            isFavorite = true
            print("is favorite")
        }
//        var i = 0;
//        while (i < (favorites?.count)!){
//            if(favorites?[i] == index){
//               self.favoriteStar.image = UIImage(named: "Star.jpeg")
//                favoriteButton.setTitle("Remove from Favorites", for: .normal)
//                isFavorite = true
//                print("is favorite")
//            }
//            i = i + 1
//        }
        
//        print (favorites ?? "")
        
        slider.setValue(Float(location_array.lineCount), animated: false)
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
        self.ratings.selectedSegmentIndex = location_array.averageRating - 1
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
