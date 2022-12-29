//
//  Person.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import Foundation
import UIKit


struct Person: Identifiable, Codable, Equatable, Comparable {
    
    let id: UUID
    let name: String
    var image: UIImage?
    
    enum CodingKeys: CodingKey {
        case id, name, image
    }
    
    init(id: UUID, name: String, image: UIImage) {
        self.id = id
        self.name = name
        self.image = image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let data = try container.decode(Data.self, forKey: .image)
        image = UIImage(data: data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        let imageData = image?.jpegData(compressionQuality: 0.8)
        try container.encode(imageData, forKey: .image)
    }
    
   static func <(lhs: Person, rhs: Person) -> Bool{
        lhs.name < rhs.name
    }
}
