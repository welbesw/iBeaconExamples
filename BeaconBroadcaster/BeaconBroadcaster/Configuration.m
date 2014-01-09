//
//  Configuration.m
//  Beacon
//
//  Created by Will Welbes on 6/26/13.
//  Copyright (c) 2013 Centare. All rights reserved.
//

#import "Configuration.h"

@implementation Configuration

@synthesize shouldBroadcast = _shouldBroadcast;
@synthesize majorValue = _majorValue;
@synthesize minorValue = _minorValue;

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedConfiguration = nil;
    dispatch_once(&pred, ^{
        _sharedConfiguration = [[self alloc] init];
    });
    return _sharedConfiguration;
}

-(BOOL)shouldBroadcast
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"ShouldBroadcast"];
}

-(void)setShouldBroadcast:(BOOL)shouldBroadcast
{
    [[NSUserDefaults standardUserDefaults] setBool:shouldBroadcast forKey:@"ShouldBroadcast"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSNumber*)majorValue
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"MajorValue"];
}

-(void)setMajorValue:(NSNumber *)majorValue
{
    [[NSUserDefaults standardUserDefaults] setObject:majorValue forKey:@"MajorValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSNumber*)minorValue
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"MinorValue"];
}

-(void)setMinorValue:(NSNumber *)minorValue
{
    [[NSUserDefaults standardUserDefaults] setObject:minorValue forKey:@"MinorValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
