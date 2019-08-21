//
//  CMSPostController.h
//  Reddit-C
//
//  Created by Apps on 8/21/19.
//  Copyright © 2019 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CMSPost;

NS_ASSUME_NONNULL_BEGIN

@interface CMSPostController : NSObject

+ (instancetype)sharedController;

- (void)searchForPostWithSearchTerm:(NSString *)searchTerm completion: (void(^) (NSArray<CMSPost *> *posts, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
