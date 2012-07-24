#line 1 "/Users/tj/Documents/iOSDevelopment/MyAlarm/MyAlarm/MyAlarm/MyAlarm.xm"











#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#include <stdlib.h>


NSString *path = @"Library/PreferenceBundles/MyAlarmSettings.bundle/songs.plist";

NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];

AVPlayer *player;

#include <substrate.h>
@class SBSystemLocalNotificationAlert; @class Alarm; @class AlarmManager; 
static id (*_logos_orig$_ungrouped$Alarm$sound)(Alarm*, SEL); static id _logos_method$_ungrouped$Alarm$sound(Alarm*, SEL); static id (*_logos_orig$_ungrouped$AlarmManager$defaultSound)(AlarmManager*, SEL); static id _logos_method$_ungrouped$AlarmManager$defaultSound(AlarmManager*, SEL); static void (*_logos_meta_orig$_ungrouped$SBSystemLocalNotificationAlert$playAlertSound$soundName$inBundle$isRingtone$sandboxPath$)(Class, SEL, BOOL, id, id, BOOL, id); static void _logos_meta_method$_ungrouped$SBSystemLocalNotificationAlert$playAlertSound$soundName$inBundle$isRingtone$sandboxPath$(Class, SEL, BOOL, id, id, BOOL, id); static void (*_logos_meta_orig$_ungrouped$SBSystemLocalNotificationAlert$stopPlayingAlertSoundOrRingtone)(Class, SEL); static void _logos_meta_method$_ungrouped$SBSystemLocalNotificationAlert$stopPlayingAlertSoundOrRingtone(Class, SEL); 

#line 25 "/Users/tj/Documents/iOSDevelopment/MyAlarm/MyAlarm/MyAlarm/MyAlarm.xm"



static id _logos_method$_ungrouped$Alarm$sound(Alarm* self, SEL _cmd) {
    
    NSString *n = [dict objectForKey: @"amountOfSongs"];
                   
    NSString *songNameFiller =  [[NSString alloc]initWithFormat:@"%@ Songs", n];
                   
    if([dict objectForKey: @"Song0URL"] == nil) return @"Song Not Set!";
        
    else return songNameFiller;
            
}






static id _logos_method$_ungrouped$AlarmManager$defaultSound(AlarmManager* self, SEL _cmd) {
    
    NSString *n = [dict objectForKey: @"amountOfSongs"];
    
    NSString *songNameFiller =  [[NSString alloc]initWithFormat:@"%@ Songs", n];
    
    if([dict objectForKey: @"Song0URL"] == nil) return @"Song Not Set!";
    
    else return songNameFiller;
    
}









static void _logos_meta_method$_ungrouped$SBSystemLocalNotificationAlert$playAlertSound$soundName$inBundle$isRingtone$sandboxPath$(Class self, SEL _cmd, BOOL sound, id name, id bundle, BOOL ringtone, id path) {

int n = [[dict objectForKey: @"amountOfSongs"] intValue];
NSString *urlKey =  [[NSString alloc]initWithFormat:@"Song%iURL", arc4random() % n];
    
if([dict objectForKey: @"Song0URL"] == nil)
{
    NSString *hax =  [[NSString alloc]initWithFormat:@"You Have Not Chosen A Song! \n Please go to Settings>MyAlarm and choose a song."];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:hax delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}
                  
else

    
{
    

player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:[dict objectForKey:urlKey]]];

    
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



static void _logos_meta_method$_ungrouped$SBSystemLocalNotificationAlert$stopPlayingAlertSoundOrRingtone(Class self, SEL _cmd) {
    [player pause];
    _logos_meta_orig$_ungrouped$SBSystemLocalNotificationAlert$stopPlayingAlertSoundOrRingtone(self, _cmd);
}



static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$Alarm = objc_getClass("Alarm"); MSHookMessageEx(_logos_class$_ungrouped$Alarm, @selector(sound), (IMP)&_logos_method$_ungrouped$Alarm$sound, (IMP*)&_logos_orig$_ungrouped$Alarm$sound);Class _logos_class$_ungrouped$AlarmManager = objc_getClass("AlarmManager"); MSHookMessageEx(_logos_class$_ungrouped$AlarmManager, @selector(defaultSound), (IMP)&_logos_method$_ungrouped$AlarmManager$defaultSound, (IMP*)&_logos_orig$_ungrouped$AlarmManager$defaultSound);Class _logos_class$_ungrouped$SBSystemLocalNotificationAlert = objc_getClass("SBSystemLocalNotificationAlert"); Class _logos_metaclass$_ungrouped$SBSystemLocalNotificationAlert = object_getClass(_logos_class$_ungrouped$SBSystemLocalNotificationAlert); MSHookMessageEx(_logos_metaclass$_ungrouped$SBSystemLocalNotificationAlert, @selector(playAlertSound:soundName:inBundle:isRingtone:sandboxPath:), (IMP)&_logos_meta_method$_ungrouped$SBSystemLocalNotificationAlert$playAlertSound$soundName$inBundle$isRingtone$sandboxPath$, (IMP*)&_logos_meta_orig$_ungrouped$SBSystemLocalNotificationAlert$playAlertSound$soundName$inBundle$isRingtone$sandboxPath$);MSHookMessageEx(_logos_metaclass$_ungrouped$SBSystemLocalNotificationAlert, @selector(stopPlayingAlertSoundOrRingtone), (IMP)&_logos_meta_method$_ungrouped$SBSystemLocalNotificationAlert$stopPlayingAlertSoundOrRingtone, (IMP*)&_logos_meta_orig$_ungrouped$SBSystemLocalNotificationAlert$stopPlayingAlertSoundOrRingtone);}  }
#line 117 "/Users/tj/Documents/iOSDevelopment/MyAlarm/MyAlarm/MyAlarm/MyAlarm.xm"
