//
//  CMSPostController.m
//  Reddit-C
//
//  Created by Apps on 8/21/19.
//  Copyright © 2019 Apps. All rights reserved.
//

#import "CMSPostController.h"
#import "CMSPost.h"

@implementation CMSPostController

+ (CMSPostController *) sharedController
{
    static CMSPostController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [CMSPostController new];
    });
    return shared;
}

+ (NSURL *)baseURL
{
    return [NSURL URLWithString: @"https://reddit.com/r"];
}

- (void)searchForPostWithSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<CMSPost *> *, NSError *))completion
{
    // 1. Build URL (components and extentions - reddit's url doesn't use queryitems)
    // 2. NSURLSession dataTask
    // 3. Handle the completion (error and data)
    // 4. PARSE the data that came back from the data task
    // 5. Initialize our object
    // 6. Call completion
    
    NSURL *urlPlusComponents = [[CMSPostController baseURL] URLByAppendingPathComponent:searchTerm];
    NSURL *builtURL = [urlPlusComponents URLByAppendingPathExtension:@"json"];
    
    [[NSURLSession.sharedSession dataTaskWithURL:builtURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@, %@", error, error.localizedDescription);
            return completion(nil, [NSError errorWithDomain:@"Error fetching JSON" code:(NSInteger)-1 userInfo:nil]);
        }
        
        if (!data) {
            NSLog(@"Error receiving data: %@, %@", error, error.localizedDescription);
            return completion(nil, error);
        }
        // Create an array for initialized posts to be placed into.
        NSMutableArray *postArray = [NSMutableArray new];
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            // ...drilling down...
        NSDictionary *dataDictionary = topLevelDictionary[@"data"];
            // ...drilling down...
        NSArray *childrenArray = dataDictionary[@"children"];
            // ...drilling down...
        for (NSDictionary *postDataDictionary in childrenArray) {
            // Initializing the object.
            CMSPost *post = [[CMSPost alloc] initWithDictionary:postDataDictionary];
            [postArray addObject:post];
            completion(postArray, nil);
        }
    }]resume];
}
@end
