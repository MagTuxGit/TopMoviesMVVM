//
//  MoviesParser.swift
//  TopMovies
//
//  Created by Andriy Trubchanin on 4/2/18.
//  Copyright © 2018 Trand. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let iTunesMovie = try ITunesMovie(json)

import Foundation

struct ITunesMovie: Codable {
    let imName, rights: Label
    let imImage: [IMImage]
    let summary: Label
    let imRentalPrice, imPrice: IMPrice
    let imContentType: IMContentType
    let title: Label
    let link: [Link]
    let id: ID
    let imArtist: Label
    let category: Category
    let imReleaseDate: IMReleaseDate
    
    enum CodingKeys: String, CodingKey {
        case imName = "im:name"
        case rights
        case imImage = "im:image"
        case summary
        case imRentalPrice = "im:rentalPrice"
        case imPrice = "im:price"
        case imContentType = "im:contentType"
        case title, link, id
        case imArtist = "im:artist"
        case category
        case imReleaseDate = "im:releaseDate"
    }
}

struct Category: Codable {
    let attributes: CategoryAttributes
}

struct CategoryAttributes: Codable {
    let imID, term, scheme, label: String
    
    enum CodingKeys: String, CodingKey {
        case imID = "im:id"
        case term, scheme, label
    }
}

struct ID: Codable {
    let label: String
    let attributes: IDAttributes
}

struct IDAttributes: Codable {
    let imID: String
    
    enum CodingKeys: String, CodingKey {
        case imID = "im:id"
    }
}

struct Label: Codable {
    let label: String
}

struct IMContentType: Codable {
    let attributes: IMContentTypeAttributes
}

struct IMContentTypeAttributes: Codable {
    let term, label: String
}

struct IMImage: Codable {
    let label: String
    let attributes: IMImageAttributes
}

struct IMImageAttributes: Codable {
    let height: String
}

struct IMPrice: Codable {
    let label: String
    let attributes: IMPriceAttributes
}

struct IMPriceAttributes: Codable {
    let amount, currency: String
}

struct IMReleaseDate: Codable {
    let label: String
    let attributes: Label
}

struct Link: Codable {
    let attributes: LinkAttributes
    let imDuration: Label?
    
    enum CodingKeys: String, CodingKey {
        case attributes
        case imDuration = "im:duration"
    }
}

struct LinkAttributes: Codable {
    let rel, type, href: String
    let title, imAssetType: String?
    
    enum CodingKeys: String, CodingKey {
        case rel, type, href, title
        case imAssetType = "im:assetType"
    }
}

// MARK: Convenience initializers
extension ITunesMovie {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ITunesMovie.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
