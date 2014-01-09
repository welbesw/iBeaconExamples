//
//  BeaconBroadcastManager.m
//  Beacon
//
//  Created by Will Welbes on 6/26/13.
//

#import "BeaconBroadcastManager.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface BeaconBroadcastManager()<CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager * peripheralManager;
@property (nonatomic, strong) CLBeaconRegion * beaconRegion;
@property (nonatomic, strong) NSUUID * proximityUUID;
@property (nonatomic, strong) NSString * beaconRegionIdentifier;

@end

@implementation BeaconBroadcastManager

-(BOOL)isAdvertising
{
    BOOL isAdvertising = NO;
    if(self.peripheralManager != nil) {
        isAdvertising = self.peripheralManager.isAdvertising;
    }
    return isAdvertising;
}

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(id)init
{
    self = [super init];
    if(self != nil) {
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
        
        NSString * uidString = @"BEE44022-97E5-4F0C-A100-0C43C114CCF5";
        self.proximityUUID = [[NSUUID alloc] initWithUUIDString:uidString];
        self.beaconRegionIdentifier = @"TestBeacon";
    }
    return self;
}

-(void)startAdvertisingWithMajor:(NSInteger)major minor:(NSInteger)minor
{
    if(self.peripheralManager.isAdvertising) {
        [self.peripheralManager stopAdvertising];
    }
    
    //Set the beacon region
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.proximityUUID
                                                                major:major
                                                                minor:minor
                                                           identifier:self.beaconRegionIdentifier];
    
    NSDictionary * dict = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    [self.peripheralManager startAdvertising:dict];
}

-(void)stopAdvertising
{
    if(self.peripheralManager.isAdvertising) {
        [self.peripheralManager stopAdvertising];
    }
}


#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSLog(@"peripheralManagerDidUpdateState: %d", peripheral.state);
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    NSLog(@"peripheralManagerDidStartAdvertising");
    if(error != nil) {
        NSLog(@"peripheralManagerDidStartAdvertising error: %@", [error localizedDescription]);
    }
}

#pragma mark -

@end
