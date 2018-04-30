//
//  Data+WebPFormat.swift
//  Nuke-WebP-Plugin iOS
//
//  Created by nagisa-kosuge on 2018/04/30.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

import Foundation

// MARK: - WebP Format Testing
extension Data {

    // Borrow from KingfisherWebp
    // https://github.com/Yeatse/KingfisherWebP/blob/master/KingfisherWebP/Classes/Image%2BWebP.swift#L38
    internal var isWebPFormat: Bool {
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
