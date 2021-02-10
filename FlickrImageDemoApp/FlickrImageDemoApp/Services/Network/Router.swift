//
//  Router.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//
import Foundation
import Alamofire

enum Router: HTTPRouter {
    
    //GET
    case photoSearch

    var method: HttpMethod {
        switch self {
        case .photoSearch:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .photoSearch:
            return nil
        }
    }

    var encodingType: Encoding {
        switch self {
        case .photoSearch:
            return .json
        }
    }

}
