//
//  url.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import Foundation

extension FileManager {
    static var directory: URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
