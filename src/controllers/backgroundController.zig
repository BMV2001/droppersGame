const rl = @import("raylib");
//background image
const Background = @import("../models/textures/background.zig").Background;
var Bg: Background = undefined;

//background audio
const BackgroudAudio = @import("../models/audio/bgaudio.zig").Bgaudio;
var BgAu: BackgroudAudio = undefined;

pub fn prepare() void{
    Bg = Background.init();
    BgAu = BackgroudAudio.init();

    BgAu.playMusic();
}

pub fn run() void{
    BgAu.updateMusic();
    Bg.updateFrame();
    rl.drawTexture(Bg.texture, 0, 0, .white);
}

pub fn terminate() void{
    rl.unloadTexture(Bg.texture);
    rl.unloadImage(Bg.image);
    BgAu.stopMusic();
}
