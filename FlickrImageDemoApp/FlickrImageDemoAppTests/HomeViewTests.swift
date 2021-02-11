//
//  HomeViewTests.swift
//  FlickrImageDemoAppTests
//

import XCTest
@testable import FlickrImageDemoApp
class HomeViewTest: XCTestCase {
    
    var sut: HomePresenter!
    
    // MARK: - Test lifecycle
    override  func setUp() {
        super.setUp()
        sut = HomePresenter()
    }
    
    override  func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: - Tests
    func testFetchPhotos() {
        //Given
        let expect = expectation(description: "Wait for get photos from webservice")
        //When
        sut.loadImages { (errorDescription) in
            if errorDescription != nil {
                XCTFail(errorDescription!)
                return
            }
            expect.fulfill()
        }
        //Then
        self.wait(for: [expect], timeout: 10)
    }
}
