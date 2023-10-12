//
//  HistoryView.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 06. 09..
//
import CoreData
import Foundation
import SwiftUI

struct HistoryView: View {

    // MARK: - Bindings
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel: HistoryViewModel
    @FetchRequest(
      sortDescriptors: [
        NSSortDescriptor(
            keyPath: \Image.id,
          ascending: true)
      ],
      animation: .default)
    private var images: FetchedResults<Image>

    // MARK: - Body

    var body: some View {
        VStack {
            HStack {
                Button("Back to search") {
                    appState.setToReadyToSearch()
                }
                Spacer()
                Button("Clear History") {
                    Task {
                        await viewModel.clearHistory(images: images)
                    }
                }
            }
            Spacer()
            Text("History")
                .padding()
            NavigationView {
                List(images) { item in
                    NavigationLink {
                        DetailsView(image: item.getSTImage())
                    } label: {
                        AsyncImage(url: URL(string: item.getPreview().url))
                    }
                }
                .environment(\.defaultMinListRowHeight, 175)
            }
        }
    }

}
