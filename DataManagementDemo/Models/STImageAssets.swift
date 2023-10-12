//
//  STImageAssets.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 01. 16..
//

import CoreData
import Foundation

enum ImageAssetType: String {
    case preview, largeThumb, smallThumb, hugeThumb, preview1000, preview1500
}

struct STImageAssets: Codable, Equatable {
    var preview: STAsset
    var largeThumb: STAsset
    var smallThumb: STAsset
    var hugeThumb: STAsset
    var preview1000: STAsset
    var preview1500: STAsset

    enum CodingKeys: String, CodingKey {
        case preview
        case preview1000 = "preview_1000"
        case preview1500 = "preview_1500"
        case largeThumb = "large_thumb"
        case smallThumb = "small_thumb"
        case hugeThumb = "huge_thumb"
    }

    init(preview: STAsset, largeThumb: STAsset, smallThumb: STAsset, hugeThumb: STAsset, preview1000: STAsset, preview1500: STAsset) {
        self.preview = preview
        self.largeThumb = largeThumb
        self.smallThumb = smallThumb
        self.hugeThumb = hugeThumb
        self.preview1000 = preview1000
        self.preview1500 = preview1500
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        preview = try values.decode(STAsset.self, forKey: .preview)
        largeThumb = try values.decode(STAsset.self, forKey: .largeThumb)
        smallThumb = try values.decode(STAsset.self, forKey: .smallThumb)
        hugeThumb = try values.decode(STAsset.self, forKey: .hugeThumb)
        preview1000 = try values.decode(STAsset.self, forKey: .preview1000)
        preview1500 = try values.decode(STAsset.self, forKey: .preview1500)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(preview, forKey: .preview)
        try container.encode(largeThumb, forKey: .largeThumb)
        try container.encode(smallThumb, forKey: .smallThumb)
        try container.encode(hugeThumb, forKey: .hugeThumb)
        try container.encode(preview1000, forKey: .preview1000)
        try container.encode(preview1500, forKey: .preview1500)

    }

    static func mock() -> STImageAssets {
        STImageAssets(preview: STAsset.mock(), largeThumb: STAsset.mock(), smallThumb: STAsset.mock(), hugeThumb: STAsset.mock(), preview1000: STAsset.mock(), preview1500: STAsset.mock())
    }

    func turnToCoreDataSet(context: NSManagedObjectContext) -> NSSet {
        let previewAsset = ImageAsset(context: context)
        previewAsset.height = Float(preview.height)
        previewAsset.url = preview.url
        previewAsset.type = ImageAssetType.preview.rawValue
        let largeThumbAsset = ImageAsset(context: context)
        largeThumbAsset.height = Float(largeThumb.height)
        largeThumbAsset.url = largeThumb.url
        largeThumbAsset.type = ImageAssetType.largeThumb.rawValue
        let smallThumbAsset = ImageAsset(context: context)
        smallThumbAsset.height = Float(smallThumb.height)
        smallThumbAsset.url = smallThumb.url
        smallThumbAsset.type = ImageAssetType.smallThumb.rawValue
        let hugeThumbAsset = ImageAsset(context: context)
        hugeThumbAsset.height = Float(hugeThumb.height)
        hugeThumbAsset.url = hugeThumb.url
        hugeThumbAsset.type = ImageAssetType.hugeThumb.rawValue
        let preview1000Asset = ImageAsset(context: context)
        preview1000Asset.height = Float(preview1000.height)
        preview1000Asset.url = preview1000.url
        preview1000Asset.type = ImageAssetType.preview1000.rawValue
        let preview1500Asset = ImageAsset(context: context)
        preview1500Asset.height = Float(preview1500.height)
        preview1500Asset.url = preview1500.url
        preview1500Asset.type = ImageAssetType.preview1500.rawValue

        return NSSet(array: [previewAsset, largeThumbAsset, smallThumbAsset, hugeThumbAsset, preview1000Asset, preview1500Asset])
    }
}
