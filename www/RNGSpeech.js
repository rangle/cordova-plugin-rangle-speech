var exec = require('cordova/exec');

exports.speek = function(utteranceString, voiceProfile, success, error){
    exec(success, error, "RNGSpeechPlugin", "speek",[utteranceString,voiceProfile]);
}

exports.coolMethod = function(arg0, success, error) {
    exec(success, error, "RNGSpeechPlugin", "coolMethod", [arg0]);
};
