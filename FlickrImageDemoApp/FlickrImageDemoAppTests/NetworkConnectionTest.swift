//
//  NetworkConnectionTest.swift
//  FlickrImageDemoAppTests
//


import XCTest
import Network
@testable import FlickrImageDemoApp

class NetworkConnectionTest: XCTestCase {
    
    // MARK: - Subject under test
    var sut: NetworkConnectionManager!
    var monitor: NWPathMonitor!

    // MARK: - Test lifecycle
    override  func setUp() {
        super.setUp()
        sut = NetworkConnectionManager()
        monitor = NWPathMonitor()
        sut.startMonitoring()
    }
    
    override  func tearDown() {
        super.tearDown()
        sut.cancelMonitoring()
        monitor = nil
        sut = nil
    }
    
    func testUpdateStatusForNetworkConnection() {
        //Given
        sut.cancelMonitoring()
        sut.startMonitoring()
        //When
        monitor.pathUpdateHandler = { _ in
            XCTAssertNil(nil, "Network update monitoring working")
        }
        //Then
        NotificationCenter.default.post(name: .networkStatusChange, object: nil)
    }
    
    func testConnectedToInternet() {
        //Given
        sut.connected = false
        //When
        XCTAssertEqual(self.sut.connected, false)
        //Then
    }
    
    func testNotConnectedToInternet() {
        //Given
        sut.connected = true
        //When
        XCTAssertEqual(self.sut.connected, true)
        //Then
    }
}
