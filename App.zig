//! A Vicinae theme of its own, and a settings file of its own selecting it with every other
//! setting that is set, both generated whole; Vicinae's settings import the latter. Field names
//! are Vicinae's.

const App = @This();

const std = @import("std");
const kosm = @import("kosm");

/// The theme file kosm owns; `{name}` is filled as `files` says. Vicinae names a theme by its
/// file name without `.toml`. Default: `~/.local/share/vicinae/themes/{name}.toml`.
file: []const u8 = "~/.local/share/vicinae/themes/{name}.toml",
/// How `{name}` in `file` is filled: `kosm`, or the kosmos' name. Default: the theme's `files`.
files: kosm.Theme.Files = .shared,
/// The settings file kosm owns, written whole: the theme selected for both of Vicinae's
/// appearances (`theme.dark` and `theme.light`), and every setting below that is set. null: not
/// written. Default: `~/.config/vicinae/kosm.json`.
kosm_settings: ?[]const u8 = "~/.config/vicinae/kosm.json",
/// Vicinae's own settings, whose `imports` the app makes list `kosm_settings`, adding the key or
/// the entry when missing. Keys set here override the imported ones, so the apply warns about
/// any that `kosm_settings` writes. null: not touched; import `kosm_settings` yourself.
/// Default: `~/.config/vicinae/settings.json`.
settings: ?[]const u8 = "~/.config/vicinae/settings.json",
/// `[meta]`: how Vicinae lists the theme.
meta: Meta = .{},
/// `[colors]`.
colors: Colors = .{},
/// `theme.dark.icon_theme` and `theme.light.icon_theme`: the icon theme's folder name. null
/// (default): not written, Vicinae's default.
icon_theme: ?[]const u8 = null,
/// `telemetry`: what Vicinae reports to its server.
telemetry: Telemetry = .{},
/// `input_server.enabled`: the helper that pastes into the active window and expands snippets;
/// off, Vicinae copies instead of pasting. null: Vicinae's default (on).
input_server: Toggle = .{},
/// `tray.enabled`: Vicinae's icon in the system tray. null: Vicinae's default (on).
tray: Toggle = .{},
/// `updates`: update notices.
updates: Updates = .{},
/// `search_files_in_root`: whether root search finds files too, at some CPU cost. null:
/// Vicinae's default (off).
search_files_in_root: ?bool = null,
/// `activate_on_single_click`: activate list and grid items with one click. null: Vicinae's
/// default (off).
activate_on_single_click: ?bool = null,
/// `escape_key_behavior`: what Escape does. null: Vicinae's default (`navigate_back`).
escape_key_behavior: ?EscapeKeyBehavior = null,
/// `pop_on_backspace`: go back on Backspace in an empty search. null: Vicinae's default (on).
pop_on_backspace: ?bool = null,
/// `close_on_focus_loss`: close the window when it loses focus; does nothing as a layer surface
/// with `exclusive` keyboard interactivity. null: Vicinae's default (off).
close_on_focus_loss: ?bool = null,
/// `consider_preedit`: search an input method's unfinished text as it is typed. null:
/// Vicinae's default (off).
consider_preedit: ?bool = null,
/// `pop_to_root_on_close`: go back to root search whenever the window closes. null: Vicinae's
/// default (off).
pop_to_root_on_close: ?bool = null,
/// `favicon_service`: where favicons come from. null: Vicinae's default (`twenty`).
favicon_service: ?FaviconService = null,
/// `keybinding`: the navigation scheme. null: Vicinae's default (`default`).
keybinding: ?Keybinding = null,
/// `font`: the font of Vicinae's interface.
font: Font = .{},
/// `launcher_window`: the launcher window's look, size and placement.
launcher_window: LauncherWindow = .{},
/// `global_shortcuts`: shortcuts that work system-wide, even with the window closed.
global_shortcuts: GlobalShortcuts = .{},
/// `keybinds`: shortcuts inside the launcher.
keybinds: Keybinds = .{},
/// `favorites`: entrypoint ids shown at the top of root search with no query
/// (`clipboard:history`). null: Vicinae's default (`clipboard:history`).
favorites: ?[]const []const u8 = null,
/// `fallbacks`: entrypoint ids suggested when nothing matches the query (`files:search`). null:
/// Vicinae's default (`files:search`).
fallbacks: ?[]const []const u8 = null,
/// `providers`: settings of the groups root search finds entrypoints in, each id at most once.
/// Default: none.
providers: []const Provider = &.{},

