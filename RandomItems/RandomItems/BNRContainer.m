//
//  BNRContainer.m
//  RandomItems
//
//  Created by MaxMu on 2018/12/24.
//  Copyright © 2018 MaxProgrammer. All rights reserved.
//

#import "BNRContainer.h"

@implementation BNRContainer

- (NSString *)description
{
    int totalValueInDollars = 0;
    for (BNRItem *item in self.subItems) {
        totalValueInDollars += item.valueInDollars;
    }
    totalValueInDollars += self.valueInDollars;
    
    return [NSString stringWithFormat:@"%@ %d %@", self.itemName, totalValueInDollars, self.subItems];
}

@end
