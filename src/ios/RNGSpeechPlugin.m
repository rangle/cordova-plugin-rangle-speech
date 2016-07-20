/* 
Created by Douglas Riches on 2016-07-18.
The MIT License (MIT)

Copyright (c) 2016 Rangle.io

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

/********* RNGSpeechPlugin.m Cordova Plugin Implementation *******/

#import "RNGSpeechPlugin.h"
#import "RNGSpeech.h"


@interface RNGSpeechPlugin() 
  // Member variables go here.
  @property (strong,nonatomic) RNGSpeech *speechSession;

@end

@implementation RNGSpeechPlugin

- (void)pluginInitialize
{
    NSLog(@"Echo plugin init.");
    self.speechSession = [[RNGSpeech alloc] init];
    NSLog(@"post session init");
}

- (void) speek:(CDVInvokedUrlCommand*)command{

    CDVPluginResult* pluginResult = nil;
    NSString *utteranceString = [command.arguments objectAtIndex:0];
    NSDictionary *voiceProfile = [command.arguments objectAtIndex:1];

    [voiceProfile enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL* stop) {
        

        /*
            VOICE PROPERTIES
            @property (strong,nonatomic) AVSpeechSynthesisVoice *voice; //set explicit voice object
            @property (strong,nonatomic) NSString *voiceLocale; //set locale for voice only (note this will do nothing if voice is explictly set)
            @property (nonatomic) float pitchMultiplier;
            @property (nonatomic) NSTimeInterval postSpeechInterval;
            @property (nonatomic) NSTimeInterval preSpeechInterval;
            @property (nonatomic) float rate;
            @property (nonatomic) float volume;
        */
        if([key isEqualToString:@"voiceLocale"]){
            NSString* locale = value;
            self.speechSession.voiceLocale = locale;
        }

        if([key isEqualToString:@"pitchMultiplier"]){
            NSNumber *multiplier = value;
            self.speechSession.pitchMultiplier = [multiplier floatValue];
        }
        
        if([key isEqualToString:@"postSpeechInterval"]){
            NSNumber *postInterval = value;
            self.speechSession.postSpeechInterval = [postInterval doubleValue];
        }
        
        if([key isEqualToString:@"preSpeechInterval"]){
            NSNumber *preInterval = value;
            self.speechSession.preSpeechInterval = [preInterval doubleValue];
        }

        if([key isEqualToString:@"rate"]){
            NSNumber *rate = value;
            self.speechSession.rate = [rate floatValue];
        }
        
        if([key isEqualToString:@"volume"]){
            NSNumber *volume = value;
            self.speechSession.volume = [volume floatValue];
        }
        
    }];

    if (utteranceString != nil && [utteranceString length] > 0) {
        [self.speechSession speek: utteranceString];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: utteranceString];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
