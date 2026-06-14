const rl = @import("raylib");

pub const Player = struct{
    idleTexture: rl.Texture,
    actionTexture: rl.Texture,
    actionSound: rl.Sound,

    position: i32,
    yOffSet: i32,
    playerWidth: i32,
    speed: i32,

    pub fn init(winWidth: u16, winHeight: u16) Player {
        const idle = @embedFile("../../resources/catClosed.png");
        const action = @embedFile("../../resources/catOpen.png");
        const popSound = @embedFile("../../resources/pop.mp3");

        const idleImg = rl.loadImageFromMemory(".png", idle) catch unreachable;
        const actionImg = rl.loadImageFromMemory(".png", action) catch unreachable;
        const actionSound = rl.loadWaveFromMemory(".mp3", popSound) catch unreachable;
        const position = @divFloor(winWidth, 2);
        return .{    
            .idleTexture = rl.loadTextureFromImage(idleImg) catch unreachable, 
            .actionTexture = rl.loadTextureFromImage(actionImg) catch unreachable,
            .actionSound = rl.loadSoundFromWave(actionSound),

            .position = position,
            .yOffSet = winHeight-@as(i32, idleImg.height),
            .playerWidth = @as(i32, idleImg.width),
            .speed = 5,
        };
    }

    pub fn move(self: *Player) void {
       if (rl.isKeyDown(.a)){
            self.position -= self.speed;
            if (self.position <= 0) {
                self.position = rl.getScreenWidth()-self.idleTexture.width;
            } 
            rl.drawTexture(self.idleTexture, self.position, self.yOffSet, .white);
        }
        else if (rl.isKeyDown(.d)){
            self.position += self.speed;
            if (self.position+self.playerWidth >= rl.getScreenWidth()){
                self.position = 0;
            } 
            rl.drawTexture(self.idleTexture, self.position, self.yOffSet, .white);
        }
       else{
            rl.drawTexture(self.idleTexture, self.position, self.yOffSet, .white);
       }
    }

    pub fn hit(self: *Player) void {
        rl.drawTexture(self.actionTexture, self.position, self.yOffSet, .white);
        if (!rl.isSoundPlaying(self.actionSound)){
            rl.playSound(self.actionSound);
        }
    }
};
