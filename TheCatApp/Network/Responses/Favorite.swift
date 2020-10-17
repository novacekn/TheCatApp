//
//  Favorite.swift
//  TheCatApp
//
//  Created by Nathan Novacek on 10/12/20.
//

import Foundation

struct FavoriteImage: Codable {
    var id: String
    var url: String
}

struct Favorite: Codable {
    var created_at: String
    var id: Int
    var image: FavoriteImage
    var image_id: String
    var sub_id: String
    var user_id: String
}
