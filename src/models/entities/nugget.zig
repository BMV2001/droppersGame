const rl = @import("raylib");
const std = @import("std");

pub const Nugget = struct{
    texture: rl.Texture,
    xPos: i32,
    yPos: i32,
    speed: i8,
   pub fn init(winWidth: i32) Nugget{ 
       const file = @embedFile("../../resources/nugget.png");
       const img = rl.loadImageFromMemory(".png", file) catch unreachable;

       return .{
        .texture = rl.loadTextureFromImage(img) catch unreachable,
        .xPos = winWidth-@as(i32, img.width),
        .yPos = 0,
        .speed = 3,   
    };
   }

   pub fn move(self: *Nugget) void {
    self.yPos += self.speed; 
    rl.drawTexture(self.texture, self.xPos, self.yPos, .white); 
   }

   pub fn hit(self: *Nugget) void {
    self.xPos = rl.getRandomValue(0, rl.getScreenWidth()-@as(i32, self.texture.width));
    self.yPos = -@as(i32, self.texture.height);
   }
};
