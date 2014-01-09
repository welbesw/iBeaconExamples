//
//  BeaconBroadcastManager.h
//  Beacon
//
//  Created by Will Welbes on 6/26/13.
//

#import <Foundation/Foundation.h>

@interface BeaconBroadcastManager : NSObject

@property(nonatomic, readonly) BOOL isAdvertising;

+(id)sharedInstance;

-(void)startAdvertisingWithMajor:(NSInteger)major minor:(NSInteger)minor;
-(void)stopAdvertising;

@end
