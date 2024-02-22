//
//  MockService.swift
//  DiagnalTestTests
//
//  Created by Roster Buster on 17/02/24.
//

import Foundation
@testable import DiagnalTest


class MockService: ContentListProtocol {

    var mockResult: (Result<ContentList, DataError>)!

    func readLocalJsonFile(_ fileName: String, completion: @escaping(Result<ContentList, DataError>) -> Void) {
        completion(mockResult)
    }

    func getContentList() -> ContentList? {
        do {
            if let filePath = Bundle.main.path(forResource: "content_list_page_1", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let jsonData = try Data(contentsOf: fileUrl)
                return try JSONDecoder().decode(ContentList.self, from: jsonData)
              }
        } catch {
            return nil
        }

        return nil
    }
    
}
