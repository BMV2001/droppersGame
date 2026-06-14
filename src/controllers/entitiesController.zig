const rl = @import("raylib");
const App = @import("../app.zig").App;

const Player = @import("../models/entities/player.zig").Player; 
var P: Player = undefined;

const Nugget = @import("../models/entities/nugget.zig").Nugget;
var N: Nugget = undefined;

const logicCon = @import("logicController.zig");

pub fn prepare(app: *App) void{
    P = Player.init(app.winWidth, app.winHeight);
    N = Nugget.init(app.winWidth);
}

pub fn run() void {
    P.move();
    N.move();
    logicCon.checkHit(&P,&N);
}

pub fn terminate() void{
    rl.unloadTexture(P.idleTexture);
    rl.unloadTexture(P.actionTexture);

    rl.unloadTexture(N.texture);
}
