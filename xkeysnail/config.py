# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

# define timeout for multipurpose_modmap
define_timeout(1)

# [Global modemap] Change modifier keys as in xmodmap
define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL,
})

# [Conditional modmap] Change modifier keys in certain applications
#define_conditional_modmap(re.compile(r'Emacs'), {
#    Key.RIGHT_CTRL: Key.ESC,
#})

# [Multipurpose modmap] Give a key two meanings. A normal key when pressed and
# released, and a modifier key when held down with another key. See Xcape,
# Carabiner and caps2esc for ideas and concept.
define_multipurpose_modmap(
    # Enter is enter when pressed and released. Control when held down.
    #{Key.ENTER: [Key.ENTER, Key.RIGHT_CTRL]}
    {Key.RIGHT_ALT: [Key.ESC, Key.RIGHT_META]}

    # Capslock is escape when pressed and released. Control when held down.
    # {Key.CAPSLOCK: [Key.ESC, Key.LEFT_CTRL]
    # To use this example, you can't remap capslock with define_modmap.
)

# [Conditional multipurpose modmap] Multipurpose modmap in certain conditions,
# such as for a particular device.
define_conditional_multipurpose_modmap(lambda wm_class, device_name: device_name.startswith("Microsoft"), {
   # Left shift is open paren when pressed and released.
   # Left shift when held down.
   Key.LEFT_SHIFT: [Key.KPLEFTPAREN, Key.LEFT_SHIFT],

   # Right shift is close paren when pressed and released.
   # Right shift when held down.
   Key.RIGHT_SHIFT: [Key.KPRIGHTPAREN, Key.RIGHT_SHIFT]
})

# Keybindings for Firefox/Chrome
#define_keymap(re.compile("Firefox|Google-chrome"), {
#    # Ctrl+Alt+j/k to switch next/previous tab
#    K("C-M-j"): K("C-TAB"),
#    K("C-M-k"): K("C-Shift-TAB"),
#    # Type C-j to focus to the content
#    K("C-j"): K("C-f6"),
#    # very naive "Edit in editor" feature (just an example)
#    K("C-o"): [K("C-a"), K("C-c"), launch(["gedit"]), sleep(0.5), K("C-v")]
#}, "Firefox and Chrome")

# Keybindings for Zeal https://github.com/zealdocs/zeal/
#define_keymap(re.compile("Zeal"), {
#    # Ctrl+s to focus search area
#    K("C-s"): K("C-k"),
#}, "Zeal")

def get_search_key():
    return K("Shift-TAB") if get_active_window_wm_class() == "Xfce4-clipman-history" else K("F3")

# Emacs keybindings for global environment
global_exclusive_apps = ["Emacs", "qterminal", "Vivaldi-stable", "Nyxt", "URxvt"]
define_keymap(lambda wm_class: wm_class not in global_exclusive_apps, {
    # Cursor
    K("C-b"): with_mark(K("left")),
    K("C-f"): with_mark(K("right")),
    K("C-p"): with_mark(K("up")),
    K("C-n"): with_mark(K("down")),
    K("C-h"): with_mark(K("backspace")),

    # Beginning/End of line
    K("C-a"): with_mark(K("home")),
    K("C-e"): with_mark(K("end")),

    # Beginning/End of file
    K("M-Shift-comma"): with_mark(K("C-home")),
    K("M-Shift-dot"): with_mark(K("C-end")),

    # Newline
    K("C-m"): K("enter"),
    K("C-o"): [K("enter"), K("left")],

    # Copy
    K("C-w"): [K("C-x"), set_mark(False)],
    K("M-w"): [K("C-c"), set_mark(False)],
    K("C-y"): [K("C-v"), set_mark(False)],
    
    # Delete
    K("C-d"): [K("delete"), set_mark(False)],
    
    # Kill line
    K("C-k"): [K("Shift-end"), K("C-x"), K("delete"), set_mark(False)],
    K("C-u"): [K("Shift-home"), K("C-x"), K("delete"), K("end"), set_mark(False)],

    # Undo
    K("C-slash"): [K("C-z"), set_mark(False)],
    K("C-M-slash"): [K("C-Shift-z"), set_mark(False)],

    # Mark
    K("C-space"): set_mark(True),
    #K("C-M-space"): with_or_set_mark(K("C-right")),

    # Region
    K("C-Shift-p"): K("Shift-up"),
    K("C-Shift-n"): K("Shift-down"),
    K("C-Shift-f"): K("Shift-right"),
    K("C-Shift-b"): K("Shift-left"),
    K("C-Shift-a"): K("Shift-home"),
    K("C-Shift-e"): K("Shift-end"),
    
    # Search
    K("C-s"): get_search_key,
    K("C-r"): K("Shift-F3"),
    
    # Cancel
    K("C-g"): [K("esc"), set_mark(False)],

    # Tab
    K("C-i"): K("TAB"),
    K("C-Shift-i"): K("Shift-TAB"),
    K("C-M-i"): K("Shift-TAB"),
    
    # C-x YYY
    K("C-x"): {
        # C-x h (select all)
        K("h"): [K("C-home"), K("C-a"), set_mark(True)],
        # C-x C-f (open)
        K("C-f"): K("C-o"),
        # C-x C-s (save)
        K("C-s"): K("C-s"),
        # C-x k (kill tab)
        K("k"): K("C-f4"),
        # C-x C-c (exit)
        K("C-c"): K("C-q"),
        # cancel
        K("C-g"): pass_through_key,
        # C-x u (undo)
        K("u"): [K("C-z"), set_mark(False)],
    }
}, "Emacs keybindings for global environment")

