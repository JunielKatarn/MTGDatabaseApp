//
//  Children.m
//  Generated by JSON Toolbox - http://itunes.apple.com/app/json-toolbox/id525015412
//
//  Created by kylehankinson on Jun 5, 2012
//

#import "Children.h"
#import "MTGRules.h"
#import "Children.h"

@implementation Children

@synthesize section, text, children;

+ (NSArray*) ChildrenWithArray: (NSArray*) array
{
    NSMutableArray * resultsArray = [[NSMutableArray alloc] init];

    for(id entry in array)
    {
        if(![entry isKindOfClass: [NSDictionary class]]) continue;

        [resultsArray addObject: [Children ChildrenWithDictionary: entry]];
    }

    return JSONAutoRelease(resultsArray);
} // End of ChildrenWithArray


+ (NSArray*) ChildrenArrayWithJSONString: (NSString *) jsonString usingEncoding: (NSStringEncoding) stringEncoding error: (NSError**) error
{
    NSData * jsonData = [jsonString dataUsingEncoding: stringEncoding];

    NSArray * jsonArray = [NSJSONSerialization JSONObjectWithData: jsonData
                                                      options: 0
                                                        error: error];

    if(nil != error && nil != jsonArray)
    {
        return [Children ChildrenWithArray: jsonArray];
    }

    return nil;
} // End of MTGRulesWithArray

+ (Children *)ChildrenWithDictionary:(NSDictionary *)dictionary
{
    Children *instance = [[Children alloc] initWithDictionary: dictionary];
    return JSONAutoRelease(instance);
} // End of ChildrenWithDictionary

+ (Children *)ChildrenWithJSONString: (NSString *) jsonString usingEncoding: (NSStringEncoding) stringEncoding error: (NSError**) error
{
    NSData * jsonData = [jsonString dataUsingEncoding: stringEncoding];

    NSDictionary * jsonDictionary = [NSJSONSerialization JSONObjectWithData: jsonData
                                                                    options: 0
                                                                      error: error];

    if(nil != error && nil != jsonDictionary)
    {
        return [Children ChildrenWithDictionary: jsonDictionary];
    }

    return nil;
} // End of ChildrenWithJSONString

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self)
    {
        if(nil != [dictionary objectForKey: @"section"])
        {
            self.section = [dictionary objectForKey: @"section"];
        }

        if(nil != [dictionary objectForKey: @"text"])
        {
            self.text = [dictionary objectForKey: @"text"];
        }

        if(nil != [dictionary objectForKey: @"children"])
        {
            self.children = [Children ChildrenWithArray: [dictionary objectForKey: @"children"]];
        }


    }

    return self;
} // End of initWithDictionary

- (NSString*) description
{
    NSMutableString * descriptionOutput = [[NSMutableString alloc] init];
    [descriptionOutput appendFormat: @"section = \"%@\"\r\n", section];
    [descriptionOutput appendFormat: @"text = \"%@\"\r\n", text];
    [descriptionOutput appendFormat: @"children = \"%@\"\r\n", children];

    return JSONAutoRelease(descriptionOutput);
} // End of description

- (void)dealloc
{
#if ! __has_feature(objc_arc)
	[section release];
	[text release];
	[children release];

    [super dealloc];
#endif
} // End of dealloc

@end
