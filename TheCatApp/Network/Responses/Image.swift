//
//  Image.swift
//  TheCatApp
//
//  Created by Nathan Novacek on 10/12/20.
//

import Foundation

struct Image: Codable {
    var breeds: [Breed]?
    var height: Int?
    var id: String?
    var url: String?
    var width: Int?
}
