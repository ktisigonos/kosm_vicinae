# kosm_vicinae

Vicinae for kosm: a theme of its own, and a settings file of its own selecting it.

The app writes the theme whole to `~/.local/share/vicinae/themes/kosm.toml`, with only the
colors that are set; Vicinae derives the rest from the core colors, or takes them from
`meta.inherits`. It then writes `~/.config/vicinae/kosm.json` whole: the theme selected for both
of Vicinae's appearances (`theme.dark.name` and `theme.light.name`), the icon theme
(`theme.*.icon_theme`), and every other setting of `vicinae config default` that is set, under
Vicinae's names. Deprecated settings (`launcher_window.blur`,
`launcher_window.client_side_decorations.rounding`) are left out, as are `imports`, which the app
manages, and the theme names, which select kosm's theme.

Vicinae reads `kosm.json` through the `imports` of `~/.config/vicinae/settings.json`, which the
app keeps listing it: when the entry is missing it is added at the end of `imports`, or the key
itself at the end of the settings, keeping their comments and layout. Keys in `settings.json`
override imported ones key by key (a list whole), so the apply warns about any it sets that
`kosm.json` writes; remove them there. Set `settings = null` to leave `settings.json` alone and import `kosm.json` yourself,
or `kosm_settings = null` to write only the theme.

Vicinae reloads its theme and settings by itself. With `icon_theme` set, every apply restarts
a running Vicinae server (`vicinae server --replace`, detached): it reads an icon theme's files
only once, so recolored icons under the same name would not show otherwise. With no Vicinae
running, kosm only warns.

Vicinae lists the theme under the theme's `name` (`Theme.name`), or the kosmos' name when that
is null. With the theme's `files = .per_kosmos` the file is named after the kosmos instead
(`krystallos.dark.toml`, selected as `krystallos.dark`), so each kosmos applied keeps its own.

`from(theme)` sets the core colors from the theme's background, foreground and accent roles,
danger and success from the error and success roles, links from the link and visited roles, the accents from the wheel, muted text and selections from the theme's variations, and the variant from the
theme's mode, and the opacity from the theme's `background_alpha`, so an opaque theme makes
the launcher opaque. The font is left alone.

## Fields

| Field | Default |
|---|---|
| `file` | `~/.local/share/vicinae/themes/{name}.toml`; `{name}` is `kosm`, or the kosmos' name with `files = .per_kosmos`; the theme is selected by the file name without `.toml` |
| `files` | the theme's `files`: `.shared` or `.per_kosmos` |
| `kosm_settings` | `~/.config/vicinae/kosm.json`, written whole; null writes none |
| `settings` | `~/.config/vicinae/settings.json`, made to import `kosm_settings`; null leaves it alone |
| `meta` | `name` (the theme's `name`, or the name kosm applies the kosmos under), `description`, `variant = .dark` (picks Vicinae's icons), `inherits = null` |
| `colors` | every section of Vicinae's theme template (`vicinae theme template`): `core`, `main_window`, `settings_window`, `accents`, `shortcut`, `text`, `input`, `button`, `list`, `grid`, `scrollbars`, `loading`; null leaves each color to Vicinae |
| `icon_theme` | null: not written; the icon theme's folder name, which `kosm_base` sets |
| `telemetry.system_info` | null (Vicinae's on) |
| `input_server.enabled`, `tray.enabled` | null (Vicinae's on) |
| `updates.show_notice` | null (Vicinae's on) |
| `search_files_in_root`, `activate_on_single_click`, `close_on_focus_loss`, `consider_preedit`, `pop_to_root_on_close` | null (Vicinae's off) |
| `pop_on_backspace` | null (Vicinae's on) |
| `escape_key_behavior` | null (Vicinae's `navigate_back`); `.navigate_back` or `.close_window` |
| `favicon_service` | null (Vicinae's `twenty`); `.twenty`, `.google` or `.none` |
| `keybinding` | null (Vicinae's `default`); `.default`, `.vim` or `.emacs` |
| `font.rendering` | null (Vicinae's `qt`, `native` on macOS); `.native` or `.qt` |
| `font.normal.family`, `font.normal.size` | null (Vicinae's `auto`, the bundled Inter, at 10.5 points) |
| `launcher_window.opacity` | null; `from`: the theme's `background_alpha` |
| `launcher_window.material` | null (Vicinae's `auto`); `.none`, `.blur`, `.liquid_glass` or `.auto`, shown only with `opacity` below 1 |
| `launcher_window.rounding` | null (Vicinae's 10); the window's corner radius in pixels |
| `launcher_window.clock` | `enabled`, `format` (a Qt date-time format), `interval` (seconds); null leaves each to Vicinae (on, `hh:mm`, 60) |
| `launcher_window.client_side_decorations` | `enabled`, `border_width`, `shadow_size` (drawn only as a layer surface); null leaves each to Vicinae (on, 1, 12) |
| `launcher_window.compact_mode.enabled` | null (Vicinae's off) |
| `launcher_window.size` | `width`, `height` in pixels; null leaves each to Vicinae (770, 480) |
| `launcher_window.screen` | null (Vicinae's `auto`); X11 only |
| `launcher_window.layer_shell` | `enabled`, `keyboard_interactivity` (`.exclusive` or `.on_demand`), `layer` (`.top` or `.overlay`); null leaves each to Vicinae (on, `exclusive`, `top`) |
| `global_shortcuts.toggle` | null (Vicinae's `super+control+space`) |
| `global_shortcuts.inhibit_apps` | null (none); desktop file ids |
| `keybinds` | every shortcut of Vicinae's `keybinds`, its id in snake case (`action_copy_name` is `action.copy-name`); null leaves each to Vicinae |
| `favorites`, `fallbacks` | null (Vicinae's `clipboard:history`, `files:search`); entrypoint ids |
| `providers` | none; `.{ .id = "clipboard", .enabled = true }`; also `preferences`, `entrypoints` (`id`, `alias`, `enabled`, `shortcut`, `preferences`) and `tools` (`id`, `policy`, `preferences`), each id once |
