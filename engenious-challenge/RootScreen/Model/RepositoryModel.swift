//
//  RepositoryModel.swift
//  engenious-challenge
//
//  Created by Anastasia Kholod on 07.06.2022.
//

import Foundation

struct RepositoryModel: Codable {
    var name: String
    var description: String?
    var url: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case url = "url"
    }
}

