//
//  STAsset.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 01. 16..
//

import Foundation

struct STAsset: Codable, Equatable  {
    var url: String
    var height: CGFloat
    var width: CGFloat

    static func mock() -> STAsset {
        STAsset(url: "https://image.shutterstock.com/z/stock-vector-cargo-ship-vessel-port-export-or-import-tanker-shipping-international-sea-logistic-marine-1655092756.jpg",
                height: 888,
                width: 1500)
    }
}
