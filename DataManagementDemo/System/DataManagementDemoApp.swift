//
//  DataManagementDemoApp.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 01. 11..
//

import SwiftUI

@main
struct DataManagementDemoApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var appState = AppState()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SearchView(
                viewModel: SearchViewModel(
                    appState: appState,
                    webRepository: ShutterStockRepo(),
                    managedObjectContext: persistenceController.backgroundContext
                )
            )
            .environmentObject(appState)
            .environment(\.managedObjectContext, persistenceController.viewContext)
        }
        .onChange(of: scenePhase) { _, _ in
            persistenceController.save()
        }
    }
}
