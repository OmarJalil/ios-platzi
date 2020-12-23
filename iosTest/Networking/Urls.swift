//
//  Urls.swift
//  iosTest
//
//  Created by Omar on 21/12/20.
//

import Foundation
import Alamofire

let BASE_URL = "https://api.themoviedb.org/3"

struct Urls {
    static var nowPlaying = Url(
        endPoint: "/movie/now_playing",
        headers: [:],
        method: .get
    )
    
    static var movie = Url(
        endPoint: "/movie/",
        headers: [:],
        method: .get
    )
    
}

struct Url {
    var endPoint: String
    var headers: HTTPHeaders?
    let method: HTTPMethod

    init(endPoint: String, headers: HTTPHeaders?, method: HTTPMethod) {
        self.endPoint = "\(BASE_URL)\(endPoint)"
        self.headers = headers
        self.method = method
    }
}
