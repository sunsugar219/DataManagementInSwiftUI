//
//  STSpellcheckInfo.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 01. 20..
//

import Foundation

struct STSpellcheckInfo: Codable, Equatable  {
    var spellcheckedQuery: String
    var origQuery: String
    var origResultsCount: Int
    var spellcheckedResultsCount: Int

    enum CodingKeys: String, CodingKey {
        case spellcheckedQuery = "spellchecked_query"
        case origQuery = "orig_query"
        case origResultsCount = "orig_results_count"
        case spellcheckedResultsCount = "spellchecked_results_count"
    }

    init(spellcheckedQuery: String, origQuery: String, origResultsCount: Int, spellcheckedResultsCount: Int) {
        self.spellcheckedQuery = spellcheckedQuery
        self.origQuery = origQuery
        self.origResultsCount = origResultsCount
        self.spellcheckedResultsCount = spellcheckedResultsCount
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        id = try values.decode(String.self, forKey: .id)
//        assets = try values.decode(STImageAssets.self, forKey: .assets)
//        aspect = try values.decode(Double.self, forKey: .aspect)
//        contributor = try values.decode(STContributor.self, forKey: .contributor)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(id, forKey: .id)
//        try container.encode(description, forKey: .description)
//        try container.encode(assets, forKey: .assets)
//        try container.encode(aspect, forKey: .aspect)
//    }
}
