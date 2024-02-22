//
//  ContentListViewModelTest.swift
//  DiagnalTestTests
//
//  Created by Roster Buster on 17/02/24.
//

import XCTest
@testable import DiagnalTest

final class ContentListViewModelTests: XCTestCase {

    var sut: ContentListViewModel!
    var mockService: MockService!

    /// Setup
    override func setUp() {
        super.setUp()
        
        mockService = MockService()
        sut = ContentListViewModel(contentListService: mockService)
    }

    /// TearDown
    override func tearDown() {
        super.tearDown()

        mockService = nil
        sut = nil
    }


    /// Test to check if json file is present or not
    func testJsonFileNotFound() {
        /// Given
        mockService.mockResult = .failure(.jsonFileNotfound)

        /// When
        sut.fetchContentList()

        /// Then
        guard let contents = sut.contents else { return }
        XCTAssertTrue(contents.isEmpty)
    }


    /// Test to see if the content file  has valid json
    func testReadContentListFromJsonFile() {
        ///Given
        guard let contentList = mockService.getContentList() else { return }
        mockService.mockResult = .success(contentList)

        ///When
        sut.fetchContentList()

        /// Then
        guard let contents = sut.contents else { return }
        XCTAssert(!contents.isEmpty)
    }

}


