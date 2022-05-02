//
//  PhotoViewModel.swift
//  MovieDB
//
//  Created by Bhargavi on 27/04/22.
//

import Foundation
import UIKit

class MovieViewModel {
    
    // MARK: - Properties
    private var movie: Movie? {
        didSet {
            guard let p = movie else { return }
            self.setupText(with: p)
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
 
    var moviewList:Movie?
    
    private var dataService: DataService?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // MARK: - Network call
    func fetchmovie(withId id: Int) {
        self.dataService?.requestFetchMovie(with: id, completion: { (photo, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            self.error = nil
            self.isLoading = false
            self.movie = photo
        })
    }
    
    // MARK: - UI Logic
    private func setupText(with movie: Movie) {
        self.moviewList = movie
    }
    

    
}
