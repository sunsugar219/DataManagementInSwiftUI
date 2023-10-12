//
//  SearchViewModel.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 01. 13..
//

import Combine
import CoreData
import Foundation
import SwiftUI

final class SearchViewModel: ObservableObject {
    let webRepository: ShutterStockRepoProtocol
    let managedObjectContext: NSManagedObjectContext
    let appState: AppState
    @Published var imagesLoaded = false

    init(
        appState: AppState,
        webRepository: ShutterStockRepoProtocol,
        managedObjectContext: NSManagedObjectContext
    ) {
        self.webRepository = webRepository
        self.appState = appState
        self.managedObjectContext = managedObjectContext
        Task {
            await self.appState.setToReadyToSearch()
        }
    }
    
    func loadImages(by search: String) async {
        DispatchQueue.main.async {[unowned self] in
            self.appState.uiState = .loading
        }

        webRepository.loadImages(searchExpression: search) { [weak self] result in
            switch result {
            case .success(let images):
                guard let self else { return }
                images
                    .forEach({ webImage in
                        let image = Image(context: self.managedObjectContext)
                        image.id = webImage.id
                        image.aspect = webImage.aspect
                        image.imageDescription = webImage.description
                        image.assets = webImage.assets.turnToCoreDataSet(context: self.managedObjectContext)
                    })
                PersistenceController.shared.save()
                Task { 
                    DispatchQueue.main.async {
                        self.appState.uiState = .loaded(images)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                guard let self else { return }
                Task {
                    self.appState.uiState = .error
                }
            }
        }
    }

    func fetchImage(url: String) async throws -> UIImage? {
            let imageTask = Task { () -> UIImage? in
                let imageURL = URL(string: url)!
                print("Starting network request...")
                let (imageData, _) = try await URLSession.shared.data(from: imageURL)
                return UIImage(data: imageData)
            }
            return try await imageTask.value
    }
}
