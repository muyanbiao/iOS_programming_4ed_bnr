//
//  ViewController.m
//  Hypnosister
//
//  Created by MaxMu on 2018/12/24.
//  Copyright © 2018 MaxProgrammer. All rights reserved.
//

#import "ViewController.h"
#import "BNRHypnosisView.h"

@interface ViewController ()

@end

@implementation ViewController

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
    
    bigRect.size.width *= 2;
//    bigRect.size.height *= 2;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    [self.view addSubview:scrollView];
    
    BNRHypnosisView *hyponsisView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:hyponsisView];

    screenRect.origin.x += screenRect.size.width;
    BNRHypnosisView *anotherView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:anotherView];
    [scrollView setPagingEnabled:YES];
    [scrollView setPagingEnabled:NO];
    scrollView.contentSize = bigRect.size;
    
}


@end
