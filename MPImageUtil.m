//
//  ImageUtils.m
//
//  Created by li haoxiang on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MPImageUtil.h"
#import "MPCoreGraphicsUtil.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation MPImageUtil

+ (UIImage *)resizeForImage:(UIImage *)image toSize:(CGSize)size {

    size_t bitsPerComp = 8; // CGImageGetBitsPerComponent(image.CGImage);
    size_t bytesByRow = 0; // CGImageGetBytesPerRow(image.CGImage);
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 size.width, 
                                                 size.height, 
                                                 bitsPerComp, 
                                                 bytesByRow, 
                                                 CGImageGetColorSpace(image.CGImage), 
                                                 kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), image.CGImage);

    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGContextRelease(context);
    CGImageRelease(newImageRef);
    
    return newImage;
}

+ (UIImage *)resizeImage:(UIImage *)originImage toSize:(CGSize)newSize keepRatio:(BOOL)keepRatio {
    
    CGSize originSize = [originImage size];
    
    if (keepRatio)
    {
        CGFloat widthScale = newSize.width/originSize.width;
        CGFloat heightScale = newSize.height/originSize.height;
        CGFloat scale = MIN(widthScale, heightScale);        
        newSize.width = scale * originSize.width;
        newSize.height = scale * originSize.height;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, newSize.width, newSize.height, 
                                                 8, 
                                                 0,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, newSize.width, newSize.height), originImage.CGImage);
    CGImageRef newImage = CGBitmapContextCreateImage(context);
    UIImage *retImage = [UIImage imageWithCGImage:newImage];
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(newImage);
    CGContextRelease(context);
    return retImage;
}


+ (UIImage *)image:(UIImage *)originImage withBlendMode:(CGBlendMode)blendMode {
    CGSize size = [originImage size];
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 
                                                 CGImageGetBitsPerComponent(originImage.CGImage), 
                                                 CGImageGetBytesPerRow(originImage.CGImage),
                                                 CGImageGetColorSpace(originImage.CGImage),
                                                 CGImageGetBitmapInfo(originImage.CGImage));
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), originImage.CGImage);
    CGContextSetBlendMode(context, blendMode);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), originImage.CGImage);
    CGImageRef newImage = CGBitmapContextCreateImage(context);
    UIImage *retImage = [UIImage imageWithCGImage:newImage];
    CGImageRelease(newImage);
    CGContextRelease(context);
    return retImage;    
}

+ (UIImage *)roundedCornerImage:(UIImage *)originImage {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, originImage.size.width, originImage.size.height,
                                                 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
    [MPCoreGraphicsUtil addRoundedPathInContext:context
                                   WithRect:CGRectMake(0, 0, originImage.size.width, originImage.size.height)
                                borderWidth:2.0f
                                  andRadius:10.0f];
    CGContextClip(context);
    CGContextTranslateCTM(context, 0, originImage.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextDrawImage(context, CGRectMake(0, 0, originImage.size.width, originImage.size.height), originImage.CGImage);
    CGImageRef newImage = CGBitmapContextCreateImage(context);
    UIImage *retImage = [UIImage imageWithCGImage:newImage];
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(newImage);
    CGContextRelease(context);
    return retImage;    
}

@end
