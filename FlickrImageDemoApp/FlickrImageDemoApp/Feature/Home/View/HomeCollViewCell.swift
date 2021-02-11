//
//  HomeCollViewCell.swift
//  FlickrImageDemoApp
//


import UIKit

class HomeCollViewCell: UICollectionViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    func configureWith(photo: PhotosDetail) {
        lblTitle.text = photo.title
        guard let url = photo.imgUrl else {
            return
        }
        imgView.setImageWith(url: url , placeholder: UIImage(named: "placeholder"), imageIndicator: .gray, completion: nil)
    }
    
}
