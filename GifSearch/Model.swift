//
//  Model.swift
//  GifSearch
//
//  Created by Luda Parfenova on 13/08/2021.
//

import Foundation
import SwiftyJSON

struct Root: Codable {
    let data: [Datum]
    
    init(gifData: JSON) {
        let jsonData = gifData.rawString()?.data(using: .utf8);
        if let root = try? JSONDecoder().decode(Root.self, from: jsonData!) {
            self.data = root.data
        } else {
            self.data = []
        }
    }
}

struct Datum: Codable {
    let images: Images
}

struct Images: Codable {
    let downsized: Downsized
}

struct Downsized: Codable {
    let url: URL
}