/// `launcher_window`.
pub const LauncherWindow = @import("LauncherWindow.zig");
/// `keybinds`.
pub const Keybinds = @import("Keybinds.zig");
/// One of `providers`.
pub const Provider = @import("Provider.zig");

/// A section holding only `enabled`.
pub const Toggle = struct {
    /// `enabled`. null: not written, Vicinae's default.
    enabled: ?bool = null,
};

/// `telemetry`.
pub const Telemetry = struct {
    /// `system_info`: send the desktop environment, Vicinae's version and such once a day. null:
    /// Vicinae's default (on).
    system_info: ?bool = null,
};

/// `updates`.
pub const Updates = struct {
    /// `show_notice`: show a notice in the launcher when an update is available. null: Vicinae's
    /// default (on).
    show_notice: ?bool = null,
};

/// What Escape does in the launcher.
pub const EscapeKeyBehavior = enum {
    /// Go back one view.
    navigate_back,
    /// Close the window.
    close_window,
};

/// Where Vicinae loads favicons from.
pub const FaviconService = enum {
    /// Twenty's favicon service.
    twenty,
    /// Google's favicon service.
    google,
    /// Load none, showing a placeholder.
    none,
};

/// How the keyboard moves through lists.
pub const Keybinding = enum {
    /// Vicinae's own scheme.
    default,
    /// Vim-style keys.
    vim,
    /// Emacs-style keys.
    emacs,
};

/// `font`.
pub const Font = struct {
    /// `rendering`: how text is drawn. null: Vicinae's default (`qt`, `native` on macOS).
    rendering: ?FontRendering = null,
    /// `normal`: the interface's font.
    normal: FontSpec = .{},
};

/// How Vicinae draws text.
pub const FontRendering = enum {
    /// The platform's rasterizer, like other apps; worse under fractional scaling on Linux.
    native,
    /// Qt's distance fields, faster when scaled or animated.
    qt,
};

/// `font.normal`.
pub const FontSpec = struct {
    /// `family`: a family name, `auto` for the bundled Inter, or `system` for the platform's
    /// default. null: Vicinae's default (`auto`).
    family: ?[]const u8 = null,
    /// `size` in points. null: Vicinae's default (10.5, 13 on macOS).
    size: ?f64 = null,
};

/// `global_shortcuts`.
pub const GlobalShortcuts = struct {
    /// `toggle`: the shortcut opening and closing the launcher, written like `super+space`. null:
    /// Vicinae's default (`super+control+space`, `alt+space` on macOS and Windows).
    toggle: ?[]const u8 = null,
    /// `inhibit_apps`: desktop file ids (`org.gnome.Boxes.desktop`) of apps that, while focused,
    /// get every key instead. null: Vicinae's default (none).
    inhibit_apps: ?[]const []const u8 = null,
};

/// A theme's `[colors]`.
pub const Colors = @import("Colors.zig");

/// `[meta]`.
pub const Meta = struct {
    /// The name Vicinae shows. null (default): the theme's `name`, or the name kosm applies the
    /// kosmos under.
    name: ?[]const u8 = null,
    /// A line describing the theme. Default: `Generated by kosm`.
    description: []const u8 = "Generated by kosm",
    /// Whether the theme is dark or light, which picks Vicinae's icons for it. `from`: the
    /// theme's mode. Default: `.dark`.
    variant: Variant = .dark,
    /// The theme colors left null come from. null: Vicinae's default for the variant.
    inherits: ?[]const u8 = null,
};

/// A theme's variant.
pub const Variant = enum { dark, light };

