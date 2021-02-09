//
//  LoacalizedError.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//
import Foundation

protocol LocalisedErrors: LocalizedError {
    var title: String { get }
    var localDescription: String { get } //useful in local parsing errors during debugging as their errorDescription would show generic message in the popup
}

extension LocalisedErrors {
    var title: String {
        return ""
    }
    var localDescription : String {
        return ""
    }
}



