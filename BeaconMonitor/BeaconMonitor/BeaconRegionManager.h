//
//  BeaconRegionManager.h
//  Beacon
//
//  Created by Will Welbes on 6/25/13.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@protocol BeaconRegionManagerDelegate;

@interface BeaconRegionManager : NSObject

@property (nonatomic, strong) NSArray * beacons;
@property (nonatomic, assign) id<BeaconRegionManagerDelegate> delegate;

+(id)sharedInstance;

-(void)startBeaconMonitoring;
-(void)stopBeaconMonitoring;

@end

@protocol BeaconRegionManagerDelegate <NSObject>

-(void)beaconRegionManager:(BeaconRegionManager*)beaconRegionManager didRangeBeacons:(NSArray*)beacons;

@end
