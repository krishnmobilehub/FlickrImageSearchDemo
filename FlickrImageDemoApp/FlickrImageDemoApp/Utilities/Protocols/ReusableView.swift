//
//  ReusableView.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//

import UIKit

public protocol ReusableView: class {
    static var reuseIdentity: String { get }
}

extension ReusableView where Self: UIView {
    public static var reuseIdentity: String {
        return "\(self)"
    }
}
