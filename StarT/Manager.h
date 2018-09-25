//
//  Manager.h
//  StarT
//
//  Created by Tima on 25.09.2018.
//  Copyright © 2018 Timofey Gritkevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject

+(Manager*) shared;
-(void) getImage: (NSString *) urlString  completionBlock:(void (^)(NSData *image))completionBlock;

@end
