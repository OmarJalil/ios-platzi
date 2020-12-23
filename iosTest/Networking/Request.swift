//
//  Request.swift
//  iosTest
//
//  Created by Omar on 21/12/20.
//

import Foundation
import Alamofire

enum Response<R> {
    case success(R)
    case error(Error)
}

class Request {
    
    private static var _sharedInstance: Request = {
        let object = Request()
        return object
    }()

    class var shared: Request {
        return _sharedInstance
    }
    
    func makeRequest<T: Decodable>(customTimeOut: Double = 5,
                                       url: Url,
                                       params: [String: Any]?,
                                       completion: @escaping (Response<T>) -> Void) {
        
        let manager = Session.default
        manager.session.configuration.timeoutIntervalForRequest = customTimeOut
        manager.session.configuration.timeoutIntervalForResource = customTimeOut
        
        manager.request(
            url.endPoint,
            method: url.method,
            parameters: params,
            headers: url.headers
        )
        .validate(statusCode: 200..<600)
        .responseDecodable(of: T.self) { response in
            
            if let error = response.error {
                completion(.error(error))
            } else if let data = response.value {
                completion(.success(data))
            }
        }
    }
}
