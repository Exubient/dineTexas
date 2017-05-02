//
//  Location.swift
//  dineTexas
//
//  Created by Hyun Joong Kim on 4/5/17.
//  Copyright © 2017 Hyun Joong Kim. All rights reserved.
//

import Foundation

class Location {

    var key:Int
    var name:String
    var address:String
    var hours:String
    var type:String
    var lineCount:Int
    var outlets:Int
    var food:Int
    var coffee:Int
    var alcohol:Int
    var averageRating:Int
    var webSite:String
    var lon:Double
    var lat:Double
    var current:Int
    
    init (key:Int, name:String, address:String, hours:String, type:String, lineCount:Int, outlets:Int, food:Int, coffee:Int, alcohol:Int, averageRating:Int, webSite:String, lon:Double, lat:Double, current:Int
        ){
        self.key = key
        self.name = name
        self.address = address
        self.hours = hours
        self.type = type
        self.current = current
        self.lineCount = lineCount
        self.outlets = outlets
        self.food = food
        self.coffee = coffee
        self.alcohol = alcohol
        self.averageRating = averageRating
        self.webSite = webSite
        self.lon = lon
        self.lat = lat
        
    }
}
