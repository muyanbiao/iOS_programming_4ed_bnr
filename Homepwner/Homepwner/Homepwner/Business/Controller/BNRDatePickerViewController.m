//
//  BNRDatePickerViewController.m
//  Homepwner
//
//  Created by Max on 2019/7/11.
//  Copyright © 2019 Max. All rights reserved.
//

#import "BNRDatePickerViewController.h"
#import "BNRItem.h"

@interface BNRDatePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation BNRDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.item && self.item.dateCreated) {
        self.datePicker.date = self.item.dateCreated;
    }
}

- (IBAction)onDateChanged:(UIDatePicker *)sender {
    NSDate *selectedDate = sender.date;
    self.selectedDate = selectedDate;
    NSLog(@"selectedDate:%@", self.selectedDate);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.selectedDate && self.item) {
        self.item.dateCreated = self.selectedDate;
    }
}

@end
