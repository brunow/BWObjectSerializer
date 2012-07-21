#import "Kiwi.h"

#import "BWObjectSerializer.h"
#import "Item.h"

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
    
    beforeAll(^{
        item = [[Item alloc] init];
        item.title = @"Title";
        item.itemID = [NSNumber numberWithInt:15];
        item.createdAt = [NSDate date];
        
        [BWObjectSerializerMapping mappingForObject:[Item class] block:^(BWObjectSerializerMapping *serializer) {
            [serializer mapKeyPath:@"title" toAttribute:@"title"];
            [serializer mapKeyPath:@"itemID" toAttribute:@"id"];
            
            [serializer mapKeyPath:@"imagePath" toAttribute:@"image_url" valueBlock:^id(id value, id object) {
                return @"custom value";
            }];
            
            [serializer mapKeyPath:@"createdAt" toAttribute:@"created_at" withDateFormat:DATE_FORMAT];
            
            [[BWObjectSerializer shared] registerSerializer:serializer withRootKeyPath:@"item"];
        }];
    });
    
    it(@"should serialize object from mapping", ^{
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
    
});

SPEC_END