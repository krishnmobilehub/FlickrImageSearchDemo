//
//  NetworkManagerTest.swift
//  FlickrImageDemoAppTests
//

import XCTest
import Alamofire
@testable import FlickrImageDemoApp

class NetworkManagerTest: XCTestCase {

    // MARK: - Subject under test
    var sut: NetworkManager!
    
    // MARK: - Test lifecycle
    override  func setUp() {
        super.setUp()
        sut = NetworkManager()
    }
    
    override  func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_NetworkManager_WhenFailedToCreateEndPoint_ShouldReturnError() {
        
        //Given
        let expection = self.expectation(description: "Load images successfully")
        let urlRequest = Router.photoSearch
        let page = 1
        searchQuery = "kitten"
        
        //When
        let urlReq = NetworkManager.insertSearchQueryAndPage(url: urlRequest.url, page: page)
        
        AF.request(urlReq,
                   method: HTTPMethod(rawValue: urlRequest.method.rawValue) ,
                          parameters: urlRequest.parameters,
                          encoding: urlRequest.encodingType == .json ? JSONEncoding.default : URLEncoding.queryString,
                          headers: urlRequest.headers).responseJSON { responseObject in
            switch responseObject.result {
            case .success( _):
                expection.fulfill()
                break
            case .failure(let error):
                XCTFail("Failed to retrive data from server side with error: \(error.localizedDescription)")
                break
            }
        }
        
        //Then
        self.wait(for: [expection], timeout: 10)
    }
    
    func test_NetworkManager_WhenFailedToCreateUrl_ShouldReturnError() {
        //Given
        let urlRequest = Router.photoSearch
        let expection = self.expectation(description: "Host invalid exception")
        let wrongURL = URL.init(string: "ws.audioscrobbler.com")
        //When
        AF.request(wrongURL!,
                   method: HTTPMethod(rawValue: urlRequest.method.rawValue) ,
                   parameters: urlRequest.parameters,
                   encoding: urlRequest.encodingType == .json ? JSONEncoding.default : URLEncoding.queryString,
                   headers: urlRequest.headers).responseJSON { responseObject in
                    if responseObject.error != nil {
                        XCTAssert(true, "Host should match with api.flickr.com")
                        expection.fulfill()
                    }
                   }
        //Then
        self.wait(for: [expection], timeout: 10)
    }
    
}


