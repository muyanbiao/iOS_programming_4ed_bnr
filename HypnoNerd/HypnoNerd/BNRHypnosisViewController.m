//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by MaxMu on 2019/1/28.
//  Copyright © 2019 MaxProgrammer. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"
#import "UIImage+ImageFromColor.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate, UIScrollViewDelegate>

@end

@implementation BNRHypnosisViewController

// MARK: VC的初始化方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // MARK: 设置当前页面的tabBarItem的标题和图片
        self.tabBarItem.title  = @"Hypnotize";
        
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        
        self.tabBarItem.image = i;
        
    }
    return self;
}

- (void)loadView {
    // MARK: 设置当前页面的根View
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:frame];
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    [backgroundView addSubview:textField];
    
    self.view = backgroundView;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    
    // MARK: 设置UISegmentedControl
    UIImage *redImage = [UIImage imageWithColor:[UIColor redColor]];
    UIImage *greenImage = [UIImage imageWithColor:[UIColor greenColor]];
    UIImage *blueImage = [UIImage imageWithColor:[UIColor blueColor]];
    
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:@[redImage, greenImage, blueImage]];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    segControl.frame = CGRectMake(0, screenHeight - 148, screenWidth, 60);
    
    [self.view addSubview:segControl];
    [segControl addTarget:nil action:@selector(selectSegItem:) forControlEvents:UIControlEventValueChanged];
    
//    UIButton *btn = [[UIButton alloc] init];
//    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

//- (void)btnAction:(UIButton *)sender {
//
//}

#pragma mark Asks the delegate if the text field should process the pressing of the return button.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    NSLog(@"%@", textField.text);
    [self drawHypnoticeMessage:textField.text];
    
    textField.text = @"";
    [textField resignFirstResponder]; // 放弃第一响应者r身份，关闭键盘
    return YES;
}

-(void)selectSegItem:(UISegmentedControl *)segControl {
    NSInteger selectedSegmentIndex = segControl.selectedSegmentIndex;
    NSLog(@"selectedSegmentIndex = %ld", (long)selectedSegmentIndex);
    
    BNRHypnosisView *backgroundView = (BNRHypnosisView *)self.view;
    
    // MARK: 这里用到了KVC(Key-Value Coding) - 键值对编码
    if (selectedSegmentIndex == 0) {
//        [backgroundView updateCirclrColor:[UIColor redColor]];
        [backgroundView setValue:[UIColor redColor] forKey:@"circleColor"];
    } else if (selectedSegmentIndex == 1) {
//        [backgroundView updateCirclrColor:[UIColor greenColor]];
        [backgroundView setValue:[UIColor greenColor] forKey:@"circleColor"];
    } else if (selectedSegmentIndex == 2) {
//        [backgroundView updateCirclrColor:[UIColor blueColor]];
        [backgroundView setValue:[UIColor redColor] forKey:@"circleColor"];
    }
}

#pragma mark 在随机位置绘制20个UILabel
- (void)drawHypnoticeMessage:(NSString *)message {
    for (int i = 0; i < 20; i++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        
        [messageLabel sizeToFit];
        
        // MARK: 获取随机x坐标
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        
        // MARK: 获取随机y坐标
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        
        // MARK: 设置UIlabel对象的frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        [self.view addSubview:messageLabel];
        
        // MARK: 添加运动效果（Motion Effects）
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
    }
}


@end
