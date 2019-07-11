//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Max on 2019/7/11.
//  Copyright © 2019 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRImageStore : NSObject

+(instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
