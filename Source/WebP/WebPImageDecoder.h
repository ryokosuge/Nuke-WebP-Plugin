//
//  WebPImageDecoder.h
//  Nuke-WebP-Plugin
//
//  Created by ryokosuge on 2018/01/17.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

#import "WebPImageMacros.h"

#if WEBP_IMAGE_MAC
    #import <AppKit/AppKit.h>
    #define Image   NSImage
#else
    #import <UIKit/UIKit.h>
    #define Image   UIImage
#endif

@interface WebPImageDecoder : NSObject
+ (nullable Image *)decodeData:(nonnull NSData *)data;
@end
