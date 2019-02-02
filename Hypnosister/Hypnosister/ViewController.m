//
//  ViewController.m
//  Hypnosister
//
//  Created by MaxMu on 2018/12/24.
//  Copyright © 2018 MaxProgrammer. All rights reserved.
//

#import "ViewController.h"
#import "BNRHypnosisView.h"

@interface ViewController ()<UIScrollViewDelegate>

// MARK:第7章中级练习：捏合-缩放
@property(nonatomic, strong)BNRHypnosisView *hyponsisView;

@end

@implementation ViewController

- (BNRHypnosisView *)hyponsisView {
    if(!_hyponsisView) {
        CGRect screenRect = self.view.bounds;
        _hyponsisView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    }
    return _hyponsisView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
////    CGRect firstFrame = CGRectMake(160, 240, 100, 150);
//    CGRect firstFrame = self.view.bounds;
//    BNRHypnosisView *firstView = [[BNRHypnosisView alloc] initWithFrame:firstFrame];
////    firstView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:firstView];
    
    CGRect screenRect = self.view.bounds;
    CGRect bigRect = screenRect;
    
//    bigRect.size.width *= 2;
//    bigRect.size.height *= 2;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    [self.view addSubview:scrollView];
    
//    self.hyponsisView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:self.hyponsisView];

//    screenRect.origin.x += screenRect.size.width;
//    BNRHypnosisView *anotherView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
//    [scrollView addSubview:anotherView];
    
    scrollView.delegate = self;
    [scrollView setPagingEnabled:NO];
    scrollView.contentSize = bigRect.size;
    scrollView.minimumZoomScale = 1.0;
    scrollView.maximumZoomScale = 10.0;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.hyponsisView;
}


@end
