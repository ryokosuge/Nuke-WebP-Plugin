//
//  WebPDataDecoder.m
//  Nuke-WebP-Plugin iOS
//
//  Created by nagisa-kosuge on 2018/04/30.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

#import "WebPDataDecoder.h"
#import "webp/decode.h"

void free_image_data(void *info, const void *data, size_t size) {
    if (info != NULL) {
        WebPFreeDecBuffer(&((WebPDecoderConfig *) info)->output);
        free(info);
    }
    
    WebPFree((void *)data);
}

@implementation WebPDataDecoder

+ (Image *)decodeData:(NSData *)data {
    WebPBitstreamFeatures features;
    if (WebPGetFeatures([data bytes], [data length], &features) != VP8_STATUS_OK) {
        return nil;
    }
    
    int width = 0, height = 0;
    uint8_t *webpData = NULL;
    int pixelLength = 0;
    
    if (features.has_alpha) {
        webpData = WebPDecodeRGBA([data bytes], [data length], &width, &height);
        pixelLength = 4;
    } else {
        webpData = WebPDecodeRGB([data bytes], [data length], &width, &height);
        pixelLength = 3;
    }
    
    if (!webpData) {
        return nil;
    }
    
    CGDataProviderRef providerRef = CGDataProviderCreateWithData(NULL,
                                                                 webpData,
                                                                 width * height * pixelLength,
                                                                 free_image_data);
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    if (features.has_alpha) {
        bitmapInfo |= kCGImageAlphaLast;
    } else {
        bitmapInfo |= kCGImageAlphaNone;
    }
    
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGImageRef imageRef = CGImageCreate(width,
                                        height,
                                        8,
                                        8 * pixelLength,
                                        pixelLength * width,
                                        colorSpaceRef,
                                        bitmapInfo,
                                        providerRef,
                                        NULL,
                                        NO,
                                        renderingIntent);
    Image *image = nil;
    
#if WEBP_IMAGE_MAC
    image = [[NSImage alloc] initWithCGImage: imageRef size: CGSizeZero];
#else
    image = [UIImage imageWithCGImage:imageRef];
#endif
    
    CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(providerRef);
    
    return image;
}

@end
