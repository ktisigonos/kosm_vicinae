# kosm_vicinae

Vicinae for kosm: a theme of its own, and a settings file of its own selecting it.

The app writes the theme whole to `~/.local/share/vicinae/themes/kosm.toml`, with only the
colors that are set; Vicinae derives the rest from the core colors, or takes them from
`meta.inherits`. It then writes `~/.config/vicinae/kosm.json` whole: the theme selected for both
of Vicinae's appearances (`theme.dark.name` and `theme.light.name`), and `font.normal.family`,
`font.normal.size`, the icon theme (`theme.*.icon_theme`) and `launcher_window.opacity` from
`font_family`, `font_size`, `icon_theme` and `opacity` when they are set.

Vicinae reads `kosm.json` through the `imports` of `~/.config/vicinae/settings.json`, which the
app keeps listing it: when the entry is missing it is added at the end of `imports`, or the key
itself at the end of the settings, keeping their comments and layout. Keys in `settings.json`
override imported ones, so the apply warns about any it sets that `kosm.json` writes; remove
them there. Set `settings = null` to leave `settings.json` alone and import `kosm.json` yourself,
or `kosm_settings = null` to write only the theme.

Vicinae reloads its theme and settings by itself. With `icon_theme` set, every apply restarts
a running Vicinae server (`vicinae server --replace`, detached): it reads an icon theme's files
only once, so recolored icons under the same name would not show otherwise. With no Vicinae
running, kosm only warns.

Vicinae lists the theme under the theme's `name` (`Theme.name`), or the kosmos' name when that
is null. With the theme's `files = .per_kosmos` the file is named after the kosmos instead
(`krystallos.dark.toml`, selected as `krystallos.dark`), so each kosmos applied keeps its own.

`from(theme)` sets the core colors from the theme's background, foreground and accent roles,
danger and success from the error and success roles, the accents from the wheel, muted text and selections from the theme's variations, and the variant from the
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
| `font_family` | null: not written |
| `font_size` | null: not written |
| `icon_theme` | null: not written; the icon theme's folder name, which `kosm_base` sets |
| `opacity` | null: not written; `from`: the theme's `background_alpha` |
