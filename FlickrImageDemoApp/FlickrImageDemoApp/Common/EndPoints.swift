//
//  EndPoints.swift
//  FlickrImageDemoApp


//Server types
enum enEndPoints {
    case method
    case apiKey
    case format
    case nojsoncallback
    case text
    
    var path:String {
        switch self {
        case .method:
            return "flickr.photos.search"
        case .apiKey:
            return API.Key
        case .format:
            return "json"
        case .nojsoncallback:
            return "1"
        case .text:
            return searchQuery
        }
    }
}

//API's Endpoint for using with BaseUrl
struct EndPoints {
    
    private struct Routes {
        static let searchApi = "?method=\(enEndPoints.method.path)&api_key=\(enEndPoints.apiKey.path)&format=\(enEndPoints.format.path)&nojsoncallback=\(enEndPoints.nojsoncallback.path)&text=\(searchQuery)"
    }
    
    //MARK: Final endpoint
    static var SearchApi: String {
        return Routes.searchApi
    }
}
