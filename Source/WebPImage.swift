//
//  WebPImage.swift
//  Nuke-WebP-Plugin
//
//  Created by ryokosuge on 2018/01/17.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

import Foundation
import Nuke

public class WebPImage: NSObject {
}

public extension WebPImage {

    public static let manager: Nuke.Manager = {
        let dataDecoder = Nuke.DataDecoder()
        let webpDataDecoder = WebPDataDecoder()
        let decoder = Nuke.DataDecoderComposition(decoders: [dataDecoder, webpDataDecoder])
        let loader = Nuke.Loader(loader: DataLoader(), decoder: decoder)
        return Nuke.Manager(loader: loader)
    }()

}

public struct WebPDataDecoder: Nuke.DataDecoding {

    public func decode(data: Data, response: URLResponse) -> Image? {
        return decodeWebPData(data)
    }

    internal func decodeWebPData(_ webpData: Data) -> Image? {
        return WebPImageDecoder.decode(webpData)
    }

}
