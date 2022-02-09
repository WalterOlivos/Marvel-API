//
//  Comic.swift
//  marvel-api
//
//  Created by Walter Oliveira on 13/11/18.
//  Copyright © 2018 Walter Oliveira. All rights reserved.
//

import Foundation

struct Comic: Codable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
}

extension Comic {
    struct Thumbnail: Codable {
        let path: String
        let `extension`: String
        
        var url: URL {
            return URL(string: path + "/portrait_fantastic." + `extension`)!
        }
    }
}
