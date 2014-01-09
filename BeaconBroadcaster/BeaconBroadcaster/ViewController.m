//
//  ViewController.m
//  BeaconBroadcaster
//
//  Created by Will Welbes on 1/9/14.
//  Copyright (c) 2014 My UIVIews. All rights reserved.
//

#import "ViewController.h"
#import <CoreFoundation/CoreFoundation.h>
#import "BeaconBroadcastManager.h"
#import "Configuration.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UITextField * beaconMajorTextField;
@property (nonatomic, strong) IBOutlet UITextField * beaconMinorTextField;
@property (nonatomic, strong) IBOutlet UISwitch * broadcastBeaconSwitch;

-(void)broadcastBeaconSwitchValueChanged:(id)sender;
-(void)updateBroadcastManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.broadcastBeaconSwitch addTarget:self action:@selector(broadcastBeaconSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BeaconBroadcastManager * beaconBroadcastManager = [BeaconBroadcastManager sharedInstance];
    self.broadcastBeaconSwitch.on = beaconBroadcastManager.isAdvertising;
    
    Configuration * configuration = [Configuration sharedInstance];
    configuration.shouldBroadcast = beaconBroadcastManager.isAdvertising;
    
    self.beaconMajorTextField.text = [configuration.majorValue stringValue];
    self.beaconMinorTextField.text = [configuration.minorValue stringValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)broadcastBeaconSwitchValueChanged:(id)sender
{
    [self updateBroadcastManager];
}

-(void)updateBroadcastManager
{
    BeaconBroadcastManager * beaconBroadcastManager = [BeaconBroadcastManager sharedInstance];
    Configuration * configuration = [Configuration sharedInstance];
    if([self.broadcastBeaconSwitch isOn]) {
        if(self.beaconMajorTextField.hasText && self.beaconMinorTextField.hasText) {
            NSInteger major = [self.beaconMajorTextField.text intValue];
            NSInteger minor = [self.beaconMinorTextField.text intValue];
            
            configuration.majorValue = [NSNumber numberWithInt:major];
            configuration.minorValue = [NSNumber numberWithInt:minor];
            configuration.shouldBroadcast = YES;
            
            [beaconBroadcastManager startAdvertisingWithMajor:major minor:minor];
        }
    } else {
        [beaconBroadcastManager stopAdvertising];
        configuration.shouldBroadcast = NO;
    }
}


@end