/// The window's opacity from the theme's `background_alpha`, and colors from the theme: the core from the background, foreground and accent roles, danger
/// and success from the error and success roles, the accents from the wheel, muted text and selections from the theme's variations. The rest Vicinae derives
/// from the core.
pub fn from(theme: kosm.Theme) App {
    const palette = theme.palette;
    const variations = theme.variations;
    const foreground = theme.roles.foreground;
    const background = theme.roles.background;
    const raised = variations.state.selected.apply(background);
    return .{
        .files = theme.files,
        .launcher_window = .{ .opacity = theme.background_alpha },
        .meta = .{ .name = theme.name, .variant = if (theme.mode == .dark) .dark else .light },
        .colors = .{
            .core = .{
                .accent = theme.roles.accent,
                .accent_foreground = background,
                .background = background,
                .foreground = foreground,
                .secondary_background = raised,
                .border = theme.roles.accent,
            },
            .accents = .{
                .blue = palette.blue,
                .green = palette.green,
                .magenta = palette.magenta,
                .orange = palette.orange,
                .red = palette.red,
                .yellow = palette.yellow,
                .cyan = palette.cyan,
                .purple = palette.purple,
            },
            .text = .{
                .muted = variations.emphasis.muted.apply(foreground),
                .danger = theme.roles.@"error",
                .success = theme.roles.success,
                .selection = .{ .background = foreground, .foreground = background },
            },
            .list = .{ .item = .{ .selection = .{
                .background = raised,
                .foreground = variations.emphasis.strong.apply(foreground),
            } } },
        },
    };
}

/// Restarts the running Vicinae when the app sets an icon theme: Vicinae reads an icon theme's
/// files once, so a theme regenerated under the same name shows only after a restart. Its
/// own theme and settings it reloads by itself. With no Vicinae running, kosm only warns.
pub fn reload(self: App, reloader: *kosm.Reloader) !void {
    if (self.icon_theme == null or self.kosm_settings == null) return;
    // `server --replace` kills the old server and becomes the new one, so it runs detached.
    try reloader.run(&.{ "sh", "-c", "vicinae ping >/dev/null 2>&1 && exec setsid -f vicinae server --replace >/dev/null 2>&1" });
}

/// Writes the theme whole, then `kosm_settings` selecting it, and makes `settings` import that.
pub fn apply(self: App, output: *kosm.Output) !void {
    const file = try output.namedFile(self.file, self.files);
    const theme_name = std.Io.Dir.path.stem(file);
    if (!std.mem.eql(u8, std.Io.Dir.path.extension(file), ".toml") or theme_name.len == 0)
        return output.fail(file, "Vicinae reads themes only from '.toml' files", .{});
    var meta: std.ArrayList(kosm.Value.Entry) = .empty;
    try meta.appendSlice(output.allocator, &.{
        .{ .key = "name", .value = .{ .string = try output.displayName(file, self.meta.name) } },
        .{ .key = "description", .value = .{ .string = self.meta.description } },
        .{ .key = "variant", .value = .{ .string = @tagName(self.meta.variant) } },
    });
    if (self.meta.inherits) |inherits| try meta.append(output.allocator, .{ .key = "inherits", .value = .{ .string = inherits } });
    var sections: std.ArrayList(kosm.Value.Entry) = .empty;
    try sections.append(output.allocator, .{ .key = "meta", .value = .{ .table = meta.items } });
    if (try setValue(output, file, self.colors)) |colors| try sections.append(output.allocator, .{ .key = "colors", .value = colors });
    try output.generate(.{ .file = file, .lang = "toml" }, kosm.Value{ .table = sections.items });

    const kosm_settings = self.kosm_settings orelse return;
    const written = try self.settingsValue(output, kosm_settings, theme_name);
    try output.generate(.{ .file = kosm_settings, .lang = "json" }, written);
    const settings_file = self.settings orelse return;
    var settings = try output.edit(.{ .files = settings_file, .lang = "jsonc" });
    try importOnce(output, &settings, try importEntry(output, settings_file, kosm_settings));
    try warnOverridden(output, &settings, kosm_settings, written);
}

/// The fields written to `kosm_settings` after the theme, in the order Vicinae lists them.
const settings_fields = .{
    "telemetry",            "input_server",             "tray",                 "updates",
    "search_files_in_root", "activate_on_single_click", "escape_key_behavior",  "pop_on_backspace",
    "close_on_focus_loss",  "consider_preedit",         "pop_to_root_on_close", "favicon_service",
    "keybinding",           "font",                     "launcher_window",      "global_shortcuts",
    "keybinds",             "favorites",                "fallbacks",            "providers",
};

