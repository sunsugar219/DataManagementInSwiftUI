//
//  Image+CoreDataProperties.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 06. 13..
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var aspect: Double
    @NSManaged public var id: String?
    @NSManaged public var imageDescription: String?
    @NSManaged public var assets: NSSet?

}

// MARK: Generated accessors for assets
extension Image {

    @objc(addAssetsObject:)
    @NSManaged public func addToAssets(_ value: ImageAsset)

    @objc(removeAssetsObject:)
    @NSManaged public func removeFromAssets(_ value: ImageAsset)

    @objc(addAssets:)
    @NSManaged public func addToAssets(_ values: NSSet)

    @objc(removeAssets:)
    @NSManaged public func removeFromAssets(_ values: NSSet)

}

extension Image : Identifiable {

}
