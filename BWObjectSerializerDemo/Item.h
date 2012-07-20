//
//  Item.h
//  BWObjectSerializerDemo
//
//  Created by Bruno Wernimont on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *itemID;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *imagePath;

@end
