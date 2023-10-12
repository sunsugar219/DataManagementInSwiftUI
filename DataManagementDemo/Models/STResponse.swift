//
//  STResponse.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 01. 20..
//

import Foundation

struct STResponse: Codable, Equatable, Identifiable {
    var id: String
    var page: Int
    var perPage: Int
    var totalCount: Int
    var data: [STImage]

    static func == (lhs: STResponse, rhs: STResponse) -> Bool {
        lhs.id == rhs.id
    }

    enum CodingKeys: String, CodingKey {
        case page, data
        case searchId = "search_id"
        case perPage = "per_page"
        case totalCount = "total_count"
        case spellcheckInfo = "spellcheck_info"
    }

    init(id: String, page: Int, perPage: Int, totalCount: Int, data: [STImage]) {
        self.id = id
        self.page = page
        self.data = data
        self.perPage = perPage
        self.totalCount = totalCount
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        page = try values.decode(Int.self, forKey: .page)
        perPage = try values.decode(Int.self, forKey: .perPage)
        totalCount = try values.decode(Int.self, forKey: .totalCount)
        data = try values.decode([STImage].self, forKey: .data)
        id = try values.decode(String.self, forKey: .searchId)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(page, forKey: .page)
        try container.encode(perPage, forKey: .perPage)
        try container.encode(totalCount, forKey: .totalCount)
        try container.encode(data, forKey: .data)
        try container.encode(id, forKey: .searchId)
    }
}
