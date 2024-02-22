//
//  ContentListService.swift
//  DiagnalTest
//
//  Created by Sweta Jaiswal on 16/02/24.
//

import Foundation

/// Error types enum
enum DataError: Error {
    case jsonFileNotfound
    case invalidDecoding
}

typealias Handler = (Result<ContentList, DataError>) -> Void


protocol ContentListProtocol {
    func readLocalJsonFile(_ fileName: String, completion: @escaping Handler)
}

final class ContentListService: ContentListProtocol {

    /// Read from local json file
    func readLocalJsonFile(_ fileName: String, completion: @escaping Handler) {
        do {
            if let filePath = Bundle.main.path(forResource: fileName, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let jsonData = try Data(contentsOf: fileUrl)

                do {
                    let decodedData = try JSONDecoder().decode(ContentList.self, from: jsonData)
                    completion(.success(decodedData))

                } catch {
                    completion(.failure(.invalidDecoding))
                }
            }
        } catch {
            completion(.failure(.jsonFileNotfound))
        }
    }

}
