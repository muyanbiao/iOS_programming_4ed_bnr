//
//  BNRContainer.h
//  RandomItems
//
//  Created by MaxMu on 2018/12/24.
//  Copyright © 2018 MaxProgrammer. All rights reserved.
//

#import "BNRItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNRContainer : BNRItem

@property(nonatomic, strong) NSMutableArray *subItems;

@end

NS_ASSUME_NONNULL_END
