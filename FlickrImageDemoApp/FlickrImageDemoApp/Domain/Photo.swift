//
//  Photos.swift
//  FlickrImageDemoApp
//


import Foundation

struct Photo {

    let photos : [PhotosDetail]?
    let page : Int?
    let pages : Int?
    let perpage : Int?

    init(dict: [String:Any]) {
        page = dict["page"] as? Int ?? 0
        pages = dict["pages"] as? Int ?? 0
        perpage = dict["perpage"] as? Int ?? 0
        if let arrPhoto = dict["photo"] as? [[String:Any]] {
            photos = arrPhoto.map{PhotosDetail.init(dict: $0)}
        } else {
            photos = nil
        }
    }

}

