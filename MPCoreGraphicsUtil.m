//
//  MPCoreGraphicsUtil.m
//
//  Created by li haoxiang on 5/28/11.
//  Copyright 2011 PCIE. All rights reserved.
//

#import "MPCoreGraphicsUtil.h"
#import "MPColorUtil.h"

@implementation MPCoreGraphicsUtil

+ (void)addRoundedPathInContext:(CGContextRef)context WithRect:(CGRect)rect borderWidth:(CGFloat)borderWidth andRadius:(CGFloat)radius {
    
    CGRect newRect = CGRectInset(rect, borderWidth/2, borderWidth/2);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(radius, radius)];
    CGContextBeginPath(context);
    CGContextAddPath(context, path.CGPath);
    CGContextClosePath(context);
}

+ (void)fillInContext:(CGContextRef)context rect:(CGRect)rect withGradient:(CGGradientRef)gradient {
    CGPoint startP = CGPointMake(rect.origin.x + rect.size.width/2.0f, rect.origin.y);
    CGPoint endP = CGPointMake(rect.origin.x + rect.size.width/2.0f, rect.origin.y + rect.size.height);    
    CGContextDrawLinearGradient(context, gradient, startP, endP, 0);    
}

+ (CGGradientRef)createGradientFromColorTop:(UIColor *)colorTop colorBottom:(UIColor *)colorBottom {
    
    CGFloat colors[8];
    const CGFloat *colorComponentsTop = CGColorGetComponents(colorTop.CGColor);
    const CGFloat *colorComponentsBottom = CGColorGetComponents(colorBottom.CGColor);
    int colorTopLen = CGColorGetNumberOfComponents(colorTop.CGColor);
    int colorBottomLen = CGColorGetNumberOfComponents(colorBottom.CGColor); 
    
    //< Copy colorTop
    for (int i = 0; i < 4; i++)
    {
        colors[i] = ((i < colorTopLen) ? colorComponentsTop[i] : 1.0f);
    }
    
    //< Copy colorBottom
    for (int i = 0; i < 4; i++)
    {
        colors[i+4] = ((i < colorBottomLen) ? colorComponentsBottom[i] : 1.0f);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    
    CGColorSpaceRelease(colorSpace);
    
    return gradient;
}

+ (void)addText:(NSString *)text alignmentRightInContext:(CGContextRef)context
      withColor:(UIColor *)color
        andFont:(UIFont *)font 
         inRect:(CGRect)contentRect {
    CGContextSaveGState(context);
    CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0f, -1.0f));
    CGContextSetFillColorWithColor(context, color.CGColor);
    UIGraphicsPushContext(context);
    CGSize s = [text sizeWithFont:font];
    //< Right Alignment
    [text drawInRect:CGRectMake(contentRect.origin.x + (contentRect.size.width - s.width),
                                contentRect.origin.y + (contentRect.size.height - s.height)/2.0f,
                                s.width, s.height) withFont:font
       lineBreakMode:NSLineBreakByCharWrapping
           alignment:NSTextAlignmentRight];
    UIGraphicsPopContext();
    CGContextRestoreGState(context);
}

+ (void)addText:(NSString *)text alignmentLeftInContext:(CGContextRef)context
      withColor:(UIColor *)color
        andFont:(UIFont *)font 
         inRect:(CGRect)contentRect {
    CGContextSaveGState(context);
    CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0f, -1.0f));
    CGContextSetFillColorWithColor(context, color.CGColor);
    UIGraphicsPushContext(context);
    CGSize s = [text sizeWithFont:font];
    //< Right Alignment
    [text drawInRect:CGRectMake(contentRect.origin.x,
                                contentRect.origin.y + (contentRect.size.height - s.height)/2.0f,
                                s.width, s.height) withFont:font
       lineBreakMode:NSLineBreakByCharWrapping
           alignment:NSTextAlignmentLeft];
    UIGraphicsPopContext();
    CGContextRestoreGState(context);
}

