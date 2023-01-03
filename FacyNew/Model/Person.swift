//
//  Person.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import Foundation
import UIKit
import MapKit


struct Person: Identifiable, Codable, Equatable, Comparable {
    
    let id: UUID
    let name: String
    var image: UIImage?
    var country: String
    var age: String
    var long: Double
    var lat: Double
    
    var coordinates: CLLocationCoordinate2D {
       return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    enum CodingKeys: CodingKey {
        case id, name, image, long, lat, country, age
    }
    
    init(id: UUID, name: String, image: UIImage, long: Double, lat: Double, country: String, age: String) {
        self.id = id
        self.name = name
        self.image = image
        self.country = country
        self.long = long
        self.lat = lat
        self.age = age
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let data = try container.decode(Data.self, forKey: .image)
        image = UIImage(data: data)
        lat = try container.decode(Double.self, forKey: .lat)
        long = try container.decode(Double.self, forKey: .long)
        country = try container.decode(String.self, forKey: .country)
        age = try container.decode(String.self, forKey: .age)

    }
    
    func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        let imageData = image?.jpegData(compressionQuality: 0.8)
        try container.encode(imageData, forKey: .image)
        try container.encode(long, forKey: .long)
        try container.encode(lat, forKey: .lat)
        try container.encode(country, forKey: .country)
        try container.encode(age, forKey: .age)

        
    }
    
   static func <(lhs: Person, rhs: Person) -> Bool{
        lhs.name < rhs.name
    }
    

}
