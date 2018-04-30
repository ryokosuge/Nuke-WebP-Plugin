//
//  WebPImage.swift
//  Nuke-WebP-Plugin
//
//  Created by ryokosuge on 2018/01/17.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

import Foundation
import Nuke

public struct WebPImageDecoder: Nuke.ImageDecoding {

    public init() {
    }

    public func decode(data: Data, isFinal: Bool) -> Image? {
        guard !isFinal else { return _decode(data) }

        if !data.isWebPFormat {
            return nil
        }
        return _decode(data)
    }

}

private let _queue = DispatchQueue(label: "com.github.ryokosuge.Nuke-WebP-Plugin.DataDecoder")

internal func _decode(_ data: Data) -> Image? {
    return _queue.sync {
        return WebPDataDecoder.decode(data)
    }
}

// MARK: - WebP Format Testing
extension Data {
    // Borrow from KingfisherWebp
    // https://github.com/Yeatse/KingfisherWebP/blob/master/KingfisherWebP/Classes/Image%2BWebP.swift#L38
    var isWebPFormat: Bool {
        if count < 12 {
            return false
        }
        
        let endIndex = index(startIndex, offsetBy: 12)
        let testData = subdata(in: startIndex..<endIndex)
        guard let testString = String(data: testData, encoding: .ascii) else {
            return false
        }
        
        if testString.hasPrefix("RIFF") && testString.hasSuffix("WEBP") {
            return true
        } else {
            return false
        }
    }
}
