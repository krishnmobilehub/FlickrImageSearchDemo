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
    case apartments

    var method: HttpMethod {
        switch self {
        case .apartments:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .apartments:
            return nil
        }
    }

    var encodingType: Encoding {
        switch self {
        case .apartments:
            return .json
        }
    }

}
