//
//  HomeViewController.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//


import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableHistoryView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    lazy var presenter = HomePresenter()
    
    //MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadImages(isNewPage: false)
    }
    
    func setupUI() {
        searchBar.text = searchQuery
        tableHistoryView.isHidden = true
        noDataLabel.isHidden = true
        tableHistoryView.tableFooterView = UIView()
        collectionView.registerCell(HomeCollViewCell.self)
        collectionView.reloadData()
        self.title = NavigationTitle.HomeViewTitle
    }
    
    func reloadImages(isNewPage: Bool) {
        LoadingView.show()
        if !isNewPage {
            presenter.clearPhotos()
            collectionView.scrollToTop()
        }
        presenter.loadImages() { (errorDescription) in
            if errorDescription == nil {
                if self.presenter.photo?.photos?.count == 0 {
                    self.noDataLabel.isHidden = false
                } else {
                    self.noDataLabel.isHidden = true
                }
                self.collectionView.reloadData()
            } else {
                self.showAlert(message: errorDescription!)
            }
            LoadingView.hide()
        }
    }
    
}

//MARK: - UICollection View Delegate/Datasource
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

//MARK: - UITableView View Delegate/Datasource
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
        return 36
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let history = presenter.getSearchHistory()
        searchQuery = history[indexPath.row]
        tableView.isHidden = true
        noDataLabel.isHidden = true
        searchBar.text = searchQuery
        reloadImages(isNewPage: false)
    }
    
}

//MARK: - UIScrollView View Delegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            self.view.endEditing(true)
        }
    }
}

//MARK: - UISearchBar Delegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchQuery = searchBar.text ?? ""
        presenter.updateSearchHistory()
        reloadImages(isNewPage: false)
        tableHistoryView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let tableHeight = presenter.heightForTable(rowHeight: HomePresenter.rowHeight)
        tableViewHeight.constant = CGFloat(tableHeight)
        tableHistoryView.isHidden = false
        tableHistoryView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableHistoryView.isHidden = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
}

//MARK: - Other protocols
extension HomeViewController: Alertable {
    func showAlert(message: String) {
        self.showAlert(title: appName, message: message)
    }
}
