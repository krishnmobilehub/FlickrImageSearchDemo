//
//  PhotoDetail.swift
//  FlickrImageDemoApp
//


import Foundation

public struct PhotosDetail {
    
    public let farm : Int?
    public let id : String?
    public let secret: String?
    public let server: String?
    public let title: String?
    public let imgUrl: URL?
    
    init(dict: [String:Any]) {
        farm = dict["farm"] as? Int
        id = dict["id"] as? String
        secret = dict["secret"] as? String
        server = dict["server"] as? String
        title = dict["title"] as? String
        let urlString = "http://farm\(farm ?? 0).static.flickr.com/\(server ?? "")/\(id ?? "")_\(secret ?? "").jpg"
        if let url = URL(string: urlString) { imgUrl = url } else { imgUrl = nil }
    }
    
}
