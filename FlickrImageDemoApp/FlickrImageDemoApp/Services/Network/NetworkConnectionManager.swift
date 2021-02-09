//
//  NetworkConnectionManager.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//

import Foundation
import Network

class NetworkConnectionManager {

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    var connected = false
    static let shared = NetworkConnectionManager()
    
    var isNetworkAvailable: Bool {
        return connected
    }
    
    private func updateStatus() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.connected = true
                print("We're connected!")
            } else {
                self?.connected = false
                print("No connection.")
            }
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .networkStatusChange, object: nil)
            }
        }
    }
    
    func cancelMonitoring() {
        monitor.cancel()
    }
    
    func startMonitoring() {
        if monitor.queue == nil {
            monitor.start(queue: queue)
        }
        updateStatus()
    }
    
}
