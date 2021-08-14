//
//  ServerCommunication.swift
//  GifSearch
//
//  Created by Luda Parfenova on 08/08/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServerCommunication {
    
    public static let sharedInstance = ServerCommunication()

    private let SEARCH_URL = "https://api.giphy.com/v1/gifs/search"
    
    private let KEY = "9Qgba90yKllH4hHLLBvr2zoQHrapaQfV"
    
    public func searchRequest(key: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void) {
        let parameters: Parameters = [
            "limit": 18,
            "offset": 0,
            "rating": "g",
            "lang": "en",
            "api_key": KEY,
            "q": key
        ]
        call(path: SEARCH_URL, method: .get, parameters: parameters, onSuccess: onSuccess, onFailure: onFailure)
        }
    
    private func call(path: String, method: HTTPMethod, parameters: Parameters?, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void) {
        AF.request(path, method: method, parameters: parameters, encoding: URLEncoding(destination: .queryString))
            .responseJSON { response in
//                debugPrint(response)
                switch response.result {
                    case let .success(value):
                        onSuccess(JSON(value))
                    case let .failure(error):
                        onFailure(error)
                }
            }
    }

}
