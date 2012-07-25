#import "Kiwi.h"

#import "BWObjectSerializer.h"
#import "Item.h"
#import "Item2.h"

#define DATE_FORMAT @"yyyy-MM-dd'T'HH:mm:ss'Z'"

NSString* FormattedStringDate(NSDate *date, NSString *dateFormat) {
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    [formatter setCalendar:cal];
    [formatter setLocale:[NSLocale currentLocale]];
    NSString *stringDate = [formatter stringFromDate:date];
    return stringDate;
}

SPEC_BEGIN(BWObjectSerializerSpecs)

describe(@"serializing", ^{
    
    __block Item *item;
    __block Item2 *item2;
    
    beforeAll(^{
        item = [[Item alloc] init];
        item.title = @"Title";
        item.emptyString = @"";
        item.itemID = [NSNumber numberWithInt:15];
        item.createdAt = [NSDate date];
        
        item2 = [[Item2 alloc] init];
        item2.itemID = [NSNumber numberWithInt:15];
        
        [BWObjectSerializerMapping mappingForObject:[Item class] block:^(BWObjectSerializerMapping *serializer) {
            [serializer mapKeyPath:@"title" toAttribute:@"title"];
            [serializer mapKeyPath:@"itemID" toAttribute:@"id"];
            
            [serializer mapKeyPath:@"imagePath" toAttribute:@"image_url" valueBlock:^id(id value, id object) {
                return @"custom value";
            }];
            
            [serializer mapKeyPath:@"createdAt" toAttribute:@"created_at" withDateFormat:DATE_FORMAT];
            
            [[BWObjectSerializer shared] registerSerializer:serializer withRootKeyPath:@"item"];
        }];
        
        [BWObjectSerializerMapping mappingForObject:[Item2 class] block:^(BWObjectSerializerMapping *serializer) {
            [serializer mapKeyPath:@"itemID" toAttribute:@"id"];
            
            [[BWObjectSerializer shared] registerSerializer:serializer];
        }];
    });
    
    it(@"should serialize object from mapping with a root keyPath", ^{
        NSDictionary *value = [[BWObjectSerializer shared] serializeObject:item];
        
        NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
                                  item.title, @"title",
                                  item.itemID, @"id",
                                  @"custom value", @"image_url",
                                  FormattedStringDate(item.createdAt, DATE_FORMAT), @"created_at",
                                  nil];
        
        expected = [NSDictionary dictionaryWithObject:expected forKey:@"item"];
        
        [[value should] equal:expected];
    });
    
    it(@"should serialize object from mapping without root keyPath", ^{
        NSDictionary *value = [[BWObjectSerializer shared] serializeObject:item2];
        
        NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
                                  item2.itemID, @"id",
                                  nil];
        
        [[value should] equal:expected];
    });
    
    it(@"should serialize empty string", ^{
        __block BWObjectSerializerMapping *objectSerializer = nil;
        [BWObjectSerializerMapping mappingForObject:[Item class] block:^(BWObjectSerializerMapping *serializer) {
            [serializer mapKeyPath:@"emptyString" toAttribute:@"empty_string"];
            objectSerializer = serializer;
        }];
        
        NSDictionary *value = [[BWObjectSerializer shared] serializeObject:item withMapping:objectSerializer];
        
        NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
                                  nil];
        
        [[value should] equal:expected];
    });
    
});

SPEC_END