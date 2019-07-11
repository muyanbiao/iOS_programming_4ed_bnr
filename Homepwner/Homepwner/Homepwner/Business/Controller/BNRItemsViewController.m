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
#import "BNRDetailViewController.h"

static CGFloat const footerHeight = 60;

@interface BNRItemsViewController ()

#pragma mark IBOutlet
@property(nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController

//- (UIView *)headerView {
//    if (!_headerView) {
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
//    }
//    return _headerView;
//}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
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
    
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
//    UIView *tableViewBgView = [[UIView alloc] initWithFrame:self.tableView.bounds];
//    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:tableViewBgView.bounds];
//    bgImgView.image = [UIImage imageNamed:@"demo4"e];
//    [tableViewBgView addSubview:bgImgView];
//    self.tableView.backgroundView = tableViewBgView;
}

#pragma mark IBAction
- (IBAction)addNewItem:(id)sender {
//    NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    NSInteger itemCount = [[[BNRItemStore sharedStore] allItems] count];
    if (itemCount == 1) {
        NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
        NSIndexPath *indexPathLast = [NSIndexPath indexPathForRow:(lastRow + 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath, indexPathLast] withRowAnimation:UITableViewRowAnimationTop];
    } else {
        NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
    
}

//- (IBAction)toggleEditingMode:(id)sender {
//    if (self.isEditing) {
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//
//        [self setEditing:NO animated:YES];
//    } else {
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//
//        [self setEditing:YES animated:YES];
//    }
//}

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
    NSInteger itemCount = [[[BNRItemStore sharedStore] allItems] count];
//    return itemCount;
    if (itemCount == 0) {
        return 0;
    } else {
        return itemCount + 1;
    }
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
//    cell.textLabel.font = [UIFont systemFontOfSize:12.f];
    cell.textLabel.numberOfLines = 0;
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    NSInteger currentIndexPathRow = indexPath.row;
    NSInteger totalRow = [tableView numberOfRowsInSection:0];
    if (currentIndexPathRow == totalRow - 1) {
        cell.textLabel.text = @"No more item!";
    } else {
        BNRItem *item = items[indexPath.row];
        cell.textLabel.text = [item description];
    }
    
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.row < [tableView numberOfRowsInSection:0] - 1) {
            NSArray *items = [[BNRItemStore sharedStore] allItems];
            BNRItem *item = items[indexPath.row];
            [[BNRItemStore sharedStore] removeItem:item];
            if ([tableView numberOfRowsInSection:0] == 2 && (indexPath.row == [tableView numberOfRowsInSection:0] - 2)) {
                NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
                [tableView deleteRowsAtIndexPaths:@[indexPath, lastIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            } else {
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            
        } else {
            return;
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastRow = [tableView numberOfRowsInSection:0];
    if (indexPath.row == lastRow - 1) return NO;
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [tableView numberOfRowsInSection:0] - 1) {
        return NO;
    }
    return YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    // 禁止移动到最后一个行
    if (proposedDestinationIndexPath.row >= [tableView numberOfRowsInSection:0] - 1) {
        return sourceIndexPath;
    } else {
        return proposedDestinationIndexPath;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
    
//    [tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < [tableView numberOfRowsInSection:0] - 1) {
        BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *selectedItem = items[indexPath.row];
        detailViewController.item = selectedItem;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
////    if (section == 0) {
////        return 0;
////    } else {
////        return footerHeight;
////    }
//    if ([[[BNRItemStore sharedStore] allItems] count] <= 0) return 0;
//    return footerHeight;
//}
//
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
