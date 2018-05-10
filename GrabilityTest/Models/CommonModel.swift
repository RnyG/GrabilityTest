//
//  CommonModel.swift
//  GrabilityTest
//
//  Created by Rhonny Gonzalez on 9/5/18.
//  Copyright © 2018 Rhonny Gonzalez. All rights reserved.
//

import Foundation

class Common{
    
    var id = -1
    var vote_count = 0
    var vote_average = 0.0
    var poster_path = ""
    var backdrop_path = ""
    var genre_ids: [Int] = []
    var overview = ""
    var popularity = 0.0
    var original_language = ""
    
    init(){
        
    }
    
    init?(data: NSDictionary){
        
        self.id = data["id"] as? Int ?? -1
        self.vote_count = data["vote_count"] as? Int ?? 0
        self.vote_average = data["vote_average"] as? Double ?? 0.0
        self.poster_path = data["poster_path"] as? String ?? ""
        self.backdrop_path = data["backdrop_path"] as? String ?? ""
        self.genre_ids = data["genre_ids"] as? [Int] ?? []
        self.overview = data["overview"] as? String ?? ""
        self.popularity = data["popularity"] as? Double ?? 0.0
        self.original_language = data["original_language"] as? String ?? ""
    }
    
}
