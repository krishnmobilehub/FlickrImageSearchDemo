//
//  Photos.swift
//  FlickrImageDemoApp
//


import Foundation

struct Photo {

    public var photos : [PhotosDetail]?
    public let page : Int?
    public let pages : Int?

    init(dict: [String:Any]) {
        page = dict["page"] as? Int ?? 0
        pages = dict["pages"] as? Int ?? 0
        if let arrPhoto = dict["photo"] as? [[String:Any]] {
            photos = arrPhoto.map{PhotosDetail.init(dict: $0)}
        } else {
            photos = nil
        }
    }

}

