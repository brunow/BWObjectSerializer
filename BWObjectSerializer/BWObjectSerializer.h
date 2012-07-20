//
//  BWObjectSerializer.h
//  Notepad
//
//  Created by Bruno Wernimont on 18/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BWObjectSerializerMapping.h"

@interface BWObjectSerializer : NSObject

/**
 Date format that will be used if no date format is specified on the mapping
 */
@property (nonatomic, strong) NSString *defaultDateFormat;

/**
 Shared instance
 */
+ (BWObjectSerializer *)shared;

/**
 Register an object serialize with a root json key path
 @param serializer Object serializer
 @param keyPath Root json key path thath will be used to known which serializer to use
 */
- (void)registerSerializer:(BWObjectSerializerMapping *)serializer withRootKeyPath:(NSString *)keyPath;

/**
 Serialize the object into a dictionary
 @param object Any object
 @param mapping The serializer to use to convert the object into dictionary
 */
- (NSDictionary *)serializeObject:(id)object withMapping:(BWObjectSerializerMapping *)mapping;


/**
 Serialize the object into a dictionary. You need to have added the right mapping serializer.
 @param object Any object mapped into the serialize
 */
- (NSDictionary *)serializeObject:(id)object;

@end
