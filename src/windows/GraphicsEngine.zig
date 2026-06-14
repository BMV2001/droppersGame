const App = @import("../app.zig").App;
const bgCon = @import("../controllers/backgroundController.zig");
const entityCon = @import("../controllers/entitiesController.zig");

pub fn prepare(app: *App) void {
    entityCon.prepare(app);
    bgCon.prepare();   
}

pub fn run() void {
    bgCon.run();
    entityCon.run(); 
}

pub fn terminate() void{
    entityCon.terminate();
    bgCon.terminate();
}
