//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Max on 2019/7/9.
//  Copyright © 2019 Max. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItem.h"
#import "BNRItemStore.h"

static CGFloat const footerHeight = 44;

@implementation BNRItemsViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i = 0; i < 5; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 按照约定，应该将UITableViewCell或者UITableViewCell子类的类名用作 reuseIdentifier
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    UIView *tableViewBgView = [[UIView alloc] initWithFrame:self.tableView.bounds];
//    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:tableViewBgView.bounds];
//    bgImgView.image = [UIImage imageNamed:@"demo4"e];
//    [tableViewBgView addSubview:bgImgView];
//    self.tableView.backgroundView = tableViewBgView;
}

#pragma mark UITalbeView datasource and delegate

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return @"ValueInDollar > 50";
//    } else {
//        return @"ValueInDollar <= 50";
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        return [[[BNRItemStore sharedStore] valueBiggerThan50Items] count];
//    } else {
//        return [[[BNRItemStore sharedStore] valueSmallerOrEqualTo50Items] count];
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    cell.textLabel.text = [item description];
    
//    NSArray *valueBiggerThan50Items = [[BNRItemStore sharedStore] valueBiggerThan50Items];
//    NSArray *valueSmallerOrEqualTo50Items = [[BNRItemStore sharedStore] valueSmallerOrEqualTo50Items];
//
//    BNRItem *item = nil;
//    if (indexPath.section == 0) {
//        item = valueBiggerThan50Items[indexPath.row];
//    } else {
//        item = valueSmallerOrEqualTo50Items[indexPath.row];
//    }
//
//    cell.textLabel.text = [item description];
//    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (section == 0) {
//        return 0;
//    } else {
//        return footerHeight;
//    }
//
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, footerHeight)];
//
//    UILabel *noMoreItemLabel = [[UILabel alloc] initWithFrame:footerView.bounds];
//    [footerView addSubview:noMoreItemLabel];
//    noMoreItemLabel.textAlignment = NSTextAlignmentCenter;
//    noMoreItemLabel.text = @"No more items!";
//
//    return footerView;
//}

@end
