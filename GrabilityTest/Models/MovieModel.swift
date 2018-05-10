//
//  MovieModel.swift
//  GrabilityTest
//
//  Created by Rhonny Gonzalez on 9/5/18.
//  Copyright © 2018 Rhonny Gonzalez. All rights reserved.
//

import Foundation

class Movie: Common {
    
    var title = ""
    var original_title = ""
    var release_date = ""
    var video = false
    var adult = false
    
    override init(){
        super.init()
    }
    
    override init?(data: NSDictionary){
        super.init(data: data)
        self.title = data["title"] as? String ?? ""
        self.original_title = data["original_title"] as? String ?? ""
        self.release_date = data["release_date"] as? String ?? ""
        self.video = data["video"] as? Bool ?? false
        self.adult = data["adult"] as? Bool ?? false
    }
    
}
