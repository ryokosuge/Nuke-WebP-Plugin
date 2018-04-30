//
//  LoadWebPImageTests.swift
//  Nuke-WebP-PluginTests iOS
//
//  Created by nagisa-kosuge on 2018/01/25.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

import XCTest
import Nuke
@testable import NukeWebPPlugin

class LoadWebPImageTests: XCTestCase {

    private lazy var webpImageURL: URL = URL(string: "https://www.gstatic.com/webp/gallery/1.sm.webp")!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testsFailLoadWebPImage() {
        let exception = XCTestExpectation(description: "not decode webp image")
        Nuke.ImagePipeline.shared.loadImage(with: self.webpImageURL) { (imageResponse, error) in
            /// It is an error because it does not correspond to WebP
            guard let e = error else {
                XCTFail()
                return
            }

            print(e)
            exception.fulfill()
        }
        self.wait(for: [exception], timeout: 1)
    }
    
    func testsLoadWebPImage() {
        let exception = XCTestExpectation(description: "decode webp image")
        ImageDecoderRegistry.shared.register { (context) -> ImageDecoding? in
            return WebPImageDecoder.enable(context: context)
        }

        Nuke.ImagePipeline.shared.loadImage(with: self.webpImageURL) { (imageResponse, error) in
            if let e = error {
                XCTFail(e.localizedDescription)
                exception.fulfill()
                return
            }
            
            XCTAssertNotNil(imageResponse?.image)
            exception.fulfill()
        }

        self.wait(for: [exception], timeout: 1)
    }

}
