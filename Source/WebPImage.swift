//
//  WebPImage.swift
//  Nuke-WebP-Plugin iOS
//
//  Created by ryokosuge on 2018/01/17.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

import UIKit
import Nuke

public class WebPImage: NSObject {

    public override init() {
        super.init()
    }

}

public struct WebPDataDecoder: Nuke.DataDecoding {

    public func decode(data: Data, response: URLResponse) -> Image? {
        return decodeWebPData(data)
    }

    internal func decodeWebPData(_ webpData: Data) -> Image? {
        return WebPImageDecoder.decode(webpData)
    }

}
