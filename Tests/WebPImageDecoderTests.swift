//
//  WebPImageDecoderTests.swift
//  Nuke-WebP-Plugin
//
//  Created by nagisa-kosuge on 2018/05/08.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

import XCTest
import Nuke
@testable import NukeWebPPlugin

class WebPImageDecoderTests: XCTestCase {

    private lazy var webpImagePath: URL = {
        let webpImagePath = Bundle(for: type(of: self)).url(forResource: "sample", withExtension: "webp")!
        return webpImagePath
    }()

    private lazy var webpImageURL: URL = URL(string: "https://www.gstatic.com/webp/gallery/1.sm.webp")!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testsProgressiveDecodeWebPImageDecoder() {
        let webpData = try! Data(contentsOf: self.webpImagePath)
        let decoder = NukeWebPPlugin.WebPImageDecoder()
        
        // no image
        XCTAssertNil(decoder.decode(data: webpData[0...500], isFinal: false))
        
        // created image
        let scan1 = decoder.decode(data: webpData[0...3702], isFinal: false)
        XCTAssertNotNil(scan1)
        XCTAssertEqual(scan1!.size.width, 320)
        XCTAssertEqual(scan1!.size.height, 235)
        
        let scan2 = decoder.decode(data: webpData, isFinal: true)
        XCTAssertNotNil(scan2)
        XCTAssertEqual(scan2!.size.width, 320)
        XCTAssertEqual(scan2!.size.height, 235)
    }

    func testsImageDecoderRegistryRegistered() {
        let exception = XCTestExpectation(description: "decode webp image")
        ImagePipeline.shared.loadImage(with: webpImageURL, progress: nil) { (response, error) in
            XCTAssertNil(response)
            XCTAssertNotNil(error)

            WebPImageDecoder.enable()
            ImagePipeline.shared.loadImage(with: self.webpImageURL, progress: nil) { (response, error) in
                XCTAssertNil(error)
                XCTAssertNotNil(response)
                exception.fulfill()
            }
        }

        self.wait(for: [exception], timeout: 1)
    }

}
