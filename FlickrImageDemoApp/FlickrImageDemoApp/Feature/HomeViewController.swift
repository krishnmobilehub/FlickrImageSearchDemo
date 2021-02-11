//
//  HomeViewController.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//


import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var presenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadImages()
    }
    
    func reloadImages() {
        LoadingView.show()
        presenter.loadImages { (errorDescription) in
            if errorDescription == nil {
                self.collectionView.reloadData()
            } else {
                self.showAlert(message: errorDescription!)
            }
            LoadingView.hide()
        }
    }

    func setupUI() {
        collectionView.registerCell(HomeCollViewCell.self)
        collectionView.reloadData()
        self.title = ""
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photo?.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(HomeCollViewCell.self, for: indexPath)
        guard let photoDetail = presenter.objectFor(indexPath: indexPath) else {
            return cell
        }
        cell.configureWith(photo: photoDetail)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width / 2.3, height: self.view.frame.size.height/2.8)
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
}


extension HomeViewController: Alertable {
    func showAlert(message: String) {
        self.showAlert(title: appName, message: message)
    }
}
