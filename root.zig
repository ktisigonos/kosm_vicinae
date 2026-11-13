//! Vicinae: a theme of its own, and a settings file of its own that Vicinae's settings import.

const std = @import("std");

/// The Vicinae theme; build one with `from`.
pub const App = @import("App.zig");
/// Colors from the theme.
pub const from = App.from;
/// The adapter the app writes the theme with, so a config needs only this package.
pub const toml_adapter = @import("kosm_toml").adapter;
/// The adapter the app writes its own settings file with.
pub const json_adapter = @import("kosm_json").adapter;
/// The adapter the app edits Vicinae's commented settings with.
pub const jsonc_adapter = @import("kosm_json").jsonc;

test {
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(App);
    std.testing.refAllDecls(App.Colors);
}
