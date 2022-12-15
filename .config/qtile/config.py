# -*- coding: utf-8 -*-
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401

import colors

mod = "mod4"
myTerminal = "alacritty"

doomOne = colors.doomOne()
dracula = colors.dracula()
everforest = colors.everforest()
nord = colors.nord()
gruvbox = colors.gruvbox()

#Choose colorscheme
colorscheme = dracula

#Colorschme funcstion
colors, backgroundColor, foregroundColor, workspaceColor, foregroundColorTwo = colorscheme

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazqtile.widget.Sep(**config)[source]y.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(myTerminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "f", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "shift"], "p", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]


# Create labels for groups and assign them a default layout.
groups = []

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

group_labels = ["", "", "", "", "", "", "", "", ""]
# group_labels = ["", "", "", "", "", "", "", "", "ﭮ", "", "", "﨣"]
group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]

# Add group names, labels, and default layouts to the groups object.
for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

# Add group specific keybindings
for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Mod + number to move to that group."),
        Key(["mod1"], "Tab", lazy.screen.next_group(),
            desc="Move to next group."),
        Key(["mod1", "shift"], "Tab", lazy.screen.prev_group(),
            desc="Move to previous group."),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            desc="Move focused window to new group."),
    ])



layout_theme = {"border_width": 2,
                "margin": 10,
                "border_focus": "#bd93f9",
                "border_normal": "#44475a"
                }

layouts = [
    #layout.MonadWide(**layout_theme),
    #layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.Columns(**layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Stack(num_stacks=2),
    # layout.TreeTab(
    #      font = "Ubuntu",
    #      fontsize = 10,
    #      sections = ["FIRST", "SECOND", "THIRD", "FOURTH"],
    #      section_fontsize = 10,
    #      border_width = 2,
    #      bg_color = "1c1f24",
    #      active_bg = "c678dd",
    #      active_fg = "000000",
    #      inactive_bg = "a9a1e1",
    #      inactive_fg = "1c1f24",
    #      padding_left = 0,
    #      padding_x = 0,
    #      padding_y = 5,
    #      section_top = 10,
    #      section_bottom = 20,
    #      level_shift = 8,
    #      vspace = 3,
    #      panel_width = 200
    #      ),
    # layout.Floating(**layout_theme)
]

widget_defaults = dict(
    font = "JetBrains Mono Nerd Font",
    fontsize = 19,
    padding = 5,
)
extension_defaults = widget_defaults.copy()

separator =  widget.TextBox(
                       text = '|',
                        font="JetBrains Mono Nerd Font",
                       background = colors[0],
                       foreground = foregroundColor,
                       padding = 5,
                       fontsize = 16
                       )

indent = widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       )

screens = [
    Screen(
        top=bar.Bar(
            [
                indent,
                widget.Image(
                        filename = "~/.config/qtile/icons/python.png",
                        scale = "False",
                        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerminal)}
                       ),
                indent,
                widget.GroupBox(
                        margin_y = 5,
                        margin_x = 0,
                        padding_y = 5,
                        padding_x = 3,
                        borderwidth = 3,
                        active = workspaceColor,
                        inactive = colors[2],
                        rounded = False,
                        highlight_color = foregroundColorTwo,
                        highlight_method = "line",
                        this_current_screen_border = colors[6],
                        this_screen_border = workspaceColor,
                        other_current_screen_border = workspaceColor,
                        other_screen_border = workspaceColor,
                        foreground = foregroundColor,
                        background = backgroundColor
                        ),
                separator,
                # widget.CurrentLayoutIcon(
                #         custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                #         scale = 0.7
                #         foreground = foregroundColor,
                #         background = backgroundColor,
                #         padding = 0
                #         ),
                widget.CurrentLayout(
                        foreground = colors[4],
                        background = backgroundColor,
                        padding = 5
                        ),
                separator,
                widget.Prompt(),
                widget.WindowName(
                        foreground = colors[6],
                        background = backgroundColor,
                        padding = 0
                        ),
                indent,
                widget.CheckUpdates(
                        update_interval = 1800,
                        distro = "Arch_checkupdates",
                        display_format = "Updates: {updates} ",
                        colour_have_updates = colors[5],
                        colour_no_updates = colors[5],
                        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(f"{myTerminal} -e sudo pacman -Syyu")},
                        foreground = colors[5],
                        background = backgroundColor,
                        padding = 5
                        ),
                indent,
                widget.Net(
                        interface = "eno1",
                        format = 'Net: {down} ↓↑ {up}',
                        foreground = colors[10],
                        background = backgroundColor,
                        padding = 5
                        ),
                indent,
                widget.Memory(
                        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(f"{myTerminal}  -e htop")},
                        fmt = 'Mem: {}',
                        measure_mem='G',
                        foreground = colors[9],
                        background = backgroundColor,
                        padding = 5
                        ),
                indent,
                widget.Volume(
                        fmt = 'Vol: {}',
                        foreground = colors[7],
                        background = backgroundColor,
                        padding = 5
                        ),
                widget.KeyboardLayout(
                        fmt = 'Keyboard: {}',
                        configured_keyboards = ["en", "ru"],
                        foreground = colors[8],
                        background = backgroundColor,
                        padding = 5
                        ),
                indent,
                widget.Clock(
                        format = "%A, %B %d - %H:%M ",
                        foreground = colors[6],
                        background = backgroundColor,
                        padding = 5
                        ),
                indent,
                widget.Systray(
                        foreground = colors[7],
                        background = backgroundColor,
                        padding = 5
                        ),
                indent,
            ],
            28
        ),

    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="scratchpad")
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([f"{home}/.config/qtile/autostart.sh"])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
