//
//  UICollectionView+Extension.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//

import UIKit

public extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(_: T.Type, in bundle: Bundle? = nil) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentity)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentity, for: indexPath) as? T else {
            debugPrint("Could not dequeue cell with identifier: \(T.reuseIdentity)")
            return UICollectionViewCell() as! T
        }
        return cell
    }

}
