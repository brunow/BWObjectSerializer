//
//  BWObjectSerializerAttributeMapping.m
//  Notepad
//
//  Created by Bruno Wernimont on 18/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BWObjectSerializerAttributeMapping.h"


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BWObjectSerializerAttributeMapping

@synthesize keyPath;
@synthesize attribute;
@synthesize valueBlock;
@synthesize dataFormat;


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)attributeMapping {
    BWObjectSerializerAttributeMapping *mapping = [[self alloc] init];
    return mapping;
}


@end
