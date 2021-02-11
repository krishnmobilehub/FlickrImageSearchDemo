//
//  PhotoDetail.swift
//  FlickrImageDemoApp
//


import Foundation

public struct PhotosDetail {
    
    let farm : Int?
    let id : String?
    let isfamily : String?
    let isfriend: String?
    let ispublic: String?
    let owner: String?
    let secret: String?
    let server: String?
    let title: String?
    let imgUrl: URL?
    
    init(dict: [String:Any]) {
        farm = dict["farm"] as? Int
        id = dict["id"] as? String
        isfamily = dict["isfamily"] as? String
        isfriend = dict["isfriend"] as? String
        ispublic = dict["ispublic"] as? String
        owner = dict["owner"] as? String
        secret = dict["secret"] as? String
        server = dict["server"] as? String
        title = dict["title"] as? String
        let urlString = "http://farm\(farm ?? 0).static.flickr.com/\(server ?? "")/\(id ?? "")_\(secret ?? "").jpg"
        if let url = URL(string: urlString) { imgUrl = url } else { imgUrl = nil }
    }
    
}
