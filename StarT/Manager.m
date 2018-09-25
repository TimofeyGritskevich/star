//
//  Manager.m
//  StarT
//
//  Created by Tima on 25.09.2018.
//  Copyright © 2018 Timofey Gritkevich. All rights reserved.
//

#import "Manager.h"

@implementation Manager

static Manager * sharedManager = nil;

+(Manager*) shared {
    if (sharedManager == nil){
        sharedManager = [[super allocWithZone : NULL] init];
    }
    return sharedManager;
}

- (void) getImage: (NSString *) urlString  completionBlock:(void (^)(NSData *image))completionBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSURL *imageURL = [NSURL URLWithString:urlString];
                       NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                       completionBlock(imageData);
                   });
}

@end
