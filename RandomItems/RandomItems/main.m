//
//  main.m
//  RandomItems
//
//  Created by MaxMu on 2018/12/24.
//  Copyright © 2018 MaxProgrammer. All rights reserved.
//

//#import <Foundation/Foundation.h>
@import Foundation;
#import "BNRItem.h"
#import "BNRContainer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *items = [[NSMutableArray alloc] init];
////        [items addObject:@"One"];
////        [items addObject:@"Two"];
////        [items addObject:@"Three"];
////        [items insertObject:@"Zero" atIndex:0];
////
////        for (NSString *item in items) {
////            NSLog(@"%@", item);
////        }
////
////        BNRItem *item = [[BNRItem alloc] initWithItemName:@"Red sofa"
////                                           valueInDollars:100
////                                             serialNumber:@"A1B2C"];
////        item.itemName = @"Red sofa";
////        item.serialNumber = @"A1B2C";
////        item.valueInDollars = 100;
//
////        NSLog(@"%@ %@ %@ %d", item.itemName, item.dateCreated, item.serialNumber, item.valueInDollars);
//
//        for (int i = 0; i < 10; i++) {
//            BNRItem *item = [BNRItem randomItem];
//            [items addObject:item];
//        }
//
//        BNRContainer *itemContainer = [BNRContainer randomItem];
//        itemContainer.subItems = items;
//        NSLog(@"%@", itemContainer);
//
////        BNRItem *lastObj = [items lastObject];
////        [lastObj count];
//
////        for (BNRItem *item in items) {
////            NSLog(@"%@", item);
////        }
//
//        NSLog(@"Setting items to nil...");
//        items = nil;
        
        BNRItem *backpack = [[BNRItem alloc] initWithItemName:@"Backpack"];
        [items addObject:backpack];
        
        BNRItem *calculator = [[BNRItem alloc] initWithItemName:@"Calculator"];
        [items addObject:calculator];
        
        backpack.containedItem = calculator;
        
        backpack = nil;
        calculator = nil;
        
        for (BNRItem *item in items) {
            NSLog(@"%@", item);
        }
        
        NSLog(@"Setting items to nil...");
        items = nil;
        
    }
    
    sleep(100);
    return 0;
}

