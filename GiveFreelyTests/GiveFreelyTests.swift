//
//  GiveFreelyTests.swift
//  GiveFreelyTests
//
//  Created by Matheus Weber on 28/01/24.
//

import XCTest
@testable import GiveFreely_Extension

final class GiveFreelyTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHandleMessageSendsResultMessage() {
        let handler = SafariWebExtensionHandler()

        handler.beginRequest(with: NSExtensionContext())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
