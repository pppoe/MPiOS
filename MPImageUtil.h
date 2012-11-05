//
//  ImageUtils.h
//
//  Created by li haoxiang on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MPImageUtil : NSObject {

}

+ (UIImage *)resizeForImage:(UIImage *)image toSize:(CGSize)size;
+ (UIImage *)image:(UIImage *)originImage withBlendMode:(CGBlendMode)blendMode;
+ (UIImage *)resizeImage:(UIImage *)originImage toSize:(CGSize)newSize keepRatio:(BOOL)keepRatio;
+ (UIImage *)roundedCornerImage:(UIImage *)originImage;

@end
