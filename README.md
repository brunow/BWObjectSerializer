## BWObjectSerializer

Small library that transform an object into a dictionary that can be send to a web service.

Work well with string, number and date others data must be converted. By default date are parsed with the rails date time format.

## An object

	Item *item = [[Item alloc] init];
    item.title = @"Title";
    item.itemID = [NSNumber numberWithInt:15];
    item.createdAt = [NSDate date];

## Serializing mapping

    [BWObjectSerializerMapping mappingForObject:[Item class] block:^(BWObjectSerializerMapping *serializer) {
        [serializer mapKeyPath:@"title" toAttribute:@"title"];
        [serializer mapKeyPath:@"itemID" toAttribute:@"id"];
        
        [serializer mapKeyPath:@"imagePath" toAttribute:@"image_url" valueBlock:^id(id value, id object) {
            return @"custom value";
        }];
        
        [serializer mapKeyPath:@"createdAt" toAttribute:@"created_at" withDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        
        [[BWObjectSerializer shared] registerSerializer:serializer withRootKeyPath:@"item"];
    }];

## Serialize the object

	NSDictionary *dict = [[BWObjectSerializer shared] serializeObject:item];

Or

	NSDictionary *dict [[BWObjectSerializer shared] serializeObject:item withMapping:mapping];

Will generate this dictionary:

	{
    		item =     {
        		"created_at" = "2012-07-20T21:56:26Z";
        		"image_url" = "custom value";
        		title = Title;
    		};
	}

## Installation

**Copy BWObjectSerializer dir** into your **project**.

Or with **Cocoapods**

	pod 'BWObjectSerializer', :git => "https://github.com/brunow/BWObjectSerializer.git", :tag => "0.1.1"

## ARC

BWObjectSerializer is ARC only.

## Contact

Bruno Wernimont

- Twitter - [@brunowernimont](http://twitter.com/brunowernimont)

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/brunow/bwobjectserializer/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

