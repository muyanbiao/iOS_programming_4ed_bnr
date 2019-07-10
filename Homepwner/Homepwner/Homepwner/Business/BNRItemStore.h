//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Max on 2019/7/9.
//  Copyright © 2019 Max. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

NS_ASSUME_NONNULL_BEGIN

@interface BNRItemStore : NSObject

@property(nonatomic, readonly) NSArray *allItems;

+(instancetype)sharedStore;

- (BNRItem *)createItem;

- (NSArray *)valueBiggerThan50Items;
- (NSArray *)valueSmallerOrEqualTo50Items;

@end

NS_ASSUME_NONNULL_END
