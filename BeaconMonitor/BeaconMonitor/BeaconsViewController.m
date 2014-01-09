//
//  BeaconsViewController.m
//  Beacon
//
//  Created by Will Welbes on 6/25/13.
//

#import "BeaconsViewController.h"
#import "BeaconRegionManager.h"
#import "BeaconCell.h"

@interface BeaconsViewController ()<BeaconRegionManagerDelegate>

@end

@implementation BeaconsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Start the beacon region monitoring when the controller loads
    BeaconRegionManager * beaconRegionManager = [BeaconRegionManager sharedInstance];
    beaconRegionManager.delegate = self;
    [beaconRegionManager startBeaconMonitoring];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger beaconCount = 0;
    BeaconRegionManager * beaconRegionManager = [BeaconRegionManager sharedInstance];
    if(beaconRegionManager.beacons != nil)
        beaconCount = beaconRegionManager.beacons.count;
    
    return beaconCount;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BeaconCell";
    BeaconCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    BeaconRegionManager * beaconRegionManager = [BeaconRegionManager sharedInstance];
    if(beaconRegionManager.beacons != nil && indexPath.row < beaconRegionManager.beacons.count) {
        CLBeacon * beacon = beaconRegionManager.beacons[indexPath.row];
        cell.beaconNameLabel.text = [NSString stringWithFormat:@"%d : %d", [beacon.major intValue], [beacon.minor intValue]];
        if(beacon.accuracy > 0) {
            cell.beaconDistanceLabel.text = [NSString stringWithFormat:@"%.1f ft", beacon.accuracy * 3.2808];
        } else {
            cell.beaconDistanceLabel.text = @"";
        }
    }
    
    return cell;
}

#pragma mark - BeaconRegionManagerDelegate

-(void)beaconRegionManager:(BeaconRegionManager*)beaconRegionManager didRangeBeacons:(NSArray*)beacons
{
    [self.tableView reloadData];
}

#pragma mark -

@end
