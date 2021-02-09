//
//  AppError.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//

import Foundation

//NOTE: ADD CUSTOM APP LOCALISED ERRORS HERE

enum AppError: LocalisedErrors {
    
    case message(String)

    var errorDescription: String? {
        switch self {
        case .message(let message): return message
        }
    }
    
    var title: String {
        switch self {
        default:
            return ""
        }
    }
}