# Custom keybindings for qterminal
define_keymap(re.compile("qterminal"), {

    # Cursor
    K("C-p"): K("up"),
    K("C-n"): K("down"),

    # Newline
    K("C-m"): K("enter"),

    # Cancel
    K("C-g"): K("esc"),

}, "Custom keybindings for qterminal")

# Custom keybindings for Emacs
define_keymap(re.compile("Emacs"), {

    # Cursor
    K("C-p"): K("up"),
    K("C-n"): K("down"),

    # Newline
    K("C-m"): K("enter"),

}, "Custom keybindings for Emacs")

# Emacs keybindings for Vivaldi
define_keymap(re.compile("Vivaldi-stable"), {

    # Cursor
    K("C-b"): with_mark(K("left")),
    K("C-f"): with_mark(K("right")),
    K("C-p"): with_mark(K("up")),
    K("C-n"): with_mark(K("down")),
    K("C-h"): with_mark(K("backspace")),

    # Beginning/End of line
    K("C-a"): with_mark(K("home")),
    K("C-e"): with_mark(K("end")),

    # Newline
    K("C-m"): K("enter"),

    # Copy
    K("C-w"): [K("C-x"), set_mark(False)],
    K("M-w"): [K("C-c"), set_mark(False)],
    K("C-y"): [K("C-v"), set_mark(False)],
    
    # Delete
    K("C-d"): [K("delete"), set_mark(False)],
    
    # Kill line
    K("C-k"): [K("Shift-end"), K("C-x"), set_mark(False)],
    K("C-u"): [K("Shift-home"), K("C-x"), set_mark(False)],

    # Undo
    K("C-slash"): [K("C-z"), set_mark(False)],
    K("C-M-slash"): [K("C-Shift-z"), set_mark(False)],

    # Mark
    K("C-space"): set_mark(True),

    # Region
    K("C-Shift-p"): K("Shift-up"),
    K("C-Shift-n"): K("Shift-down"),
    K("C-Shift-f"): K("Shift-right"),
    K("C-Shift-b"): K("Shift-left"),
    K("C-Shift-a"): K("Shift-home"),
    K("C-Shift-e"): K("Shift-end"),
    
    # Cancel
    K("C-g"): [K("esc"), set_mark(False)],

    # Tab
    K("C-i"): K("TAB"),
    K("C-Shift-i"): K("Shift-TAB"),
    K("C-M-i"): K("Shift-TAB"),

    # C-x YYY
    K("C-x"): {
        # C-x h (select all)
        K("h"): [K("C-home"), K("C-a"), set_mark(True)],
        # C-x C-f (open)
        K("C-f"): K("C-o"),
        # C-x C-s (save)
        K("C-s"): K("C-s"),
        # C-x k (kill tab)
        K("k"): K("C-f4"),
        # C-x C-c (exit)
        K("C-c"): K("C-q"),
        # cancel
        K("C-g"): pass_through_key,
        # C-x u (undo)
        K("u"): [K("C-z"), set_mark(False)],
    }
}, "Emacs keybindings for Vivaldi")

# Custom keybindings for Nyxt
define_keymap(re.compile("Nyxt"), {

    # Cursor
    K("C-n"): K("down"),
    K("C-p"): K("up"),
    K("C-f"): K("right"),
    K("C-b"): K("left"),
    
    # Beginning/End of line
    K("C-a"): K("C-home"),
    K("C-e"): K("C-end"),
    
    # Newline
    K("C-m"): K("enter"),

    # Cancel
    K("C-g"): K("esc"),

    # Backspace/Delete
    K("C-h"): K("backspace"),
    K("C-d"): K("delete"),

    # Tab
    K("C-i"): K("TAB"),
#    K("C-Shift-i"): K("Shift-TAB"),
    K("C-M-i"): K("Shift-TAB"),
    
}, "Custom keybindings for Nyxt")
