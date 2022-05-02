//
//  DataService.swift
//  MovieDB
//
//  Created by Bhargavi on 27/04/22.
//

import Foundation
import Alamofire

struct DataService {
    
    // MARK: - Singleton
    static let shared = DataService()
        
    
    // MARK: - Services
    func requestFetchMovie(with id: Int, completion: @escaping (Movie?, Error?) -> ()) {
        
        let url = "\(Api.movieList)/\(id)"
        Alamofire.request(url).responseMovie { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let result = response.result.value {
                completion(result, nil)
                return
            }
        }
    }
    
}
