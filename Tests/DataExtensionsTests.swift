//
//  DataExtensionsTests.swift
//  Nuke-WebP-Plugin
//
//  Created by nagisa-kosuge on 2018/05/08.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

import XCTest
@testable import NukeWebPPlugin

class DataExtensionsTests: XCTestCase {

    private lazy var webpImagePath: URL = {
        let webpImagePath = Bundle(for: type(of: self)).url(forResource: "sample", withExtension: "webp")!
        return webpImagePath
    }()
    
    private lazy var gifImagePath: URL = {
        let gifImagePath = Bundle(for: type(of: self)).url(forResource: "sample", withExtension: "gif")!
        return gifImagePath
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testsDataIsWebPFormat() {
        let webpData = try! Data(contentsOf: self.webpImagePath)
        XCTAssertTrue(webpData.isWebPFormat)

        let gifData = try! Data(contentsOf: self.gifImagePath)
        XCTAssertFalse(gifData.isWebPFormat)
    }

    func testsNoData() {
        let data = Data(count: 0)
        XCTAssertFalse(data.isWebPFormat)
    }

}
