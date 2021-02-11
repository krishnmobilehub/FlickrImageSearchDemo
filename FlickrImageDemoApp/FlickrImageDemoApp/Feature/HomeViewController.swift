//
//  HomeViewController.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//


import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lblNodataFound: UILabel!
    @IBOutlet weak var tableViewHistory: UITableView!
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
        reloadImages(isNewPage: false)
    }
    
    func reloadImages(isNewPage: Bool) {
        LoadingView.show()
        if !isNewPage {
            presenter.currentPage = 1
            presenter.photo = nil
            collectionView.scrollToTop()
        }
        presenter.loadImages() { (errorDescription) in
            if errorDescription == nil {
                if self.presenter.photo?.photos?.count == 0 {
                    self.lblNodataFound.isHidden = false
                } else {
                    self.lblNodataFound.isHidden = true
                }
                self.collectionView.reloadData()
            } else {
                self.showAlert(message: errorDescription!)
            }
            LoadingView.hide()
        }
    }

    func setupUI() {
        searchBar.text = searchQuery
        tableViewHistory.isHidden = true
        lblNodataFound.isHidden = true
        collectionView.registerCell(HomeCollViewCell.self)
        collectionView.reloadData()
        self.title = NavigationTitle.HomeViewTitle
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
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
        return CGSize(width: self.view.frame.size.width / 2.3, height: self.view.frame.size.height/3.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == presenter.numberOfItems() - 10 {
            reloadImages(isNewPage: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let history = presenter.getSearchHistory()
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier.History) else { return UITableViewCell() }
        let history = presenter.getSearchHistory()
        cell.textLabel?.text = history[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let history = presenter.getSearchHistory()
        searchQuery = history[indexPath.row]
        tableView.isHidden = true
        lblNodataFound.isHidden = true
        searchBar.text = searchQuery
        reloadImages(isNewPage: false)
    }
    
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            self.view.endEditing(true)
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchQuery = searchBar.text ?? ""
        presenter.updateSearchHistory()
        reloadImages(isNewPage: false)
        tableViewHistory.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableViewHistory.isHidden = false
        tableViewHistory.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableViewHistory.isHidden = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
}


extension HomeViewController: Alertable {
    func showAlert(message: String) {
        self.showAlert(title: appName, message: message)
    }
}
