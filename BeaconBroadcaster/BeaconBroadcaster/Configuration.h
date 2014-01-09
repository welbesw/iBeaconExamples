//
//  Configuration.h
//  Beacon
//
//  Created by Will Welbes on 6/26/13.
//  Copyright (c) 2013 Centare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configuration : NSObject

@property(nonatomic, assign) BOOL shouldBroadcast;
@property(nonatomic, assign) NSNumber * majorValue;
@property(nonatomic, assign) NSNumber * minorValue;

+(id)sharedInstance;

@end
