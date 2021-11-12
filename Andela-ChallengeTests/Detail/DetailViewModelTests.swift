//
//  DetailViewModel.swift
//  Andela-ChallengeTests
//
//  Created by Renato Mateus on 11/11/21.
//

import XCTest
@testable import Andela_Challenge

class DetailViewModelTests: XCTestCase {

    typealias Completion<T> = ((_ value: T) -> Void)
    var viewModel: DetailViewModel!
    var successCompletion: Completion<Any>!
    var failureCompletion: Completion<Any>!
    lazy var serviceMockSuccess: DetailMovieServiceMockSuccess = DetailMovieServiceMockSuccess()
    lazy var serviceMockFailure: DetailMovieServiceMockFailure = DetailMovieServiceMockFailure()
    
    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }
    
    func testFetchIfSuccess() {
        viewModel = DetailViewModel(with: serviceMockSuccess)
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
        viewModel = DetailViewModel(with: serviceMockFailure)
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

extension DetailViewModelTests: DetailViewModelDelegate {
    func onSuccessFetchingDetail(movie: DetailMovie) {
        successCompletion(movie)
    }
    
    func onFailureFetchingDetail(error: Error) {
        failureCompletion(error)
    }
}
