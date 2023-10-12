//
//  HistoryViewModel.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 06. 13..
//

import Combine
import CoreData
import Foundation
import SwiftUI

final class HistoryViewModel: ObservableObject {
    let managedObjectContext: NSManagedObjectContext
    let appState: AppState

    init(
        appState: AppState,
        managedObjectContext: NSManagedObjectContext
    ) {
        self.appState = appState
        self.managedObjectContext = managedObjectContext
    }

    func clearHistory(images: FetchedResults<Image>) async {
        do {
            for image in images {
                let imageData: NSManagedObject = image as NSManagedObject
                managedObjectContext.delete(imageData)
            }
            try managedObjectContext.save()
        } catch {
            appState.uiState = .error
        }

//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<Image>(entityName: "Image")
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        batchDeleteRequest.resultType = .resultTypeObjectIDs
//        let result = try execute(batchDeleteRequest) as! NSBatchDeleteResult
//        let changes: [AnyHashable: Any] = [
//            NSDeletedObjectsKey: result.result as! [NSManagedObjectID]
//        ]
//        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [myManagedObjectContext])
    }
}
