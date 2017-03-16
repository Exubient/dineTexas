//
//  LogonStatus.swift
//  dineTexas
//
//  Created by Davidson, Matthew on 3/16/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//  This Class will handle registartion information
//  Current Dependencies:
//  1. instantiated in LogoViewController.swift
//  2. isAuthenticated helps LogoViewController.swift determines if it should segue to
//  registartion or app.
//  3.
//

import UIKit

class LogonStatus: NSObject {
    fileprivate var isAuthenticated:Bool
    
    override init(){
//        THIS IS WHERE YOU CHECK TO SEE IF USER IS LOGGED IN
//        EITHER VIA FIREBASE OR CORE DATA
//        SET self.isAuthenticated to TRUE if authiticated, false otherwise
//        FOR NOW YOU CAN HARDCODE true/false to segue to registration or app
        self.isAuthenticated = true
    }
    
    func isAuthenticatedStatus() -> Bool {
        return self.isAuthenticated
    }
    
}
