const rl = @import("raylib");
const std = @import("std");

pub const App = struct {
    targetFPS: i32,
    winHeight: u16,
    winWidth: u16,
    bgColor: rl.Color,

    pub fn init() App {
        return .{
        .targetFPS = 60,
        .winHeight = 279,
        .winWidth = 495,
        .bgColor = .white,
        };
    }
};
