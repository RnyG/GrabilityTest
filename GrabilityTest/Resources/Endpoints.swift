//
//  Endpoints.swift
//  GrabilityTest
//
//  Created by Rhonny Gonzalez on 9/5/18.
//  Copyright © 2018 Rhonny Gonzalez. All rights reserved.
//

import Foundation


protocol IsUrlEndpoint{
    var url:String{get}
    var baseUrl:String{get}
    var options:String{get}
    var apikey:String{get}
}

extension IsUrlEndpoint{
   
    var baseUrl:String{
        return "https://api.themoviedb.org/3"
    }
    
    var options:String{
        return "?api_key=%@&language=%@"
    }
    
    var apikey:String{
        return "beeb60b8e4df310d5161674889594fba"
    }
}

enum types:Int,CustomStringConvertible{
    
    case movie = 0
    case serie
    
    var description: String{
        var str = ""
        switch self {
        case .movie:
            str = "/movie"
        case .serie:
            str = "/tv"
        }
        return str
    }
}

enum endpoints: IsUrlEndpoint{
    
    case popular(types)
    
    case topRated(types)
    
    case upcoming(types)
    
    init?(_ n: Int, type: types){
        switch n {
        case 0:
            self = .popular(type)
        case 1:
            self = .topRated(type)
        case 2:
            self = .upcoming(type)
        default:
            return nil
        }
    }
    
    var url:String{
        
        var request = ""
        let locale = Locale.current.languageCode ?? "en"
        
        switch self {
            
        case .popular(let t):
            
            request = "\(t)/popular"
        case .topRated(let t):
            request = "\(t)/top_rated"
        case .upcoming(let t):
            if t == .serie{
                request = "\(t)/airing_today"
            }else{
                request = "\(t)/upcoming"
            }
        }
        return (baseUrl + request + String.localizedStringWithFormat(options, apikey, locale))
    }
}