/// What `kosm_settings` holds: the theme for both appearances, and every setting that is set.
fn settingsValue(self: App, output: *kosm.Output, kosm_settings: []const u8, theme_name: []const u8) kosm.Output.Error!kosm.Value {
    const allocator = output.allocator;
    var appearance: std.ArrayList(kosm.Value.Entry) = .empty;
    try appearance.append(allocator, .{ .key = "name", .value = .{ .string = theme_name } });
    if (self.icon_theme) |icon_theme| try appearance.append(allocator, .{ .key = "icon_theme", .value = .{ .string = icon_theme } });
    const theme = try allocator.dupe(kosm.Value.Entry, &.{
        .{ .key = "dark", .value = .{ .table = appearance.items } },
        .{ .key = "light", .value = .{ .table = appearance.items } },
    });
    var sections: std.ArrayList(kosm.Value.Entry) = .empty;
    try sections.append(allocator, .{ .key = "theme", .value = .{ .table = theme } });
    inline for (settings_fields) |name| {
        if (try setValue(output, kosm_settings, @field(self, name))) |value| try sections.append(allocator, .{ .key = name, .value = value });
    }
    return .{ .table = sections.items };
}

/// `value` as Vicinae reads it, or null when nothing in it is set: a null optional, a section
/// with nothing set, or an empty list of providers or preferences. Fails, naming `file`, on an id
/// given twice among providers, or among one provider's entrypoints or tools.
fn setValue(output: *kosm.Output, file: []const u8, value: anytype) kosm.Output.Error!?kosm.Value {
    const T = @TypeOf(value);
    if (T == kosm.Color) return .{ .color = value };
    if (T == bool) return .{ .boolean = value };
    if (T == u32) return .{ .integer = value };
    if (T == f64) return .{ .float = value };
    if (T == []const u8) return .{ .string = value };
    if (T == []const []const u8) {
        const items = try output.allocator.alloc(kosm.Value, value.len);
        for (value, items) |text, *item| item.* = .{ .string = text };
        return .{ .list = items };
    }
    if (T == []const kosm.Value.Entry) return if (value.len == 0) null else .{ .table = value };
    if (T == Keybinds) return keybindsTable(output.allocator, value);
    if (T == []const Provider) return keyedTable(output, file, "provider", value);
    if (T == []const Provider.Entrypoint) return keyedTable(output, file, "entrypoint", value);
    if (T == []const Provider.Tool) return keyedTable(output, file, "tool", value);
    switch (@typeInfo(T)) {
        .optional => return if (value) |present| setValue(output, file, present) else null,
        .@"enum" => return .{ .string = @tagName(value) },
        .@"struct" => return structTable(output, file, value),
        else => @compileError("kosm_vicinae cannot write a " ++ @typeName(T)),
    }
}

/// The set fields of `section` by name, but `id`; null when none is set.
fn structTable(output: *kosm.Output, file: []const u8, section: anytype) kosm.Output.Error!?kosm.Value {
    var entries: std.ArrayList(kosm.Value.Entry) = .empty;
    inline for (@typeInfo(@TypeOf(section)).@"struct".field_names) |name| {
        if (comptime std.mem.eql(u8, name, "id")) continue;
        if (try setValue(output, file, @field(section, name))) |value| try entries.append(output.allocator, .{ .key = name, .value = value });
    }
    return if (entries.items.len == 0) null else .{ .table = entries.items };
}

/// The set keybinds under Vicinae's ids; null when none is.
fn keybindsTable(allocator: std.mem.Allocator, keybinds: Keybinds) std.mem.Allocator.Error!?kosm.Value {
    var entries: std.ArrayList(kosm.Value.Entry) = .empty;
    inline for (@typeInfo(Keybinds).@"struct".field_names) |name| {
        if (@field(keybinds, name)) |shortcut| try entries.append(allocator, .{ .key = comptime Keybinds.id(name), .value = .{ .string = shortcut } });
    }
    return if (entries.items.len == 0) null else .{ .table = entries.items };
}

/// `items` as a table keyed by their ids, failing on an id given twice; null when there are none.
fn keyedTable(output: *kosm.Output, file: []const u8, comptime what: []const u8, items: anytype) kosm.Output.Error!?kosm.Value {
    if (items.len == 0) return null;
    const entries = try output.allocator.alloc(kosm.Value.Entry, items.len);
    for (items, entries, 0..) |item, *entry, index| {
        for (items[0..index]) |earlier| {
            if (std.mem.eql(u8, earlier.id, item.id)) return output.fail(file, what ++ " '{s}' is listed twice; keep one", .{item.id});
        }
        const settings = try structTable(output, file, item) orelse kosm.Value{ .table = &.{} };
        entry.* = .{ .key = item.id, .value = settings };
    }
    return .{ .table = entries };
}

