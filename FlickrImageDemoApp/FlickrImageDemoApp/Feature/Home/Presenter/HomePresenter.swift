//
//  HomePresenter.swift
//  FlickrImageDemoApp
//


import Foundation

class HomePresenter {
    
    var photo: Photo?
    
    func loadImages(completion: @escaping (String?) -> ()) {
        let request = Router.photoSearch
        NetworkManager.makeRequest(request, showLog: true) { (result) in
            switch result {
            case .success(let value):
                guard let data = value as? [String:Any], let photo = data["photos"] as? [String: Any]  else {
                    completion("No data found")
                    return
                }
                self.photo = Photo(dict: photo)
                completion(nil)
             case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
    
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
            return history
        }
        return []
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
