
# Rangle Text to Speech Cordova Plugin

Objective-C/JavaScript cordova plugin that provives text-to-speech (TTS) and control of the voice properties.

## Installing

First make sure you have the `cordova` CLI installed on your machine.

```bash
sudo npm i -g cordova
```

Once you have the `cordova` CLI, you can install the plugin using the `cordova plugin install` command:

### Cordova Install via GitHub
```bash
cordova plugin add https://github.com/rangle/... --save
```
or
### Cordova Install via NPM
```bash
cordova plugin add cordova-plugin-rangle-speech --save
```

Then you just need to rebuild your cordova project.

```bash
cordova build ios
```

That's it! The plugin will expose a `RNGSpeech` object globally from which you can call the plugin method from your code.


## Getting Started

The RNGSpeech object aims to provide a simple interface for native device TTS. 
As a developer you have control of what is said as well as control over the voice properties.

### Voice Properties

All properties are optional, meaning you just have to change the properties you want.
Once a property is set, the plugin will remember that setting and continue to use it until a new value is set.

> This API closely matches the iOS SDK properties for [`AVSpeechUtterance`](https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVSpeechUtterance_Ref/index.html).
As such the descriptions below are taken from the iOS SDK Documentation for greater clarity.

* `pitchMultiplier`
The default pitch is 1.0. Allowed values are in the range from 0.5 (for lower pitch) to 2.0 (for higher pitch).

* `postSpeechInterval` 
The amount of time a speech synthesizer will wait after the utterance is spoken before handling the next queued utterance.

* `preSpeechInterval` 
The amount of time a speech synthesizer will wait before actually speaking the utterance upon beginning to handle it.

* `rate` 
The rate at which the utterance will be spoken.  Lower values correspond to slower speech, and vice versa.

* `volume` 
The volume used when speaking the utterance. Allowed values are in the range from 0.0 (silent) to 1.0 (loudest). The default volume is 1.0.

#### JavaScript
``` JavaScript
//Voice Properties Object
{
    pitchMultiplier: 1.0,
    postSpeechInterval: 0.0,
    preSpeechInterval: 0.0,
    rate: 1.0,
    voiceLocale: 'en-US',
    volume: 1.0
}

```

#### Objective-C API

```objective-c

@protocol RNGSpeechDelegate <NSObject>

@optional
- (void)didFinishSpeaking: (AVSpeechUtterance*)utterance;
- (void)willBeginSpeaking: (AVSpeechUtterance*)utterance;
@end

```


```objective-c

@property (strong,nonatomic) AVSpeechSynthesisVoice *voice; // set explicit voice object

@property (strong,nonatomic) NSString *voiceLocale; // set locale for voice only (note this will do nothing if voice is explictly set)

@property (nonatomic) float pitchMultiplier; //Pitch is multiplied by this number

@property (nonatomic) NSTimeInterval postSpeechInterval; //Delay in seconds after speech utterance and the next in queue.

@property (nonatomic) NSTimeInterval preSpeechInterval; //Delay before beginning a new speech utterance

@property (nonatomic) float rate; //Speed at which the utterance is spoken

@property (nonatomic) float volume; //Volume of the utterance


@property (nonatomic, assign, nullable) id<RNGSpeechDelegate> delegate; //Object that implements RNGSpeechDelegate

- (void) speek: (NSString *)speechString; //execute speech.

```

### Example
```JavaScript
RNGSkpeech.speek(
    "Dave, What are you doing Dave?",
    {volume:1.0, rate:1.0, voiceLocale:'eg-GB'},
    ()=>{console.log('success')},
    ()=>{console.log('failure')}
);
```
## Supported platforms
* iOS 8.x+

## Supported Cordova Versions
* &gt;=3.4.0


## Licence
```
    The MIT License (MIT)

    Copyright &copy; 2016 Rangle.io

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
```