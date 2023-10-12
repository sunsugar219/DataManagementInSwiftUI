//
//  CancelBag.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 01. 16..
//

import Combine

final class CancelBag {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()

    func cancel() {
        subscriptions.removeAll()
    }
}

extension AnyCancellable {

    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
