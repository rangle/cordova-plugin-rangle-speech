var exec = require('cordova/exec');

exports.speek = function(utteranceString, voiceProfile, success, error){
    exec(success, error, "RNGSpeechPlugin", "speek", [utteranceString, voiceProfile]);
};
