//! `launcher_window`: the launcher window's look, size and placement. null fields are not
//! written, leaving Vicinae's default.

const LauncherWindow = @This();

const App = @import("App.zig");

/// `opacity`: how opaque the window is, 0 to 1; other surfaces follow the Vicinae theme. `from`:
/// the theme's `background_alpha`. null: Vicinae's default (opaque, or translucent with a
/// material).
opacity: ?f64 = null,
/// `material`: what shows through a translucent window. null: Vicinae's default (`auto`).
material: ?Material = null,
/// `rounding`: the window's corner radius in pixels. null: Vicinae's default (10).
rounding: ?u32 = null,
/// `clock`: the clock in the root search's status bar, shown when there is nothing better to show.
clock: Clock = .{},
/// `client_side_decorations`: the border and shadow Vicinae draws itself instead of the
/// compositor.
client_side_decorations: ClientSideDecorations = .{},
/// `compact_mode.enabled`: show only the search bar until a query is typed. Works best as a
/// layer surface. null: Vicinae's default (off).
compact_mode: App.Toggle = .{},
/// `size`: the window's size in pixels; Vicinae is designed for the default's aspect ratio.
size: Size = .{},
/// `screen`: the screen to show the window on, as xrandr names it (`DP-1`), or `auto`. X11 only,
/// and experimental. null: Vicinae's default (`auto`).
screen: ?[]const u8 = null,
/// `layer_shell`: showing the window as a wlr-layer-shell surface, where the compositor offers it.
layer_shell: LayerShell = .{},

/// What shows through a translucent window; visible only with `opacity` below 1.
pub const Material = enum {
    /// The window's background alone.
    none,
    /// The desktop behind it, blurred.
    blur,
    /// Liquid glass, where the compositor offers it.
    liquid_glass,
    /// Liquid glass when available, else blur.
    auto,
};

/// `clock`.
pub const Clock = struct {
    /// `enabled`: whether the clock shows. null: Vicinae's default (on, except on macOS).
    enabled: ?bool = null,
    /// `format`: a Qt date-time format (`hh:mm:ss`). null: Vicinae's default (the locale's `hh:mm`).
    format: ?[]const u8 = null,
    /// `interval`: how often the clock updates, in seconds. null: Vicinae's default (60).
    interval: ?u32 = null,
};

/// `client_side_decorations`, drawn on Linux only.
pub const ClientSideDecorations = struct {
    /// `enabled`: whether Vicinae draws them; off lets the compositor decorate the window. null:
    /// Vicinae's default (on).
    enabled: ?bool = null,
    /// `border_width`: the border around the window, in pixels. null: Vicinae's default (1).
    border_width: ?u32 = null,
    /// `shadow_size`: the shadow around the window, in pixels; drawn only as a layer surface on a
    /// compositor that can blur a region. null: Vicinae's default (12).
    shadow_size: ?u32 = null,
};

/// `size`.
pub const Size = struct {
    /// `width` in pixels. null: Vicinae's default (770).
    width: ?u32 = null,
    /// `height` in pixels. null: Vicinae's default (480).
    height: ?u32 = null,
};

/// `layer_shell`.
pub const LayerShell = struct {
    /// `enabled`: whether the window is a layer surface. null: Vicinae's default (on).
    enabled: ?bool = null,
    /// `keyboard_interactivity`: whether the window takes the keyboard while open. null:
    /// Vicinae's default (`exclusive`).
    keyboard_interactivity: ?KeyboardInteractivity = null,
    /// `layer`: which layer the window shows on. null: Vicinae's default (`top`).
    layer: ?Layer = null,
};

/// How a layer surface takes the keyboard.
pub const KeyboardInteractivity = enum {
    /// Always while open; breaks the mouse on popups such as the action panel on Hyprland, and
    /// makes `close_on_focus_loss` do nothing.
    exclusive,
    /// Only while focused.
    on_demand,
};

/// The layer a layer surface shows on.
pub const Layer = enum {
    /// Above windows, below IME popovers.
    top,
    /// Above everything, IME popovers included.
    overlay,
};
