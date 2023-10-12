//
//  AppState.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 01. 13..
//

import SwiftUI

enum AppViewState {
    case initial
    case readyToSearch
    case loading
    case loaded([STImage])
    case history
    case error
}

final class AppState: ObservableObject {
    @Published var uiState: AppViewState = .readyToSearch

    func showHistory() {
        self.uiState = .history
    }

    @MainActor
    func setToReadyToSearch() {
        self.uiState = .readyToSearch
    }
}
