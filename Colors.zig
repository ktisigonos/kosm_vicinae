//! A Vicinae theme's `[colors]`, mirroring Vicinae's theme template. Every color is optional:
//! null is derived by Vicinae from the core colors, or inherited from `meta.inherits`.

const kosm = @import("kosm");

/// The colors everything else derives from.
core: Core = .{},
/// The launcher window.
main_window: MainWindow = .{},
/// The settings window.
settings_window: Border = .{},
/// Named accent colors, for icons, tags and extensions.
accents: Accents = .{},
/// Keyboard shortcut hints; they have no background of their own yet.
shortcut: Border = .{},
/// Text.
text: Text = .{},
/// Text inputs.
input: Input = .{},
/// Buttons.
button: Button = .{},
/// List views.
list: List = .{},
/// Grid views.
grid: Grid = .{},
/// Scrollbars.
scrollbars: Background = .{},
/// Loading indicators.
loading: Loading = .{},

/// `[colors.core]`.
pub const Core = struct {
    /// The accent: focus and highlights.
    accent: ?kosm.Color = null,
    /// Text on the accent.
    accent_foreground: ?kosm.Color = null,
    /// Window backgrounds.
    background: ?kosm.Color = null,
    /// Default text.
    foreground: ?kosm.Color = null,
    /// Footers, panels and other raised areas.
    secondary_background: ?kosm.Color = null,
    /// Borders.
    border: ?kosm.Color = null,
};

/// `[colors.main_window]`.
pub const MainWindow = struct {
    /// The window's border.
    border: ?kosm.Color = null,
    /// The footer below the results.
    footer: Background = .{},
};

/// A section holding only a border.
pub const Border = struct {
    /// The border.
    border: ?kosm.Color = null,
};

/// A section or state holding only a background.
pub const Background = struct {
    /// The background.
    background: ?kosm.Color = null,
};

/// `[colors.accents]`.
pub const Accents = struct {
    /// Blue.
    blue: ?kosm.Color = null,
    /// Green.
    green: ?kosm.Color = null,
    /// Magenta.
    magenta: ?kosm.Color = null,
    /// Orange.
    orange: ?kosm.Color = null,
    /// Red.
    red: ?kosm.Color = null,
    /// Yellow.
    yellow: ?kosm.Color = null,
    /// Cyan.
    cyan: ?kosm.Color = null,
    /// Purple.
    purple: ?kosm.Color = null,
};

/// `[colors.text]`.
pub const Text = struct {
    /// Default text.
    default: ?kosm.Color = null,
    /// Secondary text: subtitles and hints.
    muted: ?kosm.Color = null,
    /// Errors and destructive actions.
    danger: ?kosm.Color = null,
    /// Successful actions.
    success: ?kosm.Color = null,
    /// Placeholders in empty inputs.
    placeholder: ?kosm.Color = null,
    /// Selected text.
    selection: Pair = .{},
    /// Links.
    links: Links = .{},
};

/// A background and the text on it.
pub const Pair = struct {
    /// The background.
    background: ?kosm.Color = null,
    /// The text.
    foreground: ?kosm.Color = null,
};

/// `[colors.text.links]`.
pub const Links = struct {
    /// Links not yet followed.
    default: ?kosm.Color = null,
    /// Links already followed.
    visited: ?kosm.Color = null,
};

/// `[colors.input]`.
pub const Input = struct {
    /// The border of an input.
    border: ?kosm.Color = null,
    /// The border of the focused input.
    border_focus: ?kosm.Color = null,
    /// The border of an input holding an invalid value.
    border_error: ?kosm.Color = null,
};

/// `[colors.button]`.
pub const Button = struct {
    /// Primary buttons.
    primary: ButtonColors = .{},
};

/// One kind of button.
pub const ButtonColors = struct {
    /// Its background.
    background: ?kosm.Color = null,
    /// Its text.
    foreground: ?kosm.Color = null,
    /// While hovered.
    hover: Highlight = .{},
    /// While focused.
    focus: Highlight = .{},
};

/// A state's background and outline.
pub const Highlight = struct {
    /// The background in this state.
    background: ?kosm.Color = null,
    /// The outline in this state.
    outline: ?kosm.Color = null,
};

/// `[colors.list]`.
pub const List = struct {
    /// List items.
    item: ListItem = .{},
};

/// `[colors.list.item]`.
pub const ListItem = struct {
    /// A hovered item.
    hover: ItemState = .{},
    /// The selected item.
    selection: ItemState = .{},
};

/// A list item's colors in one state.
pub const ItemState = struct {
    /// Its background.
    background: ?kosm.Color = null,
    /// Its title.
    foreground: ?kosm.Color = null,
    /// The background of its accessories.
    secondary_background: ?kosm.Color = null,
    /// Its subtitle and accessories.
    secondary_foreground: ?kosm.Color = null,
};

/// `[colors.grid]`.
pub const Grid = struct {
    /// Grid items.
    item: GridItem = .{},
};

/// `[colors.grid.item]`.
pub const GridItem = struct {
    /// An item's background.
    background: ?kosm.Color = null,
    /// A hovered item.
    hover: Highlight = .{},
    /// The selected item.
    selection: Highlight = .{},
};

/// `[colors.loading]`.
pub const Loading = struct {
    /// The bar below the search field while something loads.
    bar: ?kosm.Color = null,
    /// The spinner of dynamic toasts.
    spinner: ?kosm.Color = null,
};
