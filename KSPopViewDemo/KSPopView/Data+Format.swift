//
//  NSData+Format.swift
//  KSPopViewDemo
//
//  Created by keyser_soz on 2017/4/7.
//  Copyright © 2017年 keyser_soz. All rights reserved.
//

import Foundation

private let pngHeader: [UInt8] = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
private let jpgHeaderSOI: [UInt8] = [0xFF, 0xD8]
private let jpgHeaderIF: [UInt8] = [0xFF]
private let gifHeader: [UInt8] = [0x47, 0x49, 0x46]

enum ImageFormat {
    case Unknown, PNG, JPEG, GIF
}

extension Data {
    var ks_imageFormat: ImageFormat {
        var buffer = [UInt8](repeating: 0, count: 8)
//        self.getBytes(buffer, length: 8)
        self.copyBytes(to: &buffer, count: 8)
        if buffer == pngHeader {
            return .PNG
        } else if buffer[0] == jpgHeaderSOI[0] &&
            buffer[1] == jpgHeaderSOI[1] &&
            buffer[2] == jpgHeaderIF[0]
        {
            return .JPEG
        } else if buffer[0] == gifHeader[0] &&
            buffer[1] == gifHeader[1] &&
            buffer[2] == gifHeader[2]
        {
            return .GIF
        }
        
        return .Unknown
    }
}
