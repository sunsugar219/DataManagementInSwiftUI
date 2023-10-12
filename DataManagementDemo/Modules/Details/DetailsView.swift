//
//  DetailsView.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 01. 13..
//

import SwiftUI

struct DetailsView: View {
    let image: STImage

    var body: some View {
        VStack {
            if let url = URL(string: image.assets.preview.url) {
                AsyncImage(url: url)
                    .frame(width: .infinity, height: image.assets.preview.height )
            }
            Text(image.description)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(image: STImage.mock())
    }
}
