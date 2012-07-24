//
//  MyAlarmSettingsController.m
//  MyAlarmSettings
//
//  Created by tj on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyAlarmSettingsController.h"
#import <Preferences/PSSpecifier.h>


@implementation MyAlarmSettingsController


@synthesize songLabel;
@synthesize artistLabel;
@synthesize sizeLabel;
@synthesize coverArtView;
@synthesize conversionProgress;




- (void)donate:(PSSpecifier *)specifier
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=tjcorley30%40hotmail%2ecom&lc=US&item_name=Fire30&item_number=Tweaks&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted"]];
}


- (void)chooseSong:(PSSpecifier *)specifier
{
	MPMediaPickerController *pickerController =	[[MPMediaPickerController alloc]
												 initWithMediaTypes: MPMediaTypeMusic];
	pickerController.prompt = @"Choose song to  be set as alarm";
	pickerController.allowsPickingMultipleItems = YES;
	pickerController.delegate = self;
	[self presentModalViewController:pickerController animated:YES];
	[pickerController release];
}

NSInteger n = 0;


#pragma mark MPMediaPickerControllerDelegate
- (void)mediaPicker: (MPMediaPickerController *)mediaPicker
  didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
	[self dismissModalViewControllerAnimated:YES];
	if ([mediaItemCollection count] < 1) {
		return;
	}
    setuid(0);
    setgid(0);
    setuid(0);system("chmod 777 /Library/PreferenceBundles/MyAlarmSettings.bundle");
    setuid(0);system("chmod 777 /Library/PreferenceBundles/MyAlarmSettings.bundle/songs.plist");
    
	[song release];
	song = [[[mediaItemCollection items] objectAtIndex:0] retain];
	songLabel.hidden = NO;
	artistLabel.hidden = NO;
	coverArtView.hidden = NO;
	songLabel.text = [song valueForProperty:MPMediaItemPropertyTitle];
	artistLabel.text = [song valueForProperty:MPMediaItemPropertyArtist];
	coverArtView.image = [[song valueForProperty:MPMediaItemPropertyArtwork]
						  imageWithSize: coverArtView.bounds.size];
    
    
     NSMutableDictionary *data;
    
    data = [[NSMutableDictionary alloc] init];
    
    NSString *path = @"Library/PreferenceBundles/MyAlarmSettings.bundle/songs.plist";
    
    do {
        NSURL *url = [[mediaItemCollection.items objectAtIndex:n] valueForProperty:MPMediaItemPropertyAssetURL];
        NSString *urlString = [url absoluteString];
        NSString *songURL =  [[NSString alloc]initWithFormat:@"Song%iURL",n];
        [data setObject:urlString forKey:songURL];
        n= n+1;
        
        if(n==mediaItemCollection.count)
           {
               break;
           }
    } while( n <= mediaItemCollection.count);
    
    
    NSString* songAmount = [NSString stringWithFormat:@"%i", mediaItemCollection.count];
    
    
    
   // [data setObject:[song valueForProperty:MPMediaItemPropertyTitle] forKey:@"songName"];
    
    [data setObject:songAmount forKey:@"amountOfSongs"];
    
    

    [data writeToFile:path atomically:YES];
    [data release];
    
    
   NSString *hax =  [[NSString alloc]initWithFormat:@"You Chose '%@' Songs \n  \n Press OK to respring. ",songAmount];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done!" message:hax delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];

    setuid(0);system("chmod 777 /Library/PreferenceBundles/MyAlarmSettings.bundle/songs.plist");
    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0) system("killall SpringBoard");

}


- (id)specifiers
{
	if (_specifiers == nil)
		_specifiers = [[self loadSpecifiersFromPlistName:@"MyAlarmSettings" target:self] retain];
	
	return _specifiers;
}

- (id)init
{
	if ((self = [super init]))
	{
	}
	
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

@end