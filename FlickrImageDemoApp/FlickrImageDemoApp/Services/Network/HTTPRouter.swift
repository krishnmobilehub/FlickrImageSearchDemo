//
//  HTTPRouter.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//
import Foundation
import Alamofire

enum Encoding {
    case json
    case url
}

enum HttpMethod : String {
    case get     = "GET"
}

protocol HTTPRouter {
    var baseURL: String { get }
    var method: HttpMethod { get }
    var parameters: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
    var encodingType: Encoding { get }
    var request: URLRequest { get }
    var endPoint: String{ get }
}

extension HTTPRouter {
    
    var baseURL: String {
        return API.baseURL
    }
    
    var url: URL {
        return URL(string: baseURL + endPoint)!
    }
    
    var endPoint: String {
        return EndPoints.SearchApi
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String]? {
        return nil
    }
    
    var encodingType: Encoding {
        return .json
    }
    
    var request: URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return urlRequest
    }
    
}
