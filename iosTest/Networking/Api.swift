//
//  Api.swift
//  iosTest
//
//  Created by Omar on 21/12/20.
//

import Foundation

class Api {
    
    private static var _sharedInstance: Api = {
        let object = Api()
        return object
    }()
    
    class var shared: Api {
        return _sharedInstance
    }
    
    func getMoviesPer(page: Int, completion: @escaping (MoviesResponse?, Bool) -> Void) {
        
        let params = ["api_key": "634b49e294bd1ff87914e7b9d014daed",
                      "page": page
        ] as [String : Any]
        
        Request.shared.makeRequest(url: Urls.nowPlaying, params: params) { (response: Response<MoviesResponse>) in
            switch response {
            case .success(let data):
                completion(data, false)
            case .error(let error):
                completion(nil, true)
                self.printError(url: Urls.nowPlaying, params: params, error: error)
            }
        }
    }
    
    func getMovieBy(id: Int, completion: @escaping (MovieDetailResponse?, Bool) -> Void) {
        
        let params = ["api_key": "634b49e294bd1ff87914e7b9d014daed"]
            as [String : Any]
        var url = Urls.movie
        url.endPoint += "\(id)"
        
        Request.shared.makeRequest(url: url, params: params) { (response: Response<MovieDetailResponse>) in
            switch response {
            case .success(let data):
                completion(data, false)
            case .error(let error):
                completion(nil, true)
                self.printError(url: url, params: params, error: error)
            }
        }
    }
    
    private func printError(url: Url, params: [String: Any]?, error: Error) {
        let stringError =
        """
        ================================== REQUEST FAIL =======================================
        URL: \(url.endPoint)
        METHOD: \(url.method.rawValue)
        HEADERS: \(String(describing: url.headers))
        PARAMS: \(String(describing: params))
        ERROR: \(error.localizedDescription)
        =======================================================================================
        """
        print(stringError)
    }
}
