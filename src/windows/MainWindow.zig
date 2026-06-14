const rl = @import("raylib");
const engine = @import("GraphicsEngine.zig");
const AppStruct = @import("../app.zig").App;
var App: AppStruct = AppStruct.init();

//loads main window, reflects the window pane

pub fn initMain() void { 

    rl.initWindow(App.winWidth, App.winHeight, "Droppers!"); 
    defer rl.closeWindow();
    rl.setTargetFPS(App.targetFPS);
    
    rl.initAudioDevice();
    defer rl.closeAudioDevice();
    

    //for graphics engine to be prepared, it must be initiated after rl.initWindow();
    engine.prepare(&App); 

    while(!rl.windowShouldClose()){
        rl.beginDrawing();
        engine.run(); 
        rl.endDrawing();
    }

    //gracefully terminate program and enload loaded assets 
    engine.terminate();
}
