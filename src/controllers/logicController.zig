const rl = @import("raylib");
const std = @import("std");
const Player = @import("../models/entities/player.zig").Player;
const Nugget = @import("../models/entities/nugget.zig").Nugget;
var pointCounter: i8 = 0;
var pointTotal: u16 = 0;
var highScore: i8 = 0;

pub fn checkHit(p: *Player, n: *Nugget) void {
    const playerY = p.yOffSet;
    const nuggetY = n.yPos+@as(i32, n.texture.height);
 
    if (nuggetY >= playerY){
        const playerXstart = p.position; 
        const playerXend = p.position+@as(i32, p.idleTexture.width);
        const nuggetXcenter = n.xPos+@divTrunc(@as(i32, n.texture.width), 2); 

        if (nuggetY >= rl.getScreenHeight()){
            n.hit();
            tally(-1, p, n);
        }
        else if((playerXstart < nuggetXcenter) & (nuggetXcenter < playerXend)){
            n.hit();
            p.hit();            
            tally(1, p, n);
        }
    }

    showScore();
}

fn tally(val: i8, p: *Player, n: *Nugget) void {
    n.speed += val;
    p.speed += val;
    pointCounter += val;

    if (val>0){
        pointTotal += 1;
    }
    
    if (pointCounter > highScore){
        highScore = pointCounter;
    }
}

fn showScore() void {
    var scoreBuff: [64]u8 = undefined;
    const scoreText = std.fmt.bufPrintZ(&scoreBuff, "Score: {}", .{pointCounter}) catch unreachable;

    var hsBuff: [64]u8 = undefined;
    const HSText = std.fmt.bufPrintZ(&hsBuff, "High score: {}", .{highScore}) catch unreachable;

    var totalBuff: [64]u8 = undefined;
    const totalText = std.fmt.bufPrintZ(&totalBuff, "Total: {}", .{pointTotal}) catch unreachable;

    rl.drawText(scoreText, 5, 5, 13, .white);
    rl.drawText(HSText,5, 25, 13, .white);
    rl.drawText(totalText, 5, 45, 13, .white);

    if(pointCounter == -3){
        rl.drawText("Game Over", 125 ,50, 50, .white);
    }
}

