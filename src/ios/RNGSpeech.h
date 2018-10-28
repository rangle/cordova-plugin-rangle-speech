//
//  RNGSpeech.h
//  SpeechSynth
//

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


#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Cordova/CDV.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RNGSpeechDelegate <NSObject>

@optional
- (void)didFinishSpeaking: (AVSpeechUtterance*)utterance command:(CDVInvokedUrlCommand*)command;
- (void)willBeginSpeaking: (AVSpeechUtterance*)utterance command:(CDVInvokedUrlCommand*)command;
@end

@interface RNGSpeech : NSObject

@property (strong,nonatomic) AVSpeechSynthesisVoice *voice; //set explicit voice object
@property (strong,nonatomic) NSString *voiceID; //Explicitly set voice
@property (strong,nonatomic) NSString *voiceLocale; //set locale for voice only (note this will do nothing if voice is explictly set)
@property (nonatomic) float pitchMultiplier;
@property (nonatomic) NSTimeInterval postSpeechInterval;
@property (nonatomic) NSTimeInterval preSpeechInterval;
@property (nonatomic) float rate;
@property (nonatomic) float volume;

@property (nonatomic, assign, nullable) id<RNGSpeechDelegate> delegate;


- (void) speek: (NSString *)speechString command:(CDVInvokedUrlCommand*)command;

@end

NS_ASSUME_NONNULL_END