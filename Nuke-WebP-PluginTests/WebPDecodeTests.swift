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
        do {
            let webpData = try Data(contentsOf: self.webpImagePath)
            let image: UIImage? = UIImage(data: webpData)
            XCTAssertNil(image)
            
            let decoder = NukeWebPPlugin.WebPDataDecoder();
            let webpImage: Image? = decoder.decode(webpData)
            XCTAssertNotNil(webpImage)
        } catch let e {
            XCTFail(e.localizedDescription)
        }
    }

    func testsDecodeNotWebPImage() {
        do {
            let gifData = try Data(contentsOf: self.gifImagePath)
            let image: UIImage? = UIImage(data: gifData)
            XCTAssertNotNil(image)
            
            let decoder = NukeWebPPlugin.WebPDataDecoder();
            let webpImage: Image? = decoder.decode(gifData)
            XCTAssertNil(webpImage)
        } catch let e {
            XCTFail(e.localizedDescription)
        }
    }
    
    func testPerformanceDecodeWebP() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            do {
                let webpData = try Data(contentsOf: self.webpImagePath)
                let image: UIImage? = UIImage(data: webpData)
                XCTAssertNil(image)
                
                let decoder = NukeWebPPlugin.WebPDataDecoder();
                let webpImage: Image? = decoder.decode(webpData)
                XCTAssertNotNil(webpImage)
            } catch let e {
                XCTFail(e.localizedDescription)
            }
        }
    }
    
}
