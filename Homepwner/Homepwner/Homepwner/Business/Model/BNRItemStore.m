//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Max on 2019/7/9.
//  Copyright © 2019 Max. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

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
//    NSMutableArray *mutArr = [NSMutableArray array];
//    if ([self.privateItems count] <= 0) {
//        return self.privateItems;
//    } else {
//        [mutArr addObjectsFromArray:self.privateItems];
//        BNRItem *item = [[BNRItemStore sharedStore] createItem];
//        [mutArr addObject:item];
//        return mutArr;
//    }
    
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

- (void)removeItem:(BNRItem *)item {
    NSString *key = item.itemKey;
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) return;
    BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    if (toIndex > [self.privateItems count]) return;
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
