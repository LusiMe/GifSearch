//
//  Model.swift
//  GifSearch
//
//  Created by Luda Parfenova on 13/08/2021.
//

import Foundation

struct Model{
    var gifURL: URL
    
    init(_ dictionary: [String: Any]) {
        self.gifURL = dictionary["name"] as! URL
}
}

struct Root: Codable {
    let data: [Datum]
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
