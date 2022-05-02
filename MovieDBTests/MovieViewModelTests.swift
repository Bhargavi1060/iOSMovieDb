//
//  MovieViewModelTests.swift
//  MovieDBTests
//
//  Created by Bhargavi on 01/05/22.
//

import XCTest
@testable import MovieDB

class MovieViewModelTests: XCTestCase {
   
    var viewModel : MovieViewModel!
    
   
    override func setUp() {
        self.viewModel = MovieViewModel(dataService: DataService())
    }
    override func tearDown() {
        self.viewModel = nil
    }
    
    func testFetchWithNoService() {
        
        let expectation = XCTestExpectation(description: "No service Movie")
        
        viewModel.fetchmovie(withId: 0)
        
        viewModel.updateLoadingStatus = {

        }
        
        viewModel.showAlertClosure = {
            if self.viewModel.error != nil {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
        
    }
    func testFetchCurrencies() {
        
        let expectation = XCTestExpectation(description: "Movie fetch")
        
        // giving a service mocking Movie
        viewModel.fetchmovie(withId: 1)
        
        viewModel.showAlertClosure = {
            if self.viewModel.error != nil {
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            }
        }
        
        viewModel.didFinishFetch = {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testWithMovie(){
        self.viewModel.moviewList = Movie(page:1 , results: nil, totalPages: 20, totalResults: 20)
        XCTAssertTrue((self.viewModel.moviewList?.page)! >= 1)
    }

    func testExample() throws {
        self.viewModel.moviewList = Movie(page:0 , results: nil, totalPages: 0, totalResults: 0)
        XCTAssertTrue((self.viewModel.moviewList?.page)! < 1)
    }

   
}
