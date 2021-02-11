//
//  HomePresenter.swift
//  FlickrImageDemoApp
//


import Foundation

class HomePresenter {
    
    //MARK: - Variables
    public var photo: Photo?
    private var currentPage = 1
    static let rowHeight = 36
    
    //MARK: - Webservice call
    func loadImages(completion: @escaping (String?) -> ()) {
        let request = Router.photoSearch
        NetworkManager.makeRequest(request, showLog: false, page: pageToLoad) { (result) in
            switch result {
            case .success(let value):
                guard let data = value as? [String:Any], let photo = data["photos"] as? [String: Any]  else {
                    completion("No data found")
                    return
                }
                if self.photo == nil {
                    self.photo = Photo(dict: photo)
                } else {
                    if let newPhotos = Photo(dict: photo).photos {
                        self.photo?.photos?.append(contentsOf: newPhotos)
                    }
                }
                completion(nil)
             case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Update history
    func updateSearchHistory() {
        if searchQuery == "" {
            return
        }
        let userDefaults = UserDefaults.standard
        if var history = userDefaults.value(forKey: UserDefaultKey.history) as? [String] {
            if !history.contains(searchQuery) {
                history.append(searchQuery)
                userDefaults.setValue(history, forKey: UserDefaultKey.history)
            }
        } else {
            userDefaults.setValue([searchQuery], forKey: UserDefaultKey.history)
        }
        userDefaults.synchronize()
    }
    
    func getSearchHistory() -> [String] {
        let userDefaults = UserDefaults.standard
        if let history = userDefaults.value(forKey: UserDefaultKey.history) as? [String] {
            return history.reversed()
        }
        return []
    }
    
    //MARK: - Pagination
    var pageToLoad: Int {
        guard let pages = photo?.pages else {
            return currentPage
        }
        let nextPage = currentPage + 1
        if pages <= nextPage {
            return currentPage
        }
        currentPage = nextPage
        return currentPage
    }
    
    func heightForTable(rowHeight: Int) -> Int {
        let searches = getSearchHistory().count
        let val = searches * rowHeight
        let maxHeight = 6 * rowHeight
        if val > maxHeight {
            return maxHeight
        }
        return val
    }
    
    func clearPhotos() {
        currentPage = 1
        photo = nil
    }
    
}

// MARK: - Datasource
extension HomePresenter {
    func numberOfItems() -> Int {
        return photo?.photos?.count ?? 0
    }
    
    func objectFor(indexPath: IndexPath) -> PhotosDetail? {
        guard let photodetail = photo?.photos else {
            return nil
        }
        if indexPath.row >= photodetail.count {
            return nil
        }
        return photodetail[indexPath.row]
    }
}
