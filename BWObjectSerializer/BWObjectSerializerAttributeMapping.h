//
//  BWObjectSerializerAttributeMapping.h
//  Notepad
//
//  Created by Bruno Wernimont on 18/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BWObjectSerializerBlocks.h"

@interface BWObjectSerializerAttributeMapping : NSObject

@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, copy) NSString *attribute;
@property (nonatomic, copy) BWObjectSerializeValueBlock valueBlock;
@property (nonatomic, copy) NSString *dataFormat;

+ (id)attributeMapping;

@end
