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
        let decoder = Nuke.DataDecoderComposition(decoders: [webpDataDecoder, dataDecoder])
        let loader = Nuke.Loader(loader: DataLoader(), decoder: decoder)
        return Nuke.Manager(loader: loader)
    }()

}

public struct WebPDataDecoder: Nuke.DataDecoding {
    
    // Refer to https://github.com/kean/Nuke-Gifu-Plugin/blob/master/Source/AnimatedImage.swift#L64
    public init() {}
    
    public func decode(data: Data, response: URLResponse) -> Image? {
        if !data.isWebPFormat {
            return nil
        }
        return decodeWebPData(data)
    }
    
    internal func decodeWebPData(_ webpData: Data) -> Image? {
        return WebPImageDecoder.decode(webpData)
    }
}

// MARK: - WebP Format Testing
extension Data {
    // Borrwo from KingfisherWebp
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
