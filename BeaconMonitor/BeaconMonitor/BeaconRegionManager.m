//
//  BeaconRegionManager.m
//  Beacon
//
//  Created by Will Welbes on 6/25/13.
//

#import "BeaconRegionManager.h"

@interface BeaconRegionManager()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic, strong) CLBeaconRegion * beaconRegion;

@end

@implementation BeaconRegionManager

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedBeaconManager = nil;
    dispatch_once(&pred, ^{
        _sharedBeaconManager = [[self alloc] init];
    });
    return _sharedBeaconManager;
}

-(id)init
{
    self = [super init];
    if(self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

-(void)startBeaconMonitoring
{
    //Register the UUID beacon region to be monitoring
    //NOTE: The UUID defined here must match the UUID that is being broadcast by your iBeacon broadcaster
    NSUUID * uuid = [[NSUUID alloc] initWithUUIDString:@"BEE44022-97E5-4F0C-A100-0C43C114CCF5"];
    
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"TestBeacon"];
    self.beaconRegion.notifyEntryStateOnDisplay = YES;
    
    //Tell iOS to monitor for the beacon specified and alert us when one comes in range or goes out
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}

-(void)stopBeaconMonitoring
{
    //Stop the region monitoring
    if(self.locationManager != nil && self.beaconRegion != nil) {
        [self.locationManager stopMonitoringForRegion:self.beaconRegion];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region
{
    NSLog(@"didEnterRegion: %@", region.identifier);
    
    //If we've entered a beacon region, start ranging the beacons
    if([region isKindOfClass:[CLBeaconRegion class]] && [region.identifier isEqualToString:self.beaconRegion.identifier]) {
        CLBeaconRegion * beaconRegion = (CLBeaconRegion*)region;
        [self.locationManager startRangingBeaconsInRegion:beaconRegion];
    }
}

- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region
{
    NSLog(@"didExitRegion: %@", region.identifier);
    
    //If we've exited a beacon region, stop ranging the beacons
    if([region isKindOfClass:[CLBeaconRegion class]] && [region.identifier isEqualToString:self.beaconRegion.identifier]) {
        CLBeaconRegion * beaconRegion = (CLBeaconRegion*)region;
        [self.locationManager stopRangingBeaconsInRegion:beaconRegion];
    }
}

- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSLog(@"didDetermineState: %d for region: %@", state, region.identifier);
    
    //If we're in a beacon region, start ranging the beacons
    if([region isKindOfClass:[CLBeaconRegion class]] && [region.identifier isEqualToString:self.beaconRegion.identifier]) {
        CLBeaconRegion * beaconRegion = (CLBeaconRegion*)region;
        if(state == CLRegionStateInside)
            [self.locationManager startRangingBeaconsInRegion:beaconRegion];
        else
            [self.locationManager stopRangingBeaconsInRegion:beaconRegion];
    }
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    for(CLBeacon * beacon in beacons) {
        NSLog(@"didRangeBeacon: major:%d minor:%d in region: %@", [beacon.major intValue], [beacon.minor intValue], region.identifier);
        NSLog(@"didRangeBeacon proximity: %d", beacon.proximity);
        NSLog(@"didRangeBeacon accuracy: %f", beacon.accuracy);
    }
    
    self.beacons = beacons;
    if(self.delegate != nil) {
        [self.delegate beaconRegionManager:self didRangeBeacons:self.beacons];
    }
}

- (void)locationManager:(CLLocationManager *)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
              withError:(NSError *)error
{
    NSLog(@"rangingBeaconsDidFailForRegion: %@ with error: %@", region.identifier, [error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"locationManager didFailWithError: %@", [error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error
{
    NSLog(@"monitoringDidFailForRegion: %@ error: %@", region.identifier, [error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager
didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"didStartMonitoringForRegion: %@", region.identifier);
}

#pragma mark -

@end
