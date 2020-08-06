//
//  Model.swift
//  JSONTutorial
//
//  Created by Christopher Devito on 8/6/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

struct Model: Codable {
    let name: String
    let firstItem: String
    let firstAmount: Int
    let secondItem: String
    let secondAmount: Int

    init(name: String, firstItem: String, firstAmount: Int, secondItem: String = "", secondAmount: Int = 0) {
        self.name = name
        self.firstItem = firstItem
        self.firstAmount = firstAmount
        self.secondItem = secondItem
        self.secondAmount = secondAmount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ModelKeys.self)
        let name = try container.decode(String.self, forKey: .name)

        let firstItemContainer = try container.nestedContainer(keyedBy: FirstItemKeys.self, forKey: .firstItemInfo)
        let firstItem = try firstItemContainer.decode(String.self, forKey: .firstItem)
        let firstAmount = try firstItemContainer.decode(Int.self, forKey: .firstAmount)

        let secondItemContainer = try container.nestedContainer(keyedBy: SecondItemKeys.self, forKey: .secondItemInfo)
        let secondItem = try secondItemContainer.decode(String.self, forKey: .secondItem)
        let secondAmount = try secondItemContainer.decode(Int.self, forKey: .secondAmount)

        self.name = name
        self.firstItem = firstItem
        self.firstAmount = firstAmount
        self.secondItem = secondItem
        self.secondAmount = secondAmount
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ModelKeys.self)
        try container.encode(name, forKey: .name)

        var firstItemContainer = container.nestedContainer(keyedBy: FirstItemKeys.self, forKey: .firstItemInfo)
        try firstItemContainer.encode(firstItem, forKey: .firstItem)
        try firstItemContainer.encode(firstAmount, forKey: .firstAmount)

        var secondItemContainer = container.nestedContainer(keyedBy: SecondItemKeys.self, forKey: .secondItemInfo)
        try secondItemContainer.encode(secondItem, forKey: .secondItem)
        try secondItemContainer.encode(secondAmount, forKey: .secondAmount)
    }

    enum ModelKeys: String, CodingKey {
        case name = "name"
        case firstItemInfo = "first_item_info"
        case secondItemInfo = "seond_item_info"
    }

    enum FirstItemKeys: String, CodingKey {
        case firstItem = "first_item"
        case firstAmount = "first_amount"
    }

    enum SecondItemKeys: String, CodingKey {
        case secondItem = "sescond_item"
        case secondAmount = "second_amount"
    }
}
