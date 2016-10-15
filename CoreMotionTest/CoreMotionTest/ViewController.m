//
//  ViewController.m
//  CoreMotionTest
//
//  Created by 段昊宇 on 16/10/15.
//  Copyright © 2016年 UP. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UILabel *gyroscopeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.motionManager = [[CMMotionManager alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    if (self.motionManager.gyroAvailable) {
        self.motionManager.gyroUpdateInterval = 1.0/10.0;
        [self.motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData *gyroData,NSError *error){
            NSString *labelText;
            if (error) {
                [self.motionManager stopGyroUpdates];
                labelText = [NSString stringWithFormat:@"Gyroscope encountered error: %@",error];
            } else {
                labelText = [NSString stringWithFormat:@"陀螺仪\nx: %+.2f\ny: %+.2f\nz: %+.2f",gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z];
            }
            // [gyroscopeLabel performSelectorOnMainThread:@selector(setText:) withObject:labelText waitUntilDone:NO];
            self.gyroscopeLabel.text = labelText;
        }];
    } else {
        self.gyroscopeLabel.text = @"This device has no gyroscope";
    }
}




@end
