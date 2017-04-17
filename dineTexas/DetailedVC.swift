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
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var outlets: UISwitch!
    @IBOutlet weak var food: UISwitch!
    @IBOutlet weak var coffee: UISwitch!
    @IBOutlet weak var alcohol: UISwitch!
    @IBOutlet weak var wifi: UISwitch!
    @IBOutlet weak var ratings: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.image.image = UIImage(named: "\(location_array.name).jpg")
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
    }
    
}
