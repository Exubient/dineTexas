//
//  DetailedViewController.swift
//  dineTexas
//
//  Created by Hyun Joong Kim on 3/20/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var locaton_array = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //need help on this part
        self.locaton_array = MapViewController().location_array
        print(self.locaton_array.count)
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
