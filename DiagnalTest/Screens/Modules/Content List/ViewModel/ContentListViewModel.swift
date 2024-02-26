//
//  ContentListViewModel.swift
//  DiagnalTest
//
//  Created by Sweta Jaiswal on 26/02/24.
//

import Foundation
import UIKit

class ContentListViewModel {

    //MARK: - Variables
    var currentPage = 1
    var didReceiveContents: (()->())?
    var didReceiveError: (()->()) = {}

    private var contentListService: ContentListProtocol
    private(set) var filteredContents: [Content] = []

    var contents: [Content] = [] {
        didSet {
            self.didReceiveContents?()
        }
    }


    /// Init
    init(contentListService: ContentListProtocol = ContentListService()) {
        self.contentListService = contentListService
        self.fetchContentList()
    }


    //MARK: - Get content list details from json file

    func fetchContentList() {
        self.contentListService.readLocalJsonFile("content_list_page_\(self.currentPage)") { response in
            
            switch response {
            case .success(let contentList):
                if (self.contents.count) > 0 {
                    self.contents.append(contentsOf: contentList.page.contentItems.content)
                } else {
                    self.contents = contentList.page.contentItems.content
                }
                
            case .failure(let error):
                print("Error in fetching content list: \(error)")
                self.didReceiveError()
            }
        }
    }


    //MARK: - Get content list count
    
    func getContentListCount() -> Int {
        return contents.count
    }
}


//MARK: - Search functions

extension ContentListViewModel {
    
    public func inSearchMode(_ searchBar: UISearchBar) -> Bool {
        let isActive = searchBar.isFirstResponder
        let searchText = searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchList(searchBarText: String?) {
        self.filteredContents = contents
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else {
                self.didReceiveContents?()
                return
            }
            
            self.filteredContents = self.filteredContents.filter {
                $0.name.lowercased().contains(searchText)
            }
        }
    
        self.didReceiveContents?()
    }
}
