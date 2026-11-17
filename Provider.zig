//! One of `providers`: a group of entrypoints (the items root search can activate, such as
//! applications) with its settings. The ids depend on the extensions installed; Vicinae's
//! settings window ("Extensions") shows them. Unset fields are not written.

const Provider = @This();

const kosm = @import("kosm");

/// The provider's id, the key it is written under (`applications`, `clipboard`).
id: []const u8,
/// `enabled`: whether its entrypoints show. null: Vicinae's default (on).
enabled: ?bool = null,
/// `preferences`: the provider's own preferences by name, as its extension defines them.
/// Default: none.
preferences: []const kosm.Value.Entry = &.{},
/// `entrypoints`: settings of single entrypoints. Default: none.
entrypoints: []const Entrypoint = &.{},
/// `tools`: settings of the AI tools the provider offers. Default: none.
tools: []const Tool = &.{},

/// One of a provider's `entrypoints`.
pub const Entrypoint = struct {
    /// The entrypoint's id within its provider, the key it is written under (`history`).
    id: []const u8,
    /// `alias`: a short name it is also found by. null: Vicinae's default (none).
    alias: ?[]const u8 = null,
    /// `enabled`: whether it shows in root search. null: Vicinae's default (on).
    enabled: ?bool = null,
    /// `shortcut`: a global shortcut opening it, written like `control+shift+V`. null: Vicinae's
    /// default (none).
    shortcut: ?[]const u8 = null,
    /// `preferences`: its own preferences by name, as its extension defines them. Default: none.
    preferences: []const kosm.Value.Entry = &.{},
};

/// One of a provider's `tools`.
pub const Tool = struct {
    /// The tool's id within its provider, the key it is written under.
    id: []const u8,
    /// `policy`: whether an AI may run it. null: Vicinae's default.
    policy: ?Policy = null,
    /// `preferences`: its own preferences by name. Default: none.
    preferences: []const kosm.Value.Entry = &.{},
};

/// Whether an AI may run a tool.
pub const Policy = enum {
    /// Never.
    disabled,
    /// Only after asking.
    ask,
    /// Without asking.
    allow,
};
