//
//  WebPDecodeTests.swift
//  Nuke-WebP-PluginTests iOS
//
//  Created by nagisa-kosuge on 2018/01/25.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

import XCTest
import Nuke
@testable import NukeWebPPlugin

class WebPDecodeTests: XCTestCase {

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
    
    func testsDecodeWebPImage() {
        let webpData = try! Data(contentsOf: self.webpImagePath)
        let image: UIImage? = UIImage(data: webpData)
        XCTAssertNil(image)
        
        let decoder = NukeWebPPlugin.WebPDataDecoder();
        let webpImage: UIImage? = decoder.decode(webpData)
        XCTAssertNotNil(webpImage)
    }

    func testsDecodeNotWebPImage() {
        let gifData = try! Data(contentsOf: self.gifImagePath)
        let image: UIImage? = UIImage(data: gifData)
        XCTAssertNotNil(image)

        let decoder = NukeWebPPlugin.WebPDataDecoder();
        let webpImage: UIImage? = decoder.decode(gifData)
        XCTAssertNil(webpImage)
    }

    func testsProgressiveDecodeWebPImage() {
        let webpData = try! Data(contentsOf: self.webpImagePath)
        let decoder = NukeWebPPlugin.WebPDataDecoder();
        // no image
        XCTAssertNil(decoder.incrementallyDecode(webpData[0...500], isFinal: false))

        // created image
        let scan1 = decoder.incrementallyDecode(webpData[0...3702], isFinal: false)
        XCTAssertNotNil(scan1)
        XCTAssertEqual(scan1!.size.width, 320)
        XCTAssertEqual(scan1!.size.height, 235)

        let scan2 = decoder.incrementallyDecode(webpData, isFinal: true)
        XCTAssertNotNil(scan2)
        XCTAssertEqual(scan2!.size.width, 320)
        XCTAssertEqual(scan2!.size.height, 235)
    }
    
    func testPerformanceDecodeWebP() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let webpData = try! Data(contentsOf: self.webpImagePath)
            let image: UIImage? = UIImage(data: webpData)
            XCTAssertNil(image)

            let decoder = NukeWebPPlugin.WebPDataDecoder();
            let webpImage: UIImage? = decoder.decode(webpData)
            XCTAssertNotNil(webpImage)
        }
    }
    
}
