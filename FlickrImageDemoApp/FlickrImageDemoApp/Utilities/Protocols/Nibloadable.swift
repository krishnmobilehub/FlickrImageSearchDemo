//
//  Nibloadable.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//

import Foundation
import UIKit

public protocol NibLoadableView: class {
    static var nibName: String { get }
}

public extension NibLoadableView {
    static var nibName: String {
        return "\(self)"
    }
}
