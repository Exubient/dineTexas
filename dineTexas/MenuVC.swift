//
//  MenuViewController.swift
//  dineTexas
//
//  Created by Hyun Joong Kim on 3/20/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    var websiteURL: String!
    @IBOutlet weak var website: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print ("\(websiteURL)")
        let url = NSURL (string: websiteURL)
        let requestObj = URLRequest(url: url! as URL)
        website.loadRequest(requestObj)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