/// How `settings` names `kosm_settings` in its `imports`: by file name when both are in one
/// folder, as Vicinae reads relative paths from the importing file's folder, else by full path.
fn importEntry(output: *kosm.Output, settings: []const u8, kosm_settings: []const u8) kosm.Output.Error![]const u8 {
    const folder = std.Io.Dir.path.dirname(kosm_settings) orelse "";
    if (std.mem.eql(u8, folder, std.Io.Dir.path.dirname(settings) orelse "")) return std.Io.Dir.path.basename(kosm_settings);
    if (std.mem.startsWith(u8, kosm_settings, "~/")) return std.mem.concat(output.allocator, u8, &.{ output.home, kosm_settings[1..] });
    return kosm_settings;
}

/// Adds `entry` to the settings' `imports`, and the key itself when missing, unless it is listed.
fn importOnce(output: *kosm.Output, settings: *kosm.Output.Selection, entry: []const u8) kosm.Output.Error!void {
    const imports = try settings.nodes("imports");
    if (imports.len == 0) return settings.insert((try settings.nodes(""))[0], "imports", &[_][]const u8{entry});
    if (imports.len > 1) return output.fail(settings.selector, "has 'imports' {d} times; keep one", .{imports.len});
    for (try settings.elements(imports[0])) |element| {
        if (sameImport(element.text, entry)) return;
    }
    try settings.append(imports[0], entry);
}

/// Whether an `imports` element as written (`"./kosm.json"`) names `entry`.
fn sameImport(text: []const u8, entry: []const u8) bool {
    if (text.len < 2 or text[0] != '"' or text[text.len - 1] != '"') return false;
    const path = text[1 .. text.len - 1];
    return std.mem.eql(u8, path, entry) or (std.mem.startsWith(u8, path, "./") and std.mem.eql(u8, path[2..], entry));
}

/// Warns about the values `kosm_settings` writes (`written`) that `settings` also sets, which win
/// over it: Vicinae merges sections key by key, and takes a list whole.
fn warnOverridden(output: *kosm.Output, settings: *kosm.Output.Selection, kosm_settings: []const u8, written: kosm.Value) kosm.Output.Error!void {
    var overridden: std.ArrayList(u8) = .empty;
    for (try kosm.Setting.leaves(output.allocator, written)) |leaf| {
        if ((try settings.nodes(leaf.path)).len == 0) continue;
        if (overridden.items.len != 0) try overridden.appendSlice(output.allocator, ", ");
        try overridden.appendSlice(output.allocator, leaf.path);
    }
    if (overridden.items.len == 0) return;
    try output.warn(settings.selector, "sets {s}, which override {s}; remove them to use kosm's", .{ overridden.items, kosm_settings });
}

const testing = std.testing;
const root = @import("root.zig");

const Fixture = struct {
    tmp: testing.TmpDir,
    arena: std.heap.ArenaAllocator,
    plan: kosm.Plan,
    diagnostics: kosm.Diagnostics = .{},
    warnings: kosm.Warnings = undefined,
    home_buffer: [std.Io.Dir.max_path_bytes]u8 = undefined,
    output: kosm.Output = undefined,

    fn init(fixture: *Fixture, settings: ?[]const u8) !void {
        fixture.* = .{ .tmp = testing.tmpDir(.{}), .arena = .init(testing.allocator), .plan = .init(testing.allocator, testing.io) };
        if (settings) |text| {
            try fixture.tmp.dir.createDirPath(testing.io, ".config/vicinae");
            try fixture.tmp.dir.writeFile(testing.io, .{ .sub_path = ".config/vicinae/settings.json", .data = text });
        }
        fixture.warnings = .init(fixture.arena.allocator());
        const length = try fixture.tmp.dir.realPath(testing.io, &fixture.home_buffer);
        fixture.output = .{
            .allocator = fixture.arena.allocator(),
            .home = fixture.home_buffer[0..length],
            .adapters = &.{ root.toml_adapter, root.json_adapter, root.jsonc_adapter },
            .plan = &fixture.plan,
            .diagnostics = &fixture.diagnostics,
            .warnings = &fixture.warnings,
            .app = "vicinae",
            .kosmos = "krystallos.dark",
        };
    }

    fn deinit(fixture: *Fixture) void {
        fixture.plan.deinit();
        fixture.arena.deinit();
        fixture.tmp.cleanup();
    }

    fn planned(fixture: *Fixture, display_path: []const u8) []const u8 {
        for (fixture.plan.files.items) |file| {
            if (std.mem.eql(u8, file.display_path, display_path)) return file.new;
        }
        return "(not planned)";
    }
};

