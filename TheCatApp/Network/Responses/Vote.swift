//
//  Vote.swift
//  TheCatApp
//
//  Created by Nathan Novacek on 10/12/20.
//

import Foundation

struct Vote: Codable {
    var country_code: String?
    var created_at: String?
    var id: String?
    var image_id: String?
    var sub_id: String?
    var value: Int?
}
