//
//  SwiftGenExampleLibraryTests.swift
//  
//
//  Created by Eric Hyche on 5/4/22.
//

import XCTest
@testable import SwiftGenExampleLibrary

class SwiftGenExampleLibraryTests: XCTestCase {

    func testExample() throws {
        XCTAssertEqual(SomeLibraryFile.someString(), "Orientation Continue Noomin’!")
    }

    func testImages() throws {
        let imageSize = SomeLibraryFile.someImage().size
        XCTAssert(imageSize != CGSize.zero, "Expected image to have non-zero size, but it did not.")
    }
}
