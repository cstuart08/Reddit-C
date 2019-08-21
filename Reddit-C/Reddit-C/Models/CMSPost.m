//
//  CMSPost.m
//  Reddit-C
//
//  Created by Apps on 8/21/19.
//  Copyright © 2019 Apps. All rights reserved.
//

#import "CMSPost.h"

@implementation CMSPost

-(instancetype)initWithTitle:(NSString *)title commentCount:(NSNumber *)commentCount ups:(NSNumber *)ups
{
    self = [super init];
    
    if (self) {
        _title = title;
        _commentCount = commentCount;
        _ups = ups;
    }
    return self;
}


@end

@implementation CMSPost (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    // This is the data for the object's properties (lower level dictionary).
    NSDictionary *dataDictionary = dictionary[@"data"];
    
    // Digging deeper to initialize our object.
    // Get the actual properties from the JSON.
    NSString *title = dataDictionary[[CMSPost titleKey]];
    NSNumber *commentCount = dataDictionary[[CMSPost commentCountKey]];
    NSNumber *ups = dataDictionary[[CMSPost upsKey]];
    
    return [self initWithTitle:title commentCount:commentCount ups:ups];
}

+ (NSString *) titleKey
{
    return @"title";
}

+ (NSString *) commentCountKey
{
    return @"num_comments";
}

+ (NSString *) upsKey
{
    return @"ups";
}
@end
