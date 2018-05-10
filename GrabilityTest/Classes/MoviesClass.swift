//
//  MoviesClass.swift
//  GrabilityTest
//
//  Created by Rhonny Gonzalez on 9/5/18.
//  Copyright © 2018 Rhonny Gonzalez. All rights reserved.
//

import Foundation

protocol moviesDelegates{
    
    func successMoviesConnection(array: NSArray,request: String)
    func badMoviesConnection(message: String)
    
}

class MoviesClass: ConnectDelegate {
    
    var moviesDelegates: moviesDelegates?
    var makeConnection = ConnectionClass()
    
    func successConnect(Data:[String : Any]){
        
        if Data["Screen"] as Any is String{
            if let dict = Data["Result"] as? NSDictionary, let array = dict["results"] as? NSArray{
                if array.count > 0{
                    self.moviesDelegates?.successMoviesConnection(array: array,request:Data["Screen"] as! String)
                    return
                }else{
                    self.moviesDelegates?.badMoviesConnection(message: "No existen Datos")
                    return
                }
            }
        }
        self.moviesDelegates?.badMoviesConnection(message: "Ocurrió un problema, intenta de nuevo.")
    }
    
    func badConnect(Data:[String : Any]){
        if Data["Error"] != nil{
            let mess = Data["Error"] as! String
            print("error")
            return
        }
        print (Data["Result"] as Any)
    }
    
    
    func getMovies(url:String,screen: String){
        
        makeConnection.delegate = self
        
        makeConnection.create(Request: makeConnection.request1(bodyParams: [:], url: url, httpMeth: "GET", isFromUrl: false, headers: ["Content-Type":"application/json; charset=utf-8"], isObject: false),Screen:screen)
        
    }
    
}
