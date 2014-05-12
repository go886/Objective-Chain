//
//  OCATransformer+UIImage.m
//  Objective-Chain
//
//  Created by Martin Kiss on 12.5.14.
//  Copyright (c) 2014 Martin Kiss. All rights reserved.
//

#import <UIKit/UIGraphics.h>
#import "OCATransformer+UIImage.h"
#import "OCAGeometry+Functions.h"











@implementation OCATransformer (UIImage)





+ (OCATransformer *)resizeImageTo:(CGSize)size scale:(CGFloat)scale {
    return [[OCATransformer fromClass:[UIImage class] toClass:[UIImage class]
                           transform:^UIImage *(UIImage *input) {
                               if ( ! input) return nil;
                               if (input.images) return nil; // Do not resize animated images
                               
                               CGRect rect = (CGRect){
                                   .origin = CGPointZero,
                                   .size = size,
                               };
                               
                               UIGraphicsBeginImageContextWithOptions(size, NO, scale ?: input.scale);
                               [input drawInRect:rect blendMode:kCGBlendModeNormal alpha:1];
                               UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
                               UIGraphicsEndImageContext();
                               
                               return [resized imageWithRenderingMode:input.renderingMode];
                               
                           } reverse:OCATransformationPass]
            describe:[NSString stringWithFormat:@"resize image to %@", OCAStringFromSize(size)]
            reverse:@"pass"];
}


+ (OCATransformer *)clipImageTo:(UIBezierPath *)path {
    return [[OCATransformer fromClass:[UIImage class] toClass:[UIImage class]
                            transform:^UIImage *(UIImage *input) {
                                if ( ! input) return nil;
                                if ( ! path) return nil;
                                
                                UIGraphicsBeginImageContextWithOptions(input.size, NO, input.scale);
                                [path addClip];
                                [input drawAtPoint:CGPointZero];
                                UIImage *clipped = UIGraphicsGetImageFromCurrentImageContext();
                                UIGraphicsEndImageContext();
                                
                                return [clipped imageWithRenderingMode:input.renderingMode];
                                
                            } reverse:OCATransformationPass]
            describe:@"clip image"
            reverse:@"pass"];
}


+ (OCATransformer *)clipImageToCircle {
    // Since path is constructed from image's size, can't call +clipImageTo:
    return [[OCATransformer fromClass:[UIImage class] toClass:[UIImage class]
                            transform:^UIImage *(UIImage *input) {
                                if ( ! input) return nil;
                                
                                CGRect rect = (CGRect){
                                    .origin = CGPointZero,
                                    .size = input.size,
                                };
                                UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
                                
                                UIGraphicsBeginImageContextWithOptions(input.size, NO, input.scale);
                                [path addClip];
                                [input drawAtPoint:CGPointZero];
                                UIImage *clipped = UIGraphicsGetImageFromCurrentImageContext();
                                UIGraphicsEndImageContext();
                                
                                return clipped;
                                
                            } reverse:OCATransformationPass]
            describe:@"clip image to circle"
            reverse:@"pass"];
}


+ (OCATransformer *)setImageRenderingMode:(UIImageRenderingMode)mode {
    return [[OCATransformer fromClass:[UIImage class] toClass:[UIImage class]
                            transform:^UIImage *(UIImage *input) {
                                
                                return [input imageWithRenderingMode:mode];
                                
                            } reverse:OCATransformationPass]
            describe:@"set rendering mode"
            reverse:@"pass"];
}





@end