+ (void)addText:(NSString *)text alignmentCenterInContext:(CGContextRef)context
      withColor:(UIColor *)color
        andFont:(UIFont *)font 
         inRect:(CGRect)contentRect {
    CGContextSaveGState(context);
    CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0f, -1.0f));
    CGContextSetFillColorWithColor(context, color.CGColor);
    UIGraphicsPushContext(context);
    CGSize s = [text sizeWithFont:font];
    //< Right Alignment
    [text drawInRect:CGRectMake(contentRect.origin.x + (contentRect.size.width - s.width)/2.0f,
                                contentRect.origin.y + (contentRect.size.height - s.height)/2.0f,
                                s.width, s.height) withFont:font
       lineBreakMode:NSLineBreakByCharWrapping
           alignment:NSTextAlignmentCenter];
    UIGraphicsPopContext();
    CGContextRestoreGState(context);
}

+ (void)renderCenterCircleGradient:(CGContextRef)context
                              rect:(CGRect)rect
                    outerColorCode:(int)outerColor
                    innerColorCode:(int)innerColor
                            radius:(float)radius
                           options:(CGGradientDrawingOptions)options {
    
    CGPoint centerPt = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    CGFloat components[8];
    
    [MPColorUtil colorComponentsFromHex:innerColor
                             components:components];
    [MPColorUtil colorComponentsFromHex:outerColor
                             components:components+4];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, NULL, 2);
    
    CGContextDrawRadialGradient(context,
                                gradient,
                                centerPt,
                                0,
                                centerPt, radius,
                                options);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

+ (void)renderCenterCircleGradient:(CGContextRef)context
                              rect:(CGRect)rect
                    outerColorCode:(int)outerColor
                    innerColorCode:(int)innerColor
                            radius:(float)radius {
    [self renderCenterCircleGradient:context
                                rect:rect
                      outerColorCode:outerColor
                      innerColorCode:innerColor
                              radius:radius
                             options:kCGGradientDrawsAfterEndLocation];
}

+ (void)renderCenterCircleGradient:(CGContextRef)context
                              rect:(CGRect)rect
                    outerColorCode:(int)outerColor
                    innerColorCode:(int)innerColor {
    
    float radius = MAX(CGRectGetWidth(rect), CGRectGetHeight(rect))/2.0;
    [self renderCenterCircleGradient:context
                                rect:rect
                      outerColorCode:outerColor
                      innerColorCode:innerColor
                              radius:radius];
}

+ (void)addRectangleInContext:(CGContextRef)context
                 bottomCenter:(CGPoint)bottomCenter
              withBottomWidth:(CGFloat)bottomWidth
                   withHeight:(CGFloat)height
             withExtendHeight:(CGFloat)extHeight
                    direction:(CGFloat)arcInRad
               rotationCenter:(CGPoint)rotationCtr {

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(bottomCenter.x - extHeight, bottomCenter.y + bottomWidth/2)];
    [path addLineToPoint:CGPointMake(bottomCenter.x + height, bottomCenter.y)];
    [path addLineToPoint:CGPointMake(bottomCenter.x - extHeight, bottomCenter.y - bottomWidth/2)];
    [path closePath];
    [path applyTransform:
     CGAffineTransformTranslate
     (CGAffineTransformRotate
      (CGAffineTransformMakeTranslation
       (rotationCtr.x,
        rotationCtr.y), arcInRad),
      -rotationCtr.x,
      -rotationCtr.y)];
    CGContextAddPath(context, path.CGPath);
}

+ (void)addLineInContext:(CGContextRef)context
                 bottomCenter:(CGPoint)bottomCenter
                   withHeight:(CGFloat)height
             withExtendHeight:(CGFloat)extHeight
                    direction:(CGFloat)arcInRad
               rotationCenter:(CGPoint)rotationCtr {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(bottomCenter.x - extHeight, bottomCenter.y)];
//    [path addLineToPoint:CGPointMake(bottomCenter.x + height, bottomCenter.y)];
    [path addLineToPoint:CGPointMake(bottomCenter.x + height, bottomCenter.y)];
//    [path closePath];
    [path applyTransform:
     CGAffineTransformTranslate
     (CGAffineTransformRotate
      (CGAffineTransformMakeTranslation
       (rotationCtr.x,
        rotationCtr.y), arcInRad),
      -rotationCtr.x,
      -rotationCtr.y)];
    CGContextAddPath(context, path.CGPath);
}

@end

