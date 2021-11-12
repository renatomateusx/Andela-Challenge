//
//  Andela_ChallengeTests.swift
//  Andela-ChallengeTests
//
//  Created by Renato Mateus on 11/11/21.
//

import XCTest

@testable import Andela_Challenge

class HomeViewModelTests: XCTestCase {

    typealias Completion<T> = ((_ value: T) -> Void)
    var viewModel: HomeViewModel!
    var successCompletion: Completion<Any>!
    var failureCompletion: Completion<Any>!
    lazy var serviceMockSuccess: PopularMoviesServiceMockSuccess = PopularMoviesServiceMockSuccess()
    lazy var serviceMockFailure: PopularMoviesServiceMockFailure = PopularMoviesServiceMockFailure()
    
    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }
    
    func testFetchIfSuccess() {
        viewModel = HomeViewModel(with: serviceMockSuccess)
        viewModel?.delegate = self
        let expectation = XCTestExpectation.init(description: "Digio Data")
        self.successCompletion = { posts in
            XCTAssertNotNil(posts, "No data was downloaded.")
            expectation.fulfill()
        }
        viewModel.fetchData(1)
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testFetchPostsIfFailure() {
        viewModel = HomeViewModel(with: serviceMockFailure)
        viewModel.delegate = self
        let expectation = XCTestExpectation.init(description: "Error")
        self.failureCompletion = { error in
            XCTAssertNotNil(error, "No data was downloaded.")
            expectation.fulfill()
        }
        viewModel.fetchData(1)
        wait(for: [expectation], timeout: 60.0)
    }
}

extension HomeViewModelTests: HomeViewModelDelegate {
    func onSuccessFetchingMovies(movies: DataMovie) {
        successCompletion(movies)
    }
    
    func onFailureFetchingMovies(error: Error) {
        failureCompletion(error)
    }
}
