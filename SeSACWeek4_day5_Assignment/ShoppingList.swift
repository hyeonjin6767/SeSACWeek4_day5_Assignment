//
//  ShoppingList.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/26/25.
//

import Foundation

//네이버 쇼핑 API
//거꾸로 짜기, Decodable빼먹지 않기

struct ShoppingList: Decodable {
    let total: Int
    var items: [ProductsList]
}

struct ProductsList: Decodable {
    let image: String
    let mallName: String
    let title: String
    let lprice: String
}
