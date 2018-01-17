//
//  Nuke_WebP_PluginTests.swift
//  Nuke-WebP-PluginTests
//
//  Created by ryokosuge on 2018/01/17.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

import XCTest
import Nuke
@testable import NukeWebPPlugin

class Nuke_WebP_PluginTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testsNotDecodeWebPImage() {
        guard let url = URL(string: "https://www.gstatic.com/webp/gallery/1.sm.webp") else {
            XCTFail("not support url format.")
            return
        }

        let exception = XCTestExpectation(description: "not decode webp image")
        Nuke.Manager.shared.loadImage(with: url) {[exception] (result) in
            XCTAssertNil(result.value)
            exception.fulfill()
        }
        self.wait(for: [exception], timeout: 1)
    }

    func testsDecodeWebPImage() {
        guard let webpImagePath = Bundle(for: type(of: self)).url(forResource: "sample", withExtension: "webp") else {
            XCTFail("not found \"sample.webp\".")
            return
        }
        
        do {
            let webpData = try Data(contentsOf: webpImagePath)
            let image: UIImage? = UIImage(data: webpData)
            XCTAssertNil(image)

            let webpImage: Image? = NukeWebPPlugin.WebPImageDecoder.decode(webpData)
            XCTAssertNotNil(webpImage)

        } catch let e {
            XCTFail(e.localizedDescription)
        }
    }

}
