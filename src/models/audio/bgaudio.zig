const rl = @import("raylib");

pub const Bgaudio = struct {

    music: rl.Music,

    pub fn init() Bgaudio {
       const file = @embedFile("../../resources/freebird.mp3");
       return .{
           .music = rl.loadMusicStreamFromMemory(".mp3", file) catch unreachable
       };
    }

    pub fn playMusic(self: *Bgaudio) void {
        rl.playMusicStream(self.music) ;
    }

    pub fn stopMusic(self: *Bgaudio) void {
        rl.stopMusicStream(self.music);
    }

    pub fn updateMusic(self: *Bgaudio) void {
        rl.updateMusicStream(self.music);
    }
};
