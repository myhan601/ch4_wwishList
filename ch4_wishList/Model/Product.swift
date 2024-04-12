//
//  Product.swift
//  ch4_wishList
//
//  Created by 한철희 on 4/12/24.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let thumbnail: URL
}
// CodingKey와 Decodable 메서드 구현안함
// 외부 데이터 키를 그대로 프로퍼티 네임으로 사용할 경우 생략가능





