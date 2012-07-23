
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

/*
#error iOSOpenDev post-project creation from template requirements (remove these lines after completed) -- \
	Link to libsubstrate.dylib: \
	(1) go to TARGETS > Build Phases > Link Binary With Libraries and add /opt/iOSOpenDev/lib/libsubstrate.dylib \
	(2) remove these lines from *.xm files (not *.mm files as they're automatically generated from *.xm files)
*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

NSString *path = @"Library/PreferenceBundles/MyAlarmSettings.bundle/songs.plist";

NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];

AVPlayer *player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:[dict objectForKey: @"songURL"]]];;



%hook Alarm
- (id)sound
{
if([dict objectForKey: @"songURL"] == nil) return @"Song Not Set!";


else return [dict objectForKey: @"songName"];

}

%end

%hook AlarmManager

- (id)defaultSound
{


if([dict objectForKey: @"songURL"] == nil) return @"Song Not Set!";


else return [dict objectForKey: @"songName"];

}

%end

%hook SBSystemLocalNotificationAlert


+ (void)playAlertSound:(BOOL)sound soundName:(id)name inBundle:(id)bundle isRingtone:(BOOL)ringtone sandboxPath:(id)path
{

if([dict objectForKey: @"songURL"] == nil)
{
    NSString *hax =  [[NSString alloc]initWithFormat:@"You Have Not Chosen A Song! \n Please go to Settings>MyAlarm and choose a song."];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:hax delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}
                  
else

{
    
if(player == nil)
{
    player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:[dict objectForKey: @"songURL"]]];
}

if(dict == nil)
{
    dict = [NSDictionary dictionaryWithContentsOfFile:path];

}
                    
[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                    
[[AVAudioSession sharedInstance] setActive: YES error: nil];

CMTime time= CMTimeMake(0,10);
    
[player seekToTime:time];                    
[player play]; 
    
}


}


+ (void)stopPlayingAlertSoundOrRingtone
{
    [player pause];
    %orig;
}


%end