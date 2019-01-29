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
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];
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


@end
