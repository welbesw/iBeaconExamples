//
//  BeaconCell.h
//  Beacon
//
//  Created by Will Welbes on 6/26/13.
//

#import <UIKit/UIKit.h>

@interface BeaconCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel * beaconNameLabel;
@property (nonatomic, strong) IBOutlet UILabel * beaconDistanceLabel;

@end
