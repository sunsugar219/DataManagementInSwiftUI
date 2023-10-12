//
//  ImageExtensions.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 06. 09..
//

import Foundation
extension Image {
    func makeAssetArray() -> STImageAssets {
        if let array = assets?.allObjects as? [ImageAsset] {
            var preview = STAsset.mock()
            var largeThumb = STAsset.mock()
            var smallThumb = STAsset.mock()
            var hugeThumb = STAsset.mock()
            var preview1000 = STAsset.mock()
            var preview1500 = STAsset.mock()
            array
                .forEach { asset in
                    switch asset.type {
                    case "preview":
                        preview = STAsset(url: asset.url ?? "", height: CGFloat(asset.height), width: 0)
                    case "largeThumb":
                        largeThumb = STAsset(url: asset.url ?? "", height: CGFloat(asset.height), width: 0)
                    case "smallThumb":
                        smallThumb = STAsset(url: asset.url ?? "", height: CGFloat(asset.height), width: 0)
                    case "hugeThumb":
                        hugeThumb = STAsset(url: asset.url ?? "", height: CGFloat(asset.height), width: 0)
                    case "preview1000":
                        preview1000 = STAsset(url: asset.url ?? "", height: CGFloat(asset.height), width: 0)
                    case "preview1500":
                        preview1500 = STAsset(url: asset.url ?? "", height: CGFloat(asset.height), width: 0)
                    default:
                        break
                    }
                }
            return STImageAssets(preview: preview, largeThumb: largeThumb, smallThumb: smallThumb, hugeThumb: hugeThumb, preview1000: preview1000, preview1500: preview1500)
        }
        return STImageAssets.mock()
    }

    func getPreview() -> STAsset {
        var previewAsset = STAsset.mock()
        if let array = assets?.allObjects as? [ImageAsset] {
            array
            .forEach { asset in
                if asset.type == ImageAssetType.preview.rawValue {
                    previewAsset = STAsset(url: asset.url ?? "", height: CGFloat(asset.height), width: 0)
                }
            }
        }
        return previewAsset
    }

    func getSTImage() -> STImage {
        STImage(
            id: self.id ?? "",
            aspect: self.aspect,
            assets: self.makeAssetArray(),
            contributor: STContributor(id: ""),
            description: self.imageDescription ?? "",
            imageType: "",
            hasModelRelease: false,
            mediaType: ""
        )
    }
}
