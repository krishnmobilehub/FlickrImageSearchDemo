//
//  Constants.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//


import UIKit

class Constants {
    //MARK: - General Constant
    static let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let APIKey = "74a75008d964a37c2054b9a85d85819f"
    static let APISecretKey = "6144086fc93c1991"
    static let baseURL = "https://api.flickr.com/services/rest/"
}

//MARK: - Set Notification Observers
extension Notification.Name {
    static let networkStatusChange = Notification.Name("__networkStatusChangeNotification")
}
