//
//  DetailedViewController.swift
//  dineTexas
//
//  Created by Hyun Joong Kim on 3/20/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    let locaton_array = MapViewController().location_array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.locaton_array[0])
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
