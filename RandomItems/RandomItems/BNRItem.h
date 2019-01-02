//
//  BNRItem.h
//  RandomItems
//
//  Created by MaxMu on 2018/12/24.
//  Copyright © 2018 MaxProgrammer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRItem : NSObject

@property(nonatomic, copy) NSString *itemName;
@property(nonatomic, copy) NSString *serialNumber;
@property(nonatomic) int valueInDollars;
@property(nonatomic, readonly, strong) NSDate *dateCreated;

// 这两个变量是用来测试强引用和弱引用的
@property(nonatomic, strong) BNRItem *containedItem;
@property(nonatomic, weak) BNRItem *container;

+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;

-(instancetype)initWithItemName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
