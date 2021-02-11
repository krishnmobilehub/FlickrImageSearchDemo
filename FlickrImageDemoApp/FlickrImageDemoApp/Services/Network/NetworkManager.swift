//
//  NetworkManager.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//

import Foundation
import Alamofire

public struct NetworkManager {
    
    static let networkUnavailableCode: Double = 1000
    static let networkGenericErrorCode: Double = 1009

    static func makeRequest(_ urlRequest: HTTPRouter, showLog: Bool = false, completion: @escaping (Result) -> ()) {
        
        AF.request(urlRequest.url,
                   method: HTTPMethod(rawValue: urlRequest.method.rawValue) ,
                          parameters: urlRequest.parameters,
                          encoding: urlRequest.encodingType == .json ? JSONEncoding.default : URLEncoding.queryString,
                          headers: urlRequest.headers).responseJSON { responseObject in
            switch responseObject.result {
            case .success(let value):
                if (showLog) {
                    print("URL: \(urlRequest.url)")
                    print("Response: \(value)")
                }
                if let error = error(fromResponseObject: responseObject) {
                    completion(.failure(error))
                } else {
                    completion(.success(value))
                }
            case .failure(let error):
                completion(.failure(generateError(from: error.underlyingError ?? error, with: responseObject)))
            }
        }
        
        // Decode data into specified datamodel
        func decodeResponse<T:Decodable>(dataToDeocde:Data,decodingType:T.Type) -> T? {
            do {
                let genericModel = try JSONDecoder().decode(decodingType, from: dataToDeocde)
                return genericModel
            } catch {
                return nil
            }
        }
    
    }

    
    static func error(fromResponseObject responseObject: AFDataResponse<Any>) -> Error? {
        if let statusCode = responseObject.response?.statusCode {
            switch statusCode {
            case 200: return nil
            default:
                if let result = try? responseObject.result.get() as? [String: Any],
                    let errorMessage = result["error"] as? String {
                    if let code = result["code"] as? Double {
                        return NetworkError.networkError(code: code, message: errorMessage)
                    } else {
                        return NetworkError.errorString(errorMessage)
                    }
                }
            }
        }
        return NetworkError.errorString("Network error")
    }
    
    //Request failure errors
    static func generateError(from error: Error, with responseObject: AFDataResponse<Any>) -> Error {
        if let statusCode = responseObject.response?.statusCode {
            if let data = responseObject.data, let jsonString = String(data: data, encoding: .utf8) {
                return NetworkError.networkError(code: Double(statusCode), message: jsonString)
            }
        } else {
            let code = (error as NSError).code
            switch code {
            case NSURLErrorNotConnectedToInternet, NSURLErrorCannotConnectToHost, NSURLErrorCannotFindHost, NSURLErrorTimedOut:
                return NetworkError.networkError(code: networkUnavailableCode, message: error.localizedDescription)
            default:
                return NetworkError.networkGenericError(code: networkGenericErrorCode, message: error.localizedDescription)
            }
        }
        return NetworkError.networkGenericError(code: networkGenericErrorCode, message: error.localizedDescription)
    }
}
