//
//  ImageAsset+CoreDataProperties.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 06. 13..
//
//

import Foundation
import CoreData


extension ImageAsset {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageAsset> {
        return NSFetchRequest<ImageAsset>(entityName: "ImageAsset")
    }

    @NSManaged public var height: Float
    @NSManaged public var type: String?
    @NSManaged public var url: String?
    @NSManaged public var owningImage: Image?

}

extension ImageAsset : Identifiable {

}
