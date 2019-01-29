//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by MaxMu on 2018/12/24.
//  Copyright © 2018 MaxProgrammer. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

@property(nonatomic, strong) UIColor *circleColor;

@end

@implementation BNRHypnosisView

- (void)updateCirclrColor:(UIColor *)color {
    [self setCircleColor:color];
}

- (void) setCircleColor:(UIColor *)circleColor {
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置BNRHypnosisView对象的背景颜色为透明
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGRect bounds = self.bounds;
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;

//    float radius = (MIN(bounds.size.width, bounds.size.height)) / 2.0;
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // 以中心点为圆心、radius的值为半径，定义一个0到M_PI*2.0弧度的路径（整圆）
//    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    path.lineWidth = 10;
    
//    [[UIColor lightGrayColor] setStroke];
    
    [self.circleColor setStroke];
    
    // 绘制路径
    [path stroke];
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    // 屏幕宽度
    CGFloat lScreenWidth = self.bounds.size.width;
    CGFloat lScreenHeight = self.bounds.size.height;
    CGFloat imgX = lScreenWidth * 0.2;
    CGFloat imgY = 150;
    CGFloat imgWidth = lScreenWidth - imgX * 2;
    CGFloat imgHeight = imgWidth*1.82;
    
    // MARK: 绘制颜色渐变的矩形，然后对其进行剪切
    CGContextSaveGState(currentContext);
    
    // MARK: 添加剪切区域
    CGMutablePathRef mutPath = CGPathCreateMutable();
    
    // 三角形剪裁区域
    CGPathMoveToPoint(mutPath, NULL, lScreenWidth/2.0, imgY-20);
    CGPathAddLineToPoint(mutPath, NULL, lScreenWidth*0.1, imgY+imgHeight+20);
    CGPathAddLineToPoint(mutPath, NULL, lScreenWidth*0.9, imgY+imgHeight+20);
    
//    // 圆形剪裁区域
//    CGPathAddArc(mutPath, NULL, lScreenWidth/2.0, lScreenHeight/2.0, lScreenWidth/2.0, 0, M_PI*2.0, YES);
    
    CGPathCloseSubpath(mutPath);
    CGContextAddPath(currentContext, mutPath);
    CGContextClip(currentContext);\
    
    // MARK: 在剪裁区域的基础上绘制渐变
    CGFloat locations[3] = {0.0, 1.0};
    CGFloat components[8] = {0.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 0.0, 1.0
    };

    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);

    CGPoint startPoint = CGPointMake(lScreenWidth/2.0, imgY - 20);
    CGPoint endPoint = CGPointMake(lScreenWidth/2.0, imgY+imgHeight+20);
    
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);

    CGContextRestoreGState(currentContext);
    
    // MARK: 绘制图片
    CGContextSaveGState(currentContext); // 保存绘图状态
    
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3); // 设置阴影效果，后面绘制的图像会带有阴影效果
    
    CGRect imgRect = CGRectMake(imgX, imgY, imgWidth, imgHeight);
    UIImage *logoImage = [UIImage imageNamed:@"logoLinear"];
    [logoImage drawInRect:imgRect];
    
//    NSString *logoString = @"";
//    [logoString drawInRect:<#(CGRect)#> withAttributes:<#(nullable NSDictionary<NSAttributedStringKey,id> *)#>];
    
    CGContextRestoreGState(currentContext); // 恢复没有阴影效果的状态，后面绘制的图像没有阴影效果了

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ was touched", self);
    
    // 随机获取3个0到1之间的浮点数
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    self.circleColor = randomColor;
}

@end
