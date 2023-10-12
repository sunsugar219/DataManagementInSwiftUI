//
//  STImage.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 01. 13..
//

import Foundation

struct STImage: Codable, Equatable, Identifiable {
    var id: String
    var aspect: Double
    var assets: STImageAssets
    var contributor: STContributor
    var description: String
    var imageType: String
    var hasModelRelease: Bool
    var mediaType: String

    static func == (lhs: STImage, rhs: STImage) -> Bool {
        lhs.id == rhs.id
    }

    enum CodingKeys: String, CodingKey {
        case id, aspect, assets, contributor, description
        case imageType = "image_type"
        case hasModelRelease = "has_model_release"
        case mediaType = "media_type"
    }

    init(id: String, aspect: Double, assets: STImageAssets, contributor: STContributor, description: String, imageType: String, hasModelRelease: Bool, mediaType: String) {
        self.id = id
        self.aspect = aspect
        self.assets = assets
        self.contributor = contributor
        self.description = description
        self.imageType = imageType
        self.hasModelRelease = hasModelRelease
        self.mediaType = mediaType
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(String.self, forKey: .id)
        assets = try values.decode(STImageAssets.self, forKey: .assets)
        aspect = try values.decode(Double.self, forKey: .aspect)
        contributor = try values.decode(STContributor.self, forKey: .contributor)
        description = try values.decode(String.self, forKey: .description)
        imageType = try values.decode(String.self, forKey: .imageType)
        hasModelRelease = try values.decode(Bool.self, forKey: .hasModelRelease)
        mediaType = try values.decode(String.self, forKey: .mediaType)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
        try container.encode(assets, forKey: .assets)
        try container.encode(aspect, forKey: .aspect)
        try container.encode(contributor, forKey: .contributor)
        try container.encode(imageType, forKey: .imageType)
        try container.encode(hasModelRelease, forKey: .hasModelRelease)
        try container.encode(mediaType, forKey: .mediaType)
    }
}
extension STImage: Hashable {
    var identifier: String {
        id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
}
extension STImage {
    static func mock() -> STImage {
        STImage(id: "", aspect: 1.1, assets: STImageAssets.mock(), contributor: STContributor(id: ""), description: "bwrtbw th56jnez kdmdtk65e 6k6i  sne5 j65", imageType: "picture", hasModelRelease: false, mediaType: "awesome")
    }
}
