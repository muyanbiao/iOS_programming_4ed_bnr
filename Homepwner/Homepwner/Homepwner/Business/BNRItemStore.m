//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Max on 2019/7/9.
//  Copyright © 2019 Max. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property(nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore {
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Sigleton"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (NSArray *)valueBiggerThan50Items {
    NSMutableArray *mutArray = [NSMutableArray array];
    for (BNRItem *item in self.privateItems) {
        if (item.valueInDollars > 50) {
            [mutArray addObject:item];
        }
    }
    return mutArray;
}

- (NSArray *)valueSmallerOrEqualTo50Items {
    NSMutableArray *mutArray = [NSMutableArray array];
    for (BNRItem *item in self.privateItems) {
        if (item.valueInDollars <= 50) {
            [mutArray addObject:item];
        }
    }
    return mutArray;
}

- (BNRItem *)createItem {
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

@end
