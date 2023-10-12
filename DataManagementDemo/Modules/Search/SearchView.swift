//
//  SearchView.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 01. 13..
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var viewModel: SearchViewModel
    @State var searchTerm = ""

    var body: some View {
        switch appState.uiState {
        case .initial:
            loadingView("Loading...")
        case .readyToSearch:
            readyToSearchView
        case .loading:
            loadingView("Searching...")
        case .loaded(let images):
            imagesLoadedView(images)
        case .error:
            errorView
        case .history:
            historyView
        }
    }

    @ViewBuilder
    private func loadingView(_ text: String) -> some View {
        VStack(spacing: 10) {
            Spacer()
            SwiftUI.Image(systemName: "target")
                .font(.system(size: 72.0))
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.variableColor.iterative)
            Text(text)
                .foregroundStyle(.white)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .center
                )
            Spacer()
        }
        .background(Color.gray.gradient)
    }

    @ViewBuilder
    private var readyToSearchView: some View {
        VStack {
            Spacer()
            historyAndSearchBar
                .padding(4.0)
            Spacer()
        }
        .background(Color.gray.gradient)
    }

    @ViewBuilder
    private var historyAndSearchBar: some View {
        Button("History") {
            appState.showHistory()
        }
        .frame(width: 200, height: 40)
        .background(Color.white)
        .cornerRadius(SizeConstants.buttonCornerRadius)
        HStack {
            SwiftUI.Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
            TextField("Search for images by keyword", text: $searchTerm)
                .frame(height: 40.0)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        Button("Search") {
            Task {
                await viewModel.loadImages(by: searchTerm)
            }
        }
        .frame(width: 200, height: 40)
        .background(Color.white)
        .cornerRadius(SizeConstants.buttonCornerRadius)
    }

    @ViewBuilder
    private func imagesLoadedView(_ images: [STImage]) -> some View {
        VStack {
            historyAndSearchBar
            NavigationView {
                List(images) { item in
                    NavigationLink {
                        DetailsView(image: item)
                    } label: {
                        AsyncImage(url: URL(string: item.assets.largeThumb.url))
                    }
                }
                .environment(\.defaultMinListRowHeight, 175)
            }
        }
        .background(Color.gray.gradient)
    }

    @ViewBuilder
    private var historyView: some View {
        HistoryView(
            viewModel: HistoryViewModel(
                appState: appState,
                managedObjectContext: managedObjectContext
            )
        )
        .environmentObject(appState)
    }

    @ViewBuilder
    private var errorView: some View {
        VStack {
            Spacer()
            Text("ERROR")
            Text("Please try again")
            TextField("Search for images by keyword", text: $searchTerm)
                .frame(height: 40.0)
                .padding(4.0)

                .background(Color.white)
                .cornerRadius(SizeConstants.textFieldCornerRadius)
            Button("Search") {
                Task {
                    await viewModel.loadImages(by: searchTerm)
                }
            }
            .cornerRadius(SizeConstants.buttonCornerRadius)
            Spacer()
        }
        .background(Color.gray.gradient)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(
            viewModel: SearchViewModel(
                appState: AppState(),
                webRepository: ShutterStockRepo(),
                managedObjectContext: PersistenceController.shared.container.viewContext
            )
        )
        .environmentObject(AppState())
    }
}
