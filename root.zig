//! Vicinae: a theme of its own, and the font, set in Vicinae's settings.

const std = @import("std");

/// The Vicinae theme; build one with `from`.
pub const App = @import("App.zig");
/// Colors from the theme.
pub const from = App.from;
/// The adapter the app writes the theme with, so a config needs only this package.
pub const toml_adapter = @import("kosm_toml").adapter;
/// The adapter the app edits Vicinae's commented settings with.
pub const jsonc_adapter = @import("kosm_json").jsonc;

test {
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(App);
    std.testing.refAllDecls(App.Colors);
}
