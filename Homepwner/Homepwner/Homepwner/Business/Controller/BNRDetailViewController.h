//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by Max on 2019/7/10.
//  Copyright © 2019 Max. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem;

NS_ASSUME_NONNULL_BEGIN

@interface BNRDetailViewController : UIViewController

@property (nonatomic, strong) BNRItem *item;

@end

NS_ASSUME_NONNULL_END
