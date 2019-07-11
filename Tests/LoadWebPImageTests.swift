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
        Nuke.ImagePipeline.shared.loadImage(with: self.webpImageURL) { (result) in
            switch result {
            case .success:
                XCTFail("Should fail because it does not correspond to WebP")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            exception.fulfill()
        }
        self.wait(for: [exception], timeout: 5)
    }
    
    func testsLoadWebPImage() {
        let exception = XCTestExpectation(description: "decode webp image")
        ImageDecoderRegistry.shared.register { (context) -> ImageDecoding? in
            return WebPImageDecoder.enable(context: context)
        }

        Nuke.ImagePipeline.shared.loadImage(with: self.webpImageURL) { (result) in
            switch result {
            case .success(let imageResponse):
                XCTAssertNotNil(imageResponse.image)
            case .failure:
                XCTFail("Should not fail because it does correspond to WebP")
            }
            exception.fulfill()
        }

        self.wait(for: [exception], timeout: 5)
    }

}
