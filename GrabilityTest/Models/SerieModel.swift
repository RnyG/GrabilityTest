//
//  SerieModel.swift
//  GrabilityTest
//
//  Created by Rhonny Gonzalez on 9/5/18.
//  Copyright © 2018 Rhonny Gonzalez. All rights reserved.
//

import Foundation

class Serie: Common{
    
    var name = ""
    var original_name = ""
    var first_air_date = ""
    var origin_country = ""
    
    override init() {
        super.init()
    }
    
    override init?(data: NSDictionary){
        super.init(data: data)
        self.name = data["name"] as? String ?? ""
        self.original_name = data["original_name"] as? String ?? ""
        self.first_air_date = data["first_air_date"] as? String ?? ""
        self.origin_country = data["origin_country"] as? String ?? ""
    }
    
}
