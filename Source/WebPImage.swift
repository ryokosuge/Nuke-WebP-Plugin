//
//  WebPImage.swift
//  Nuke-WebP-Plugin
//
//  Created by ryokosuge on 2018/01/17.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

import Foundation
import Nuke

public class WebPImageDecoder: Nuke.ImageDecoding {

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

extension WebPImageDecoder {

    public static func isWebPFormat(data: Data) -> Bool {
        return data.isWebPFormat
    }

}

private let _queue = DispatchQueue(label: "com.github.ryokosuge.Nuke-WebP-Plugin.DataDecoder")

internal func _decode(_ data: Data) -> Image? {
    return _queue.sync {
        return WebPDataDecoder.decode(data)
    }
}
