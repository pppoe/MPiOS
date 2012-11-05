//
//  MPCoreGraphicsUtil.h
//
//  Created by li haoxiang on 5/28/11.
//  Copyright 2011 PCIE. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

@interface MPCoreGraphicsUtil : NSObject {
    
}

+ (void)addRoundedPathInContext:(CGContextRef)context
                       WithRect:(CGRect)rect
                    borderWidth:(CGFloat)borderWidth
                      andRadius:(CGFloat)radius;
+ (CGGradientRef)createGradientFromColorTop:(UIColor *)colorTop colorBottom:(UIColor *)colorBottom;
+ (void)fillInContext:(CGContextRef)context rect:(CGRect)rect withGradient:(CGGradientRef)gradient;

+ (void)addText:(NSString *)text alignmentRightInContext:(CGContextRef)context
      withColor:(UIColor *)color
        andFont:(UIFont *)font
         inRect:(CGRect)contentRect;

+ (void)addText:(NSString *)text alignmentCenterInContext:(CGContextRef)context
      withColor:(UIColor *)color
        andFont:(UIFont *)font
         inRect:(CGRect)contentRect;

//< Circle Center Gradient
+ (void)renderCenterCircleGradient:(CGContextRef)context
                              rect:(CGRect)rect
                    outerColorCode:(int)outerColor
                    innerColorCode:(int)innerColor;

+ (void)renderCenterCircleGradient:(CGContextRef)context
                              rect:(CGRect)rect
                    outerColorCode:(int)outerColor
                    innerColorCode:(int)innerColor
                            radius:(float)radius;

+ (void)renderCenterCircleGradient:(CGContextRef)context
                              rect:(CGRect)rect
                    outerColorCode:(int)outerColor
                    innerColorCode:(int)innerColor
                            radius:(float)radius
                           options:(CGGradientDrawingOptions)options;

+ (void)addRectangleInContext:(CGContextRef)context
                 bottomCenter:(CGPoint)bottomCenter
              withBottomWidth:(CGFloat)bottomWidth
                   withHeight:(CGFloat)height
             withExtendHeight:(CGFloat)extHeight
                    direction:(CGFloat)arcInRad
               rotationCenter:(CGPoint)rotationCtr;

+ (void)addLineInContext:(CGContextRef)context
            bottomCenter:(CGPoint)bottomCenter
              withHeight:(CGFloat)height
        withExtendHeight:(CGFloat)extHeight
               direction:(CGFloat)arcInRad
          rotationCenter:(CGPoint)rotationCtr;

@end


