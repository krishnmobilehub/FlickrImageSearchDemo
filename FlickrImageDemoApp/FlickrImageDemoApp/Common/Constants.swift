//
//  Constants.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//


import UIKit

//MARK: - General Constant
let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
let appDelegate = UIApplication.shared.delegate as! AppDelegate
//Initial key word for search news
var searchQuery = "kitten"

//MARK: - API Components
struct API {
    static let Key = "74a75008d964a37c2054b9a85d85819f"
    static let SecretKey = "6144086fc93c1991"
    static let baseURL = "https://api.flickr.com/services/rest/"
}

//MARK: - User Defaults keys
struct UserDefaultKey {
    static let history = "search_history"
}

//MARK: - CollectionViewCell Identifiers
struct CollCellIdentifier {
    static let PhotoList = "HomeCollectionCell"
}

//MARK: - TableViewCell Identifiers
struct TableCellIdentifier {
    static let History = "HistoryTableCell"
}

//MARK: - Set Notification Observers
extension Notification.Name {
    static let networkStatusChange = Notification.Name("__networkStatusChangeNotification")
}
