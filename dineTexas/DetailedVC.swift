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
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var outlets: UISwitch!
    @IBOutlet weak var food: UISwitch!
    @IBOutlet weak var coffee: UISwitch!
    @IBOutlet weak var alcohol: UISwitch!
    @IBOutlet weak var wifi: UISwitch!
    @IBOutlet weak var favoriteStar: UIImageView!
    @IBOutlet weak var ratings: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var favorites = (defaults.array(forKey: "Favorites")) as? [Int]
        if (favorites == nil){
            defaults.set([], forKey: "Favorites")
            favorites = []
        }
        
        self.image.image = UIImage(named: "\(location_array.name).jpg")
        var i = 0;
        while (i < (favorites?.count)!){
            if(favorites?[i] == index){
               self.favoriteStar.image = UIImage(named: "Star.jpeg")
            }
            i = i + 1
        }
        
        
        
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
        
        ratings.selectedSegmentIndex = location_array.averageRating
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func favoriteButton(_ sender: Any) {
        self.favoriteStar.image = UIImage(named: "Star.jpeg")
        var favorites = defaults.array(forKey: "Favorites")
        favorites?.append(index)
        defaults.set(favorites, forKey: "Favorites")
        
    }
    
}
