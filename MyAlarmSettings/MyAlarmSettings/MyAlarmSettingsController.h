//
//  MyAlarmSettingsController.h
//  MyAlarmSettings
//
//  Created by tj on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import <MediaPlayer/MediaPLayer.h>

@interface MyAlarmSettingsController : PSListController < MPMediaPickerControllerDelegate>{
	MPMediaItem *song;
    
	UILabel *songLabel;
	UILabel *artistLabel;
	UILabel *sizeLabel;
	UIImageView *coverArtView;
	UIProgressView *conversionProgress;
    
}



- (void)chooseSong:(PSSpecifier*)specifier;
- (void)donate:(PSSpecifier*)specifier;

@property (nonatomic, retain) IBOutlet UILabel *songLabel;
@property (nonatomic, retain) IBOutlet UILabel *artistLabel;
@property (nonatomic, retain) IBOutlet UILabel *sizeLabel;
@property (nonatomic, retain) IBOutlet UIImageView *coverArtView;
@property (nonatomic, retain) IBOutlet UIProgressView *conversionProgress;


@end