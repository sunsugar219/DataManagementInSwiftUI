//
//  HistorySort.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 06. 12..
//

import Foundation
// 1
//struct HistorySort: Hashable, Identifiable {
//  // 2
//  let id: Int
//  // 3
//  let name: String
//  // 4
//  let descriptors: [SortDescriptor<Image>]
//  let section: KeyPath<Image, String>
//
//  static let sorts: [HistorySort] = [
//    HistorySort(
//      id: 0,
//      name: "Meeting Place | Ascending",
//      descriptors: [
//        SortDescriptor(\Image.id, order: .forward),
//        SortDescriptor(\Image.aspect, order: .forward)
//      ],
//      section: \Image.aspect),
//    FriendSort(
//      id: 1,
//      name: "Meeting Place | Descending",
//      descriptors: [
//        SortDescriptor(\Friend.meetingPlace, order: .reverse),
//        SortDescriptor(\Friend.name, order: .forward)
//      ],
//      section: \Friend.meetingPlace),
//    FriendSort(
//      id: 2,
//      name: "Meeting Date | Ascending",
//      descriptors: [
//        SortDescriptor(\Friend.meetingDate, order: .forward),
//        SortDescriptor(\Friend.name, order: .forward)
//      ],
//      section: \Friend.meetingDay),
//    FriendSort(
//      id: 3,
//      name: "Meeting Date | Descending",
//      descriptors: [
//        SortDescriptor(\Friend.meetingDate, order: .reverse),
//        SortDescriptor(\Friend.name, order: .forward)
//      ],
//      section: \Friend.meetingDayDescending)
//  ]

  // 4
//  static var `default`: HistorySort { sorts[0] }
//}
