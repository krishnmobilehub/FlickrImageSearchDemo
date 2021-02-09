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
    static let baseURL = ""
}

//MARK: - Set Notification Observers
extension Notification.Name {
    static let networkStatusChange = Notification.Name("__networkStatusChangeNotification")
}
