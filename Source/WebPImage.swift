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

    private lazy var decoder: WebPDataDecoder = WebPDataDecoder()

    public init() {
    }

    public func decode(_ data: Data) -> ImageContainer? {
        guard data.isWebPFormat else { return nil }
        guard let image = _decode(data) else { return nil }
        return ImageContainer(image: image)
    }

    public func decodePartiallyDownloadedData(_ data: Data) -> ImageContainer? {
        guard data.isWebPFormat else { return nil }
        guard let image = decoder.incrementallyDecode(data) else { return nil }
        return ImageContainer(image: image)
    }

}

// MARK: - check webp format data.
extension WebPImageDecoder {

    public static func enable() {
        Nuke.ImageDecoderRegistry.shared.register { (context) -> ImageDecoding? in
            WebPImageDecoder.enable(context: context)
        }
    }

    public static func enable(context: Nuke.ImageDecodingContext) -> Nuke.ImageDecoding? {
        return context.data.isWebPFormat ? WebPImageDecoder() : nil
    }

}

// MARK: - private
private let _queue = DispatchQueue(label: "com.github.ryokosuge.Nuke-WebP-Plugin.DataDecoder")

extension WebPImageDecoder {

    private func _decode(_ data: Data) -> PlatformImage? {
        return _queue.sync {
            return decoder.decode(data)
        }
    }

}