/// Settings as Vicinae writes them before kosm, comments included, with keys kosm writes too.
const settings_json =
    \\// This configuration is merged with the default vicinae configuration file.
    \\{
    \\   "font": {
    \\      "normal": {
    \\         "family": "Maple Mono Normal NFP",
    \\         "size": 13
    \\      }
    \\   },
    \\   "theme": {
    \\      "dark": {
    \\         "name": "Ricer",
    \\         "icon_theme": "Ricer"
    \\      }
    \\   },
    \\   "launcher_window": {
    \\      "opacity": 0.6
    \\   }
    \\}
    \\
;

/// Settings with none of the keys kosm writes.
const clean_settings =
    \\// Vicinae
    \\{
    \\   "telemetry": {
    \\      "system_info": false
    \\   } // mine
    \\}
    \\
;

const test_theme = kosm.Theme.from(.{ .palette = .{ .black = kosm.hex("041c26"), .white = kosm.hex("a3c5cc"), .cyan = kosm.hex("2d8699") }, .mode = .dark });

test "the theme is written whole, kosm.json selects it for both appearances, and the settings import it" {
    var fixture: Fixture = undefined;
    try fixture.init(clean_settings);
    defer fixture.deinit();
    var app = from(test_theme);
    app.font.normal = .{ .family = "Iosevka", .size = 12.5 };
    app.icon_theme = "kosm";
    try app.apply(&fixture.output);

    const written = fixture.planned("~/.local/share/vicinae/themes/kosm.toml");
    try testing.expect(std.mem.startsWith(u8, written,
        \\[meta]
        \\name = "krystallos.dark"
        \\description = "Generated by kosm"
        \\variant = "dark"
        \\
        \\[colors.core]
        \\accent = "#2d8699"
        \\accent_foreground = "#041c26"
        \\background = "#041c26"
        \\foreground = "#a3c5cc"
        \\
    ));
    try testing.expect(std.mem.indexOf(u8, written, "[colors.accents]\nblue = ") != null);
    try testing.expect(std.mem.indexOf(u8, written, "main_window") == null);
    try testing.expect(std.mem.indexOf(u8, written, "[colors.text.selection]\nbackground = \"#a3c5cc\"\nforeground = \"#041c26\"\n") != null);
    try testing.expect(std.mem.indexOf(u8, written, "[colors.list.item.selection]\n") != null);

    try testing.expectEqualStrings(
        \\{
        \\  "theme": {
        \\    "dark": {
        \\      "name": "kosm",
        \\      "icon_theme": "kosm"
        \\    },
        \\    "light": {
        \\      "name": "kosm",
        \\      "icon_theme": "kosm"
        \\    }
        \\  },
        \\  "font": {
        \\    "normal": {
        \\      "family": "Iosevka",
        \\      "size": 12.5
        \\    }
        \\  },
        \\  "launcher_window": {
        \\    "opacity": 1
        \\  }
        \\}
        \\
    , fixture.planned("~/.config/vicinae/kosm.json"));
    try testing.expectEqualStrings(
        \\// Vicinae
        \\{
        \\   "telemetry": {
        \\      "system_info": false
        \\   }, // mine
        \\   "imports": ["kosm.json"]
        \\}
        \\
    , fixture.planned("~/.config/vicinae/settings.json"));
    try testing.expectEqual(0, fixture.warnings.items.items.len);
}

test "an import already listed is kept, another list gains it, and keys that override kosm.json warn" {
    const cases = [_]struct { settings: []const u8, expected: []const u8 }{
        .{ .settings = "{\"imports\": [\"./kosm.json\"]}", .expected = "{\"imports\": [\"./kosm.json\"]}" },
        .{ .settings = "{\"imports\": [\"keys.json\"]}", .expected = "{\"imports\": [\"keys.json\", \"kosm.json\"]}" },
    };
    for (cases) |case| {
        var fixture: Fixture = undefined;
        try fixture.init(case.settings);
        defer fixture.deinit();
        try from(test_theme).apply(&fixture.output);
        try testing.expectEqualStrings(case.expected, fixture.planned("~/.config/vicinae/settings.json"));
    }

    var fixture: Fixture = undefined;
    try fixture.init(settings_json);
    defer fixture.deinit();
    try from(test_theme).apply(&fixture.output);
    try testing.expectEqual(1, fixture.warnings.items.items.len);
    try testing.expectEqualStrings("sets theme.dark.name, launcher_window.opacity, which override ~/.config/vicinae/kosm.json; remove them to use kosm's", fixture.warnings.items.items[0].message);
}

