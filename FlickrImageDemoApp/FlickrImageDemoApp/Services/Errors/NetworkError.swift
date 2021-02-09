//
//  NetworkError.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//

import Foundation

//NOTE: ADD NETWORK ERRORS AND LOCALIZED CODE HERE

enum NetworkError: LocalisedErrors {
    case networkError(code: Double?, message: String)
    case networkGenericError(code: Double?, message: String)
    case errorString(String)
    
     var errorDescription: String? {
        switch self {
        case .errorString(let errorMessage): return errorMessage
        case .networkError(_, let message): return message
        case .networkGenericError(_, let message): return message
        }
    }
    
    var info: (code: Double?, message: String) {
        switch self {
        case .errorString(let errorMessage): return (nil, errorMessage)
        case .networkError(let code, let message), .networkGenericError(code: let code, message: let message):
            return(code, message)
        }
    }
    
}
