//
//  Movie.swift
//  Flix
//
//  Created by Mihai Ruber on 2/27/18.
//  Copyright © 2018 Mihai Ruber. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var posterUrl: URL? 
    var releaseDate: String?
    var overview: String?
    var rating: String?
    var posterPath: String?
    var backDropPath: String?
    let baseURLString = "https://image.tmdb.org/t/p/w500"
    
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No description"
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
        rating = (String(describing: dictionary["vote_average"] as! NSNumber) + "/10 Rating") ?? "No rating"
        
        backDropPath = dictionary["backdrop_path"] as? String ?? ""
        posterPath = dictionary["poster_path"] as? String ?? ""
        
        //let backdropURL = URL(string: baseURLString + backDropPath!)
        posterUrl = URL(string: baseURLString + posterPath!)
        
        
        
        
    }
    
    
}
