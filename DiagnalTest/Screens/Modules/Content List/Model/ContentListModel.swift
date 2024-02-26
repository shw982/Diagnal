//
//  ContentListModel.swift
//  DiagnalTest
//
//  Created by Sweta Jaiswal on 26/02/24.
//

import Foundation

struct ContentList: Decodable {
    let page: ContentModel

    enum CodingKeys: String, CodingKey {
        case page = "page"
    }
}

struct ContentModel: Decodable {
    let title: String
    let totalContentItems: String
    let pageNum: String
    let pageSize: String
    let contentItems: ContentItem

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case totalContentItems = "total-content-items"
        case pageNum = "page-num"
        case pageSize = "page-size"
        case contentItems = "content-items"
    }
}

struct ContentItem: Decodable {
    let content: [Content]

    enum CodingKeys: String, CodingKey {
        case content = "content"
    }
}

struct Content: Decodable {
    let name: String
    let posterImage: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case posterImage = "poster-image"
    }
}
