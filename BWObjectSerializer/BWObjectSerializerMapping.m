//
//  BWObjectSerializerMapping.m
//  Notepad
//
//  Created by Bruno Wernimont on 18/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BWObjectSerializerMapping.h"

#import "BWObjectSerializerAttributeMapping.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface BWObjectSerializerMapping ()

- (void)addAttributeMappingToObjectMapping:(BWObjectSerializerAttributeMapping *)attributeMapping;

@end


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BWObjectSerializerMapping

@synthesize objectClass = _objectClass;
@synthesize attributeMappings = _attributeMappings;
@synthesize rootKeyPath = _rootKeyPath;


////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithObjectClass:(Class)objectClass {
    self = [self init];
    if (self) {
        self.objectClass = objectClass;
        _attributeMappings = [[NSMutableDictionary alloc] init];
    }
    return self;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)mappingForObject:(Class)objectClass block:(void(^)(BWObjectSerializerMapping *serializer))block {
    BWObjectSerializerMapping *mapping = [[self alloc] initWithObjectClass:objectClass];
    block(mapping);
    return mapping;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)mapKeyPath:(NSString *)keyPath toAttribute:(NSString *)attribute {
    BWObjectSerializerAttributeMapping *attributeMapping = [BWObjectSerializerAttributeMapping attributeMapping];
    attributeMapping.keyPath = keyPath;
    attributeMapping.attribute = attribute;
    
    [self addAttributeMappingToObjectMapping:attributeMapping];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)mapKeyPath:(NSString *)keyPath toAttribute:(NSString *)attribute withDateFormat:(NSString *)dateFormat {
    BWObjectSerializerAttributeMapping *attributeMapping = [BWObjectSerializerAttributeMapping attributeMapping];
    attributeMapping.keyPath = keyPath;
    attributeMapping.attribute = attribute;
    attributeMapping.dataFormat = dateFormat;
    
    [self addAttributeMappingToObjectMapping:attributeMapping];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)mapKeyPath:(NSString *)keyPath
       toAttribute:(NSString *)attribute
       valueBlock:(BWObjectSerializeValueBlock)valueBlock {
    
    BWObjectSerializerAttributeMapping *attributeMapping = [BWObjectSerializerAttributeMapping attributeMapping];
    attributeMapping.keyPath = keyPath;
    attributeMapping.attribute = attribute;
    attributeMapping.valueBlock = valueBlock;
    
    [self addAttributeMappingToObjectMapping:attributeMapping];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addAttributeMappingToObjectMapping:(BWObjectSerializerAttributeMapping *)attributeMapping {
    [self.attributeMappings setObject:attributeMapping forKey:attributeMapping.attribute];
}


@end
