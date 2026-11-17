//! `keybinds`: Vicinae's shortcuts inside the launcher, each written like `control+shift+C`.
//! Field names are Vicinae's ids in snake case: `action_copy_name` is `action.copy-name`.
//! `control` is the command key on macOS. null fields are not written, leaving Vicinae's default.

const Keybinds = @This();

const std = @import("std");

/// `open-search-filter`. null: Vicinae's default (`control+P`).
open_search_filter: ?[]const u8 = null,
/// `open-settings`. null: Vicinae's default (`control+,`).
open_settings: ?[]const u8 = null,
/// `toggle-action-panel`. null: Vicinae's default (`control+B`, `control+K` on macOS).
toggle_action_panel: ?[]const u8 = null,
/// `action.copy`. null: Vicinae's default (`control+shift+C`).
action_copy: ?[]const u8 = null,
/// `action.copy-name`. null: Vicinae's default (`control+shift+.`).
action_copy_name: ?[]const u8 = null,
/// `action.copy-path`. null: Vicinae's default (`control+shift+,`).
action_copy_path: ?[]const u8 = null,
/// `action.dangerous-remove`. null: Vicinae's default (`control+shift+X`).
action_dangerous_remove: ?[]const u8 = null,
/// `action.duplicate`. null: Vicinae's default (`control+D`).
action_duplicate: ?[]const u8 = null,
/// `action.edit`. null: Vicinae's default (`control+E`).
action_edit: ?[]const u8 = null,
/// `action.edit-secondary`. null: Vicinae's default (`control+shift+E`).
action_edit_secondary: ?[]const u8 = null,
/// `action.move-down`. null: Vicinae's default (`control+shift+ARROWDOWN`).
action_move_down: ?[]const u8 = null,
/// `action.move-up`. null: Vicinae's default (`control+shift+ARROWUP`).
action_move_up: ?[]const u8 = null,
/// `action.new`. null: Vicinae's default (`control+N`).
action_new: ?[]const u8 = null,
/// `action.open`. null: Vicinae's default (`control+O`).
action_open: ?[]const u8 = null,
/// `action.pin`. null: Vicinae's default (`control+shift+P`).
action_pin: ?[]const u8 = null,
/// `action.refresh`. null: Vicinae's default (`control+R`).
action_refresh: ?[]const u8 = null,
/// `action.remove`. null: Vicinae's default (`control+X`).
action_remove: ?[]const u8 = null,
/// `action.save`. null: Vicinae's default (`control+S`).
action_save: ?[]const u8 = null,

/// Vicinae's id for the field `name`: `action_` becomes `action.`, and every other `_` a `-`.
pub fn id(comptime name: []const u8) []const u8 {
    comptime {
        const action = "action_";
        var text: [name.len]u8 = name[0..name.len].*;
        const start = if (std.mem.startsWith(u8, name, action)) action.len else 0;
        if (start != 0) text[action.len - 1] = '.';
        for (text[start..]) |*byte| {
            if (byte.* == '_') byte.* = '-';
        }
        const final = text;
        return &final;
    }
}

test "field names map to Vicinae's ids" {
    try std.testing.expectEqualStrings("open-search-filter", comptime id("open_search_filter"));
    try std.testing.expectEqualStrings("action.copy", comptime id("action_copy"));
    try std.testing.expectEqualStrings("action.dangerous-remove", comptime id("action_dangerous_remove"));
}
