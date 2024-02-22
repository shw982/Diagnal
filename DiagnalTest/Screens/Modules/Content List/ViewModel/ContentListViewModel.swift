//
//  ContentListViewModel.swift
//  DiagnalTest
//
//  Created by Sweta Jaiswal on 16/02/24.
//

import Foundation

class ContentListViewModel {

    /// Variables
    var currentPage = 1
    var didReceiveContents: (()->()) = {}

    private var contentListService: ContentListProtocol

    var contents: [Content]? {
        didSet {
            if let _ = contents {
                self.didReceiveContents()
            }
        }
    }


    /// Init
    init(contentListService: ContentListProtocol = ContentListService()) {
        self.contentListService = contentListService
    }


    //MARK: - Get content list details from json file

    func fetchContentList() {
        self.contentListService.readLocalJsonFile("content_list_page_\(self.currentPage)") { response in
            switch response {
            case .success(let contentList):
                if self.contents != nil {
                    self.contents?.append(contentsOf: contentList.page.contentItems.content)
                } else {
                    self.contents = contentList.page.contentItems.content
                }

            case .failure(let error):
                print("Error in fetching content list: \(error)")
            }
        }
    }


    //MARK: - Get content list count

    func getContentListCount() -> Int {
        guard let contents = contents else { return 0 }
        return contents.count
    }


    //MARK: - Get content item

    func getContent(_ indexPath: IndexPath) -> Content? {
        guard let contents = contents else { return nil }
        return contents[indexPath.row]
    }

}
