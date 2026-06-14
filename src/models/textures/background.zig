const rl = @import("raylib");

pub const Background = struct {
    image: rl.Image,
    texture: rl.Texture,

    animFrames: i32,
    currentFrame: i32,

    frameDelay: i32,
    frameCounter: i32,

    pub fn init() Background {
        var frames: i32 = 0;
        const file = @embedFile("../../resources/rat.gif");
        const image = rl.loadImageAnimFromMemory(
            ".gif",
            file,
            &frames,
        ) catch unreachable;


        return .{
            .image = image,
            .texture = rl.loadTextureFromImage(image) catch unreachable,

            .animFrames = frames,
            .currentFrame = 0,

            .frameDelay = 1,
            .frameCounter = 0,
        };
    }

    pub fn updateFrame(self: *Background) void {
        self.frameCounter += 1;

        if (self.frameCounter < self.frameDelay){
            return;
        }

        self.frameCounter = 0;

        self.currentFrame =
           @mod(self.currentFrame + 1, self.animFrames);

        const offset: usize =
            @intCast(
                self.image.width *
                self.image.height *
                4 *
                self.currentFrame,
            );
        
        const pixels: [*]u8 = @ptrCast(self.image.data);

        rl.updateTexture(
            self.texture,
            pixels + offset,
        );
    }   
};
