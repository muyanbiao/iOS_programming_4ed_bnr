//
//  UIImage+ImageFromColor.m
//  HypnoNerd
//
//  Created by MaxMu on 2019/1/29.
//  Copyright © 2019 MaxProgrammer. All rights reserved.
//

#import "UIImage+ImageFromColor.h"

@implementation UIImage (ImageFromColor)

#pragma mark 把颜色转换成图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
