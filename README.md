# kosm_vicinae

Vicinae for kosm: a theme of its own, and the launcher's font.

The app writes the theme whole to `~/.local/share/vicinae/themes/kosm.toml`, with only the
colors that are set; Vicinae derives the rest from the core colors, or takes them from
`meta.inherits`. It then edits `~/.config/vicinae/settings.json`, keeping its comments and
other settings: `theme.dark.name` (or `theme.light.name`, by `meta.variant`) becomes `kosm`,
and `font.normal.family` and `font.normal.size` take `font_family` and `font_size` when they
are set. Those keys must be in the settings already, as Vicinae writes them once a theme or
font is picked in its own settings. Set `settings = null` to leave the file alone.

Vicinae lists the theme under the theme's `name` (`Theme.name`), or the kosmos' name when that
is null. With the theme's `files = .per_kosmos` the file is named after the kosmos instead
(`krystallos.dark.toml`, selected as `krystallos.dark`), so each kosmos applied keeps its own.

`from(theme)` sets the core colors from the theme's background, foreground and accent roles,
danger and success from the error and success roles, the accents from the wheel, muted text and selections from the theme's variations, and the variant from the
theme's mode. The font is left alone.

## Fields

| Field | Default |
|---|---|
| `file` | `~/.local/share/vicinae/themes/{name}.toml`; `{name}` is `kosm`, or the kosmos' name with `files = .per_kosmos`; the theme is selected by the file name without `.toml` |
| `files` | the theme's `files`: `.shared` or `.per_kosmos` |
| `settings` | `~/.config/vicinae/settings.json`; null leaves it alone |
| `meta` | `name` (the theme's `name`, or the name kosm applies the kosmos under), `description`, `variant = .dark`, `inherits = null` |
| `colors` | every section of Vicinae's theme template (`vicinae theme template`): `core`, `main_window`, `settings_window`, `accents`, `shortcut`, `text`, `input`, `button`, `list`, `grid`, `scrollbars`, `loading`; null leaves each color to Vicinae |
| `font_family` | null: left as it is |
| `font_size` | null: left as it is |
