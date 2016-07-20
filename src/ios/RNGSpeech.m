//
//  RNGSpeech.m
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

#import "RNGSpeech.h"


@interface RNGSpeech() <AVSpeechSynthesizerDelegate>

@property (strong,nonatomic) AVSpeechSynthesizer *speechSynthesizer;
@property (strong,nonatomic) AVAudioSession *audioSession;

@end

@implementation RNGSpeech

float _pitchMultiplier; //ivar to back property.
NSString *_voiceLocale;
NSString *defaultLocale = @"en-US";


- (id) init {
  if(self = [super init]){
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    self.speechSynthesizer.delegate = self;
    
    self.audioSession = [AVAudioSession sharedInstance];
    
    NSError * _Nullable __autoreleasing * _Nullable *error;
    
    [self.audioSession setCategory:AVAudioSessionCategoryPlayback
                       withOptions:AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers
                             error:nil];
    self.voice = [AVSpeechSynthesisVoice voiceWithLanguage:self.voiceLocale];
    
    
    
    if(error){
      NSLog(@"error setting up audio session");
    }
  }
  return self;
}

- (void) setPitchMultiplier:(float)newValue{
  if(newValue > 1){
    newValue = 1;
  }
  if(newValue < 0){
    newValue = 0;
  }
  _pitchMultiplier = newValue;
}



- (float) pitchMultiplier {
  if(!_pitchMultiplier){
    _pitchMultiplier = 1.0; //set default to iOS default
  }
  
  return _pitchMultiplier;
}

- (NSString*)voiceLocale{
  if(!_voiceLocale){
    _voiceLocale = defaultLocale;
  }
  return _voiceLocale;
}

-(void)setVoiceLocale:(NSString *)voiceLocale{
  _voiceLocale = voiceLocale;
  if(self.voice){
    _voice = [AVSpeechSynthesisVoice voiceWithLanguage:_voiceLocale];
  }
}

- (AVSpeechSynthesisVoice *) voice{
  if(!_voice){
    _voice = [AVSpeechSynthesisVoice voiceWithLanguage:self.voiceLocale];
  }
  return _voice;
}

- (NSTimeInterval)postSpeechInterval {
  if(!_postSpeechInterval){
    _postSpeechInterval = 0.0;
  }
  return _postSpeechInterval;
}

- (NSTimeInterval)preSpeechInterval {
  if(!_postSpeechInterval){
    _postSpeechInterval = 0.0;
  }
  return _postSpeechInterval;
}


- (float)rate{
  if(!_rate){
    _rate = AVSpeechUtteranceDefaultSpeechRate;
  }
  return _rate;
}

- (float)volume{
  if(!_volume){
    _volume = 1.0;
  }
  return _volume;
}

- (void) speek:(NSString *)speechString{
  
  AVSpeechUtterance *utterance = [RNGSpeech utteranceWithString:speechString
                                                          voice:self.voice
                                                          pitch:self.pitchMultiplier
                                             postUtteranceDelay:self.postSpeechInterval
                                              preUtteranceDelay:self.preSpeechInterval
                                                           rate:self.rate
                                                         volume:self.volume];
  [self.speechSynthesizer speakUtterance:utterance];
}

+ (AVSpeechUtterance *) utteranceWithString:(NSString *)speechString
                                      voice:(AVSpeechSynthesisVoice *)voice
                                      pitch:(float)pitchMultiplier
                         postUtteranceDelay:(NSTimeInterval)postUtteranceInterval
                          preUtteranceDelay:(NSTimeInterval)preUtteranceInterval
                                       rate:(float)rate
                                     volume:(float)volume
{
  AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:speechString];
  utterance.voice = voice;
  utterance.pitchMultiplier = pitchMultiplier;
  utterance.postUtteranceDelay = postUtteranceInterval;
  utterance.preUtteranceDelay = preUtteranceInterval;
  utterance.rate = rate;
  utterance.volume = volume;
  
  return utterance;
}



@end
