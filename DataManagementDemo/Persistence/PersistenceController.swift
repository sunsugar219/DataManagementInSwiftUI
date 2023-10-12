//
//  PersistenceController.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 06. 09..
//

import CoreData
import Foundation
struct PersistenceController {

    // A singleton for our entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    let container: NSPersistentContainer
    let viewContext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext

    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        // Create 10 examples.
        for index in 0..<10 {
            let asset = ImageAsset(context: controller.backgroundContext)
            asset.height = 400
            asset.url = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Eopsaltria_australis_-_Mogo_Campground.jpg/640px-Eopsaltria_australis_-_Mogo_Campground.jpg"
            let image = Image(context: controller.backgroundContext)
            image.id = String(index)
            image.aspect = 4/3
            image.assets = NSSet(array: [asset])
        }
        do {
          try viewContext.save()
        } catch {
          let nsError = error as NSError
          fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return controller
    }()

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ShutterstockImages")
        viewContext = container.viewContext
        backgroundContext = container.newBackgroundContext()
        viewContext.mergePolicy = NSMergePolicy(merge: NSMergePolicyType.mergeByPropertyObjectTrumpMergePolicyType)
        backgroundContext.mergePolicy = NSMergePolicy(merge: NSMergePolicyType.mergeByPropertyObjectTrumpMergePolicyType)
        viewContext.automaticallyMergesChangesFromParent = true
//        backgroundContext.automaticallyMergesChangesFromParent = true

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }

    func save() {
        if viewContext.hasChanges {
            DispatchQueue.main.async {
                do {
                    try viewContext.save()
                } catch {
                    fatalError("Error: save failed")
                }
            }
        }
        if backgroundContext.hasChanges {
            backgroundContext.performAndWait {
                // Do some core data processing here
                do {
                    try backgroundContext.save()
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
            }
        }
    }
}
