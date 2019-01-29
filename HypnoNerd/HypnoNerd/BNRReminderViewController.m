//
//  BNRRemiderViewController.m
//  HypnoNerd
//
//  Created by MaxMu on 2019/1/28.
//  Copyright © 2019 MaxProgrammer. All rights reserved.
//

#import "BNRReminderViewController.h"

@implementation BNRReminderViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi = self.tabBarItem;
        
        tbi.title = @"Reminder";
        tbi.image = [UIImage imageNamed:@"Time.png"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

- (IBAction)addRemider:(id)sender {
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a remider for %@", date);
    
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"Hypnotize me!";
    note.fireDate = date;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

@end