test "kosm.json in another folder is imported by full path, and none is written with kosm_settings null" {
    var fixture: Fixture = undefined;
    try fixture.init(clean_settings);
    defer fixture.deinit();
    var app = from(test_theme);
    app.kosm_settings = "~/kosm/vicinae.json";
    try app.apply(&fixture.output);
    const expected = try std.mem.concat(fixture.arena.allocator(), u8, &.{ "\"imports\": [\"", fixture.output.home, "/kosm/vicinae.json\"]" });
    try testing.expect(std.mem.indexOf(u8, fixture.planned("~/.config/vicinae/settings.json"), expected) != null);

    var untouched: Fixture = undefined;
    try untouched.init(clean_settings);
    defer untouched.deinit();
    app.kosm_settings = null;
    try app.apply(&untouched.output);
    try testing.expectEqual(1, untouched.plan.files.items.len);
}

test "App{} writes only the meta and kosm.json selecting it, and a bad file fails" {
    var fixture: Fixture = undefined;
    try fixture.init(null);
    defer fixture.deinit();
    const empty: App = .{ .settings = null };
    try empty.apply(&fixture.output);
    try testing.expectEqualStrings("[meta]\nname = \"krystallos.dark\"\ndescription = \"Generated by kosm\"\nvariant = \"dark\"\n", fixture.planned("~/.local/share/vicinae/themes/kosm.toml"));
    try testing.expect(std.mem.startsWith(u8, fixture.planned("~/.config/vicinae/kosm.json"), "{\n  \"theme\": {\n    \"dark\": {\n      \"name\": \"kosm\"\n"));

    const wrong: App = .{ .file = "~/.local/share/vicinae/themes/kosm.json" };
    try testing.expectError(error.AppFailed, wrong.apply(&fixture.output));
    try testing.expectEqualStrings("Vicinae reads themes only from '.toml' files", fixture.diagnostics.message());
}

test "per kosmos, the theme is a file of the kosmos' own, selected by it and showing the theme's name" {
    var fixture: Fixture = undefined;
    try fixture.init(clean_settings);
    defer fixture.deinit();
    var theme = test_theme;
    theme.name = "Krystallos";
    theme.files = .per_kosmos;
    try from(theme).apply(&fixture.output);

    const written = fixture.planned("~/.local/share/vicinae/themes/krystallos.dark.toml");
    try testing.expect(std.mem.startsWith(u8, written, "[meta]\nname = \"Krystallos\"\n"));
    try testing.expect(std.mem.indexOf(u8, fixture.planned("~/.config/vicinae/kosm.json"), "\"name\": \"krystallos.dark\"") != null);
}

test "the launcher window's rounding, material, border and shadow go in kosm.json, and settings setting them warn" {
    var fixture: Fixture = undefined;
    try fixture.init("{\"launcher_window\": {\"client_side_decorations\": {\"rounding\": 4, \"border_width\": 1}}}");
    defer fixture.deinit();
    const app: App = .{ .launcher_window = .{ .rounding = 0, .material = .none, .client_side_decorations = .{ .border_width = 2, .shadow_size = 0 } } };
    try app.apply(&fixture.output);
    try testing.expectEqualStrings(
        \\{
        \\  "theme": {
        \\    "dark": {
        \\      "name": "kosm"
        \\    },
        \\    "light": {
        \\      "name": "kosm"
        \\    }
        \\  },
        \\  "launcher_window": {
        \\    "material": "none",
        \\    "rounding": 0,
        \\    "client_side_decorations": {
        \\      "border_width": 2,
        \\      "shadow_size": 0
        \\    }
        \\  }
        \\}
        \\
    , fixture.planned("~/.config/vicinae/kosm.json"));
    try testing.expectEqual(1, fixture.warnings.items.items.len);
    // The deprecated `client_side_decorations.rounding` is read only without `rounding`, so it does not warn.
    try testing.expectEqualStrings("sets launcher_window.client_side_decorations.border_width, which override ~/.config/vicinae/kosm.json; remove them to use kosm's", fixture.warnings.items.items[0].message);
}

