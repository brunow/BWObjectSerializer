//
//  BWObjectSerializerMapping.h
//  Notepad
//
//  Created by Bruno Wernimont on 18/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BWObjectSerializerBlocks.h"

@interface BWObjectSerializerMapping : NSObject

@property (nonatomic, assign) Class objectClass;
@property (nonatomic, readonly, strong) NSMutableDictionary *attributeMappings;

/**
 Object json root key path
 */
@property (nonatomic, copy) NSString *rootKeyPath;

- (id)initWithObjectClass:(Class)objectClass;

/**
 Create a mapping serializer
 @param objectClass The class that you want to serialize
 */
+ (id)mappingForObject:(Class)objectClass block:(void(^)(BWObjectSerializerMapping *serializer))block;

/**
 Add an attribute mapping to the serializer
 @param keyPath The object keypath
 @param attribute The name of dictionary key
 */
- (void)mapKeyPath:(NSString *)keyPath toAttribute:(NSString *)attribute;

/**
 Add an attribute mapping to the serializer
 @param keyPath The object keypath
 @param attribute The name of dictionary key
 @param dateFormat Specific date format for this attribute
 */
- (void)mapKeyPath:(NSString *)keyPath toAttribute:(NSString *)attribute withDateFormat:(NSString *)dateFormat;

/**
 Add an attribute mapping to the serializer
 @param keyPath The object keypath
 @param attribute The name of dictionary key
 @param valueBlock Before add value to the dictionary you can perform some action on the value
 */
- (void)mapKeyPath:(NSString *)keyPath
       toAttribute:(NSString *)attribute
       valueBlock:(BWObjectSerializeValueBlock)valueBlock;

@end
