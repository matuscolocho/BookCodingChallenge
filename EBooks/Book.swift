//
//  Book.swift
//  EBooks
//
//  Created by JoshuaMatus on 17/12/21.
//

import Foundation

struct Book{
    var title:String?
    var imageURL:String?
    var author:String?
}

extension Book:Codable{
    enum BookKeys: String, CodingKey {
        case title = "title"
        case imageURL = "imageURL"
        case author = "author"
        
   
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: BookKeys.self)
        title                      = try values.decodeIfPresent(String.self, forKey: .title)
        imageURL                      = try values.decodeIfPresent(String.self, forKey: .imageURL)
        author                      = try values.decodeIfPresent(String.self, forKey: .author)
    
        
        
    }
}