test "every section is written in Vicinae's names, keybinds under their ids and providers by id" {
    var fixture: Fixture = undefined;
    try fixture.init(null);
    defer fixture.deinit();
    const app: App = .{
        .settings = null,
        .tray = .{ .enabled = false },
        .escape_key_behavior = .close_window,
        .font = .{ .rendering = .native },
        .launcher_window = .{
            .size = .{ .width = 900 },
            .layer_shell = .{ .keyboard_interactivity = .on_demand, .layer = .overlay },
            .clock = .{ .format = "hh:mm" },
        },
        .global_shortcuts = .{ .inhibit_apps = &.{"org.gnome.Boxes.desktop"} },
        .keybinds = .{ .open_settings = "control+;", .action_copy_name = "control+shift+N" },
        .favorites = &.{},
        .providers = &.{.{
            .id = "clipboard",
            .enabled = true,
            .entrypoints = &.{.{ .id = "history", .shortcut = "super+V", .preferences = &.{.{ .key = "limit", .value = .{ .integer = 50 } }} }},
            .tools = &.{.{ .id = "copy", .policy = .ask }},
        }},
    };
    try app.apply(&fixture.output);
    const written = fixture.planned("~/.config/vicinae/kosm.json");
    const expected =
        \\  "tray": {
        \\    "enabled": false
        \\  },
        \\  "escape_key_behavior": "close_window",
        \\  "font": {
        \\    "rendering": "native"
        \\  },
        \\  "launcher_window": {
        \\    "clock": {
        \\      "format": "hh:mm"
        \\    },
        \\    "size": {
        \\      "width": 900
        \\    },
        \\    "layer_shell": {
        \\      "keyboard_interactivity": "on_demand",
        \\      "layer": "overlay"
        \\    }
        \\  },
        \\  "global_shortcuts": {
        \\    "inhibit_apps": [
        \\      "org.gnome.Boxes.desktop"
        \\    ]
        \\  },
        \\  "keybinds": {
        \\    "open-settings": "control+;",
        \\    "action.copy-name": "control+shift+N"
        \\  },
        \\  "favorites": [],
        \\  "providers": {
        \\    "clipboard": {
        \\      "enabled": true,
        \\      "entrypoints": {
        \\        "history": {
        \\          "shortcut": "super+V",
        \\          "preferences": {
        \\            "limit": 50
        \\          }
        \\        }
        \\      },
        \\      "tools": {
        \\        "copy": {
        \\          "policy": "ask"
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
        \\
    ;
    try testing.expect(std.mem.endsWith(u8, written, expected));
}

test "an id listed twice fails, naming it" {
    var fixture: Fixture = undefined;
    try fixture.init(null);
    defer fixture.deinit();
    const app: App = .{ .providers = &.{.{ .id = "files", .entrypoints = &.{ .{ .id = "search" }, .{ .id = "search", .enabled = false } } }} };
    try testing.expectError(error.AppFailed, app.apply(&fixture.output));
    try testing.expectEqualStrings("entrypoint 'search' is listed twice; keep one", fixture.diagnostics.message());
}

test "settings overriding a keybind, a list or a provider's entrypoint warn, other keys of those sections do not" {
    var fixture: Fixture = undefined;
    try fixture.init(
        \\{
        \\  "keybinds": {"action.copy": "control+C", "action.pin": "control+P"},
        \\  "favorites": ["files:search"],
        \\  "providers": {"clipboard": {"entrypoints": {"history": {"enabled": false}}}}
        \\}
    );
    defer fixture.deinit();
    const app: App = .{
        .keybinds = .{ .action_copy = "control+shift+C" },
        .favorites = &.{"clipboard:history"},
        .providers = &.{.{ .id = "clipboard", .enabled = true, .entrypoints = &.{.{ .id = "history", .enabled = true }} }},
    };
    try app.apply(&fixture.output);
    try testing.expectEqual(1, fixture.warnings.items.items.len);
    try testing.expectEqualStrings("sets keybinds.\"action.copy\", favorites, providers.clipboard.entrypoints.history.enabled, which override ~/.config/vicinae/kosm.json; remove them to use kosm's", fixture.warnings.items.items[0].message);
}
