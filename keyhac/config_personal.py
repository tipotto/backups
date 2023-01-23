# -*- mode: python; coding: utf-8-with-signature-dos -*-

# https://stackoverflow.com/questions/2904274/globals-and-locals-in-python-exec
# https://docs.python.org/3/library/functions.html?highlight=exec%20global#exec

# 本ファイルは、config_personal.py というファイル名にすることで個人設定ファイルとして機能します。
# 本ファイルの設定には [] で括られたセクション名が定義されており、その単位で config.py の中に設定
# が取り込まれ、exec関数により実行されます。config.py ファイル内の exec関数をコールしているところ
# を検索すると、何のセクションがどこで読み込まれるかが分かると思います。

# 本ファイルはサンプルファイルです。本ファイルに記載のない設定でも、config.py から設定を取り込み、
# カスタマイズしてご利用ください。

####################################################################################################
## 初期設定
####################################################################################################
# [section-init] -----------------------------------------------------------------------------------

print(startupString())

keymap.editor = r"notepad.exe"
keymap.setFont("ＭＳ ゴシック", 12)

####################################################################################################
## 機能オプションの選択
####################################################################################################
# [section-options] --------------------------------------------------------------------------------

# IMEの設定（次の設定のいずれかを有効にする）
fc.ime = "old_Microsoft_IME"
# fc.ime = "new_Microsoft_IME"
# fc.ime = "Google_IME"
# fc.ime = None

####################################################################################################
## 基本設定
####################################################################################################
# [section-base-1] ---------------------------------------------------------------------------------

# Emacs のキーバインドに“したくない”アプリケーションソフトを指定する
# （Keyhac のメニューから「内部ログ」を ON にすると processname や classname を確認することができます）
fc.not_emacs_target     = ["wsl.exe",                # WSL
                           "bash.exe",               # WSL
                           "ubuntu.exe",             # WSL
                           "ubuntu1604.exe",         # WSL
                           "ubuntu1804.exe",         # WSL
                           "ubuntu2004.exe",         # WSL
                           "debian.exe",             # WSL
                           "kali.exe",               # WSL
                           "SLES-12.exe",            # WSL
                           "openSUSE-42.exe",        # WSL
                           "openSUSE-Leap-15-1.exe", # WSL
                           "mstsc.exe",              # Remote Desktop
                           "WindowsTerminal.exe",    # Windows Terminal
                           "mintty.exe",             # mintty
                           "Cmder.exe",              # Cmder
                           "ConEmu.exe",             # ConEmu
                           "ConEmu64.exe",           # ConEmu
                           "emacs.exe",              # Emacs
                           "emacs-X11.exe",          # Emacs
                           "emacs-w32.exe",          # Emacs
                           "gvim.exe",               # GVim
                           "xyzzy.exe",              # xyzzy
                           "VirtualBox.exe",         # VirtualBox
                           "msrdc.exe",              # WSLg
                           "XWin.exe",               # Cygwin/X
                           "XWin_MobaX.exe",         # MobaXterm/X
                           "XWin_MobaX_1.16.3.exe",  # MobaXterm/X
                           "XWin_Cygwin_1.14.5.exe", # MobaXterm/X
                           "XWin_Cygwin_1.16.3.exe", # MobaXterm/X
                           "Xming.exe",              # Xming
                           "vcxsrv.exe",             # VcXsrv
                           "GWSL_vcxsrv.exe",        # GWSL
                           "GWSL_vcxsrv_lowdpi.exe", # GWSL
                           "X410.exe",               # X410
                           "Xpra-Launcher.exe",      # Xpra
                           "putty.exe",              # PuTTY
                           "ttermpro.exe",           # TeraTerm
                           "MobaXterm.exe",          # MobaXterm
                           "TurboVNC.exe",           # TurboVNC
                           "vncviewer.exe",          # UltraVNC
                           "vncviewer64.exe",        # UltraVNC
                           "Code.exe",               # VSCode
                           ]                               

# IME の切り替え“のみをしたい”アプリケーションソフトを指定する
# （指定できるアプリケーションソフトは、not_emacs_target で（除外）指定したものからのみとなります）
fc.ime_target          += []

# キーマップ毎にキー設定をスキップするキーを指定する
# （リストに指定するキーは、define_key の第二引数に指定する記法のキーとしてください。"A-v" や "C-v"
#   のような指定の他に、"M-f" や "Ctl-x d" などの指定も可能です。"M-g*" のようにワイルドカードも
#   利用することができます。）
# （ここで指定したキーに新たに別のキー設定をしたいときには、「-2」が付くセクション内で define_key2
#   関数を利用して定義してください）
fc.skip_settings_key    = {"keymap_global"    : [], # 全画面共通 Keymap
                           "keymap_emacs"     : [], # Emacs キーバインド対象アプリ用 Keymap
                           "keymap_ime"       : [], # IME 切り替え専用アプリ用 Keymap
                           "keymap_ei"        : [], # Emacs 日本語入力モード用 Keymap
                           "keymap_tsw"       : [], # タスク切り替え画面用 Keymap
                           "keymap_lw"        : [], # リストウィンドウ用 Keymap
                          }

# Emacs のキーバインドにするアプリケーションソフトで、Emacs キーバインドから除外するキーを指定する
# （リストに指定するキーは、Keyhac で指定可能なマルチストロークではないキーとしてください。
#   Fakeymacs の記法の "M-f" や "Ctl-x d" などの指定はできません。"A-v"、"C-v" などが指定可能です。）
fc.emacs_exclusion_key  = {"vivaldi.exe"      : ["C-l", "C-s", "C-r"],
                           "chrome.exe"       : ["C-l", "C-t"],
                           "msedge.exe"       : ["C-l", "C-t"],
                           "firefox.exe"      : ["C-l", "C-t"],
                           "Code.exe"         : ["C-S-b", "C-S-f", "C-S-p", "C-S-n", "C-S-a", "C-S-e"],
                          }

# 左右どちらの Ctrlキーを使うかを指定する（"L": 左、"R": 右）
# fc.side_of_ctrl_key = "L"

# Escキーを Metaキーとして使うかどうかを指定する（True: 使う、False: 使わない）
# （True（Metaキーとして使う）に設定されている場合、ESC の二回押下で ESC が入力されます）
#fc.use_esc_as_meta = True

# Emacs日本語入力モードを使うかどうかを指定する（True: 使う、False: 使わない）
fc.use_emacs_ime_mode = True

# Emacs日本語入力モードが有効なときに表示するバルーンメッセージを指定する
# fc.emacs_ime_mode_balloon_message = None
fc.emacs_ime_mode_balloon_message = "▲"

# IME の状態を表示するバルーンメッセージを表示するかどうかを指定する（True: 表示する、False: 表示しない）
fc.use_ime_status_balloon = True

# IME をトグルで切り替えるキーを指定する（複数指定可）
fc.toggle_input_method_key = []
#fc.toggle_input_method_key += ["C-Yen"]
#fc.toggle_input_method_key += ["C-o"]
# fc.toggle_input_method_key += ["O-LAlt"]

#---------------------------------------------------------------------------------------------------
# IME を切り替えるキーの組み合わせ（disable、enable の順）を指定する（複数指定可）
# （toggle_input_method_key のキー設定より優先します）
fc.set_input_method_key = []

## 日本語キーボードを利用している場合、<無変換> キーで英数入力、<変換> キーで日本語入力となる
fc.set_input_method_key += [["(29)", "(28)"]]

## 日本語キーボードを利用している場合、<Ａ> キーで英数入力、<あ> キーで日本語入力となる
## （https://docs.microsoft.com/ja-jp/windows-hardware/design/component-guidelines/keyboard-japan-ime）
# fc.set_input_method_key += [["(26)", "(22)"]]

## LAlt の単押しで英数入力、RAlt の単押しで日本語入力となる
## （JetBrains 製の IDE でこの設定を利用するためには、ツールボタンをオンにする必要があるようです。
##   設定は、View -> Appearance -> Tool Window Bars を有効にしてください。）
# fc.set_input_method_key += [["O-LAlt", "O-RAlt"]]

## C-j や C-j C-j で 英数入力となる（toggle_input_method_key の設定と併せ、C-j C-o で日本語入力となる）
# fc.set_input_method_key += [["C-j", None]]

## C-j で英数入力、C-o で日本語入力となる（toggle_input_method_key の設定より優先）
# fc.set_input_method_key += [["C-j", "C-o"]]

## C-j で英数入力、C-i で日本語入力となる（C-i が Tab として利用できなくなるが、トグルキー C-o との併用可）
# fc.set_input_method_key += [["C-j", "C-i"]]
#---------------------------------------------------------------------------------------------------

# アプリケーションキーとして利用するキーを指定する
# （修飾キーに Alt は使えないようです）
# fc.application_key = "O-RCtrl"
# fc.application_key = "W-m"

# 数引数の指定に Ctrl+数字キーを使うかを指定する（True: 使う、False: 使わない）
# （False に指定しても、C-u 数字キーで数引数を指定することができます）
# fc.use_ctrl_digit_key_for_digit_argument = True

# アクティブウィンドウを切り替えるキーの組み合わせ（前、後 の順）を指定する（複数指定可）
fc.window_switching_key += [["C-S-RAlt-Tab", "C-RAlt-Tab"]]

# ウィンドウを最小化、リストアするキーの組み合わせ（リストア、最小化 の順）を指定する（複数指定可）
fc.window_minimize_key += [["C-RAlt-m", "RAlt-m"]]

# クリップボードリストを起動するキーを指定する
fc.clipboardList_key = "LAlt-y"

# ランチャーリストを起動するキーを指定する
fc.lancherList_key = "LAlt-l"

# [section-base-2] ---------------------------------------------------------------------------------
import pyauto

def kill_various_buffer():
    if checkWindow("chrome.exe", "Chrome_WidgetWin_1") or checkWindow("vivaldi.exe", "Chrome_WidgetWin_1"):
        self_insert_command("C-w")()
    else:
        self_insert_command("A-F4")()

def maximize_window():
    wnd = keymap.getTopLevelWindow()
    if wnd and not wnd.isMaximized():
        wnd.maximize()

def reverse_indent_for_tab_command():
    self_insert_command("S-Tab")()

def kill_next_line(repeat=1):
    resetRegion()
    fakeymacs.is_marked = True

    if repeat == 1:
        mark(move_end_of_line, True)()
        delay()

        if (checkWindow("cmd.exe", "ConsoleWindowClass") or       # Cmd
            checkWindow("powershell.exe", "ConsoleWindowClass")): # PowerShell
            kill_region()

        elif checkWindow(None, "HM32CLIENT"): # Hidemaru Software
            kill_region()
            delay()
            if getClipboardText() == "":
                self_insert_command("Delete")()
        else:
            kill_region()
            self_insert_command("Delete")()

    else:
        def move_end_of_region():
            if checkWindow("WINWORD.EXE", "_WwG"): # Microsoft Word
                for i in range(repeat):
                    next_line()
                move_beginning_of_line()
            else:
                for i in range(repeat - 1):
                    next_line()
                move_end_of_line()
                forward_char()

        mark(move_end_of_region, True)()
        delay()
        kill_region()

def kill_previous_line(repeat=1):
    resetRegion()
    fakeymacs.is_marked = True

    if repeat == 1:
        mark(move_beginning_of_line, True)()
        delay()

        if (checkWindow("cmd.exe", "ConsoleWindowClass") or       # Cmd
            checkWindow("powershell.exe", "ConsoleWindowClass")): # PowerShell
            kill_region()

        elif checkWindow(None, "HM32CLIENT"): # Hidemaru Software
            kill_region()
            delay()
            if getClipboardText() == "":
                self_insert_command("Delete")()
        else:
            kill_region()
            self_insert_command("Delete")()
            move_end_of_line()
    else:
        def move_end_of_region():
            #if checkWindow("WINWORD.EXE", "_WwG"): # Microsoft Word
            #    for i in range(repeat):
            #        next_line()
            #    move_beginning_of_line()
            #else:
            #    for i in range(repeat - 1):
            #        next_line()
            #    move_end_of_line()
            #    forward_char()

            for i in range(repeat - 1):
                next_line()
            move_beginning_of_line()
            forward_char()

        mark(move_end_of_region, True)()
        delay()
        kill_region()

def snap_window_in_half(position):
    main_monitor_info = (pyauto.Window.getMonitorInfo())[0]
    non_taskbar_area = main_monitor_info[1]
    [monitor_left, monitor_top, monitor_right, monitor_bottom] = non_taskbar_area
    monitor_width = monitor_right - monitor_left
    ratio = 2
    wnd_width = int(monitor_width / ratio)
    wnd_pos_table = {
        "left": {
            "left": monitor_left - 10,
            "right": wnd_width + 10,
        },
        "right": {
            "left": wnd_width - 10,
            "right": monitor_right + 10,
        },
    }

    wnd_area = wnd_pos_table[position]
    rect = [wnd_area["left"], monitor_top, wnd_area["right"], monitor_bottom]
    wnd = keymap.getTopLevelWindow()

    if list(wnd.getRect()) == rect:
        wnd.maximize()
    else:
        if wnd.isMaximized():
            wnd.restore()
        wnd.setRect(rect)

for k in [
    ("LAlt-RAlt-1", lambda: snap_window_in_half("left")),
    ("LAlt-RAlt-2", lambda: snap_window_in_half("right")),
]:
  define_key(keymap_global, k[0], k[1])

define_key(keymap_emacs, "LAlt-g", reset_search(reset_undo(reset_counter(reset_mark(goto_line)))))
define_key(keymap_emacs, "S-LAlt-Comma", reset_search(reset_undo(reset_counter(mark(beginning_of_buffer, False)))))
define_key(keymap_emacs, "S-LAlt-Period", reset_search(reset_undo(reset_counter(mark(end_of_buffer, True)))))
define_key(keymap_emacs, "C-k", reset_search(reset_undo(reset_counter(reset_mark(repeat3(kill_next_line))))))
define_key(keymap_emacs, "C-u", reset_search(reset_undo(reset_counter(reset_mark(repeat3(kill_previous_line))))))
define_key(keymap_emacs, "LAlt-w", reset_search(reset_undo(reset_counter(reset_mark(kill_ring_save)))))
define_key(keymap_emacs, "C-S-i", reset_undo(reset_counter(reset_mark(repeat(reverse_indent_for_tab_command)))))
define_key(keymap_global, "RAlt-w", reset_search(reset_undo(reset_counter(reset_mark(kill_various_buffer)))))
define_key(keymap_global, "S-RAlt-m", maximize_window)

####################################################################################################
## クリップボードリストの設定
####################################################################################################
# [section-clipboardList-1] ------------------------------------------------------------------------

# 定型文
fc.fixed_items = [
    ["---------+ x 8", "---------+" * 8],
    ["メールアドレス", "user_name@domain_name"],
    ["住所",           "〒999-9999 ＮＮＮＮＮＮＮＮＮＮ"],
    ["電話番号",       "99-999-9999"],
]
fc.fixed_items[0][0] = list_formatter.format(fc.fixed_items[0][0])

# 日時
fc.datetime_items = [
    ["YYYY/MM/DD HH:MM:SS", dateAndTime("%Y/%m/%d %H:%M:%S")],
    ["YYYY/MM/DD",          dateAndTime("%Y/%m/%d")],
    ["HH:MM:SS",            dateAndTime("%H:%M:%S")],
    ["YYYYMMDD_HHMMSS",     dateAndTime("%Y%m%d_%H%M%S")],
    ["YYYYMMDD",            dateAndTime("%Y%m%d")],
    ["HHMMSS",              dateAndTime("%H%M%S")],
]
fc.datetime_items[0][0] = list_formatter.format(fc.datetime_items[0][0])

fc.clipboardList_listers = [
    ["定型文", cblister_FixedPhrase(fc.fixed_items)],
    ["日時",   cblister_FixedPhrase(fc.datetime_items)],
]

# [section-clipboardList-2] ------------------------------------------------------------------------

####################################################################################################
## ランチャーリストの設定
####################################################################################################
# [section-lancherList-1] --------------------------------------------------------------------------

# アプリケーションソフト
fc.application_items = [
    ["Notepad",     keymap.ShellExecuteCommand(None, r"notepad.exe", "", "")],
    ["Explorer",    keymap.ShellExecuteCommand(None, r"explorer.exe", "", "")],
    ["Cmd",         keymap.ShellExecuteCommand(None, r"cmd.exe", "", "")],
    ["MSEdge",      keymap.ShellExecuteCommand(None, r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe", "", "")],
    ["Chrome",      keymap.ShellExecuteCommand(None, r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe", "", "")],
    ["Firefox",     keymap.ShellExecuteCommand(None, r"C:\Program Files (x86)\Mozilla Firefox\firefox.exe", "", "")],
    ["Thunderbird", keymap.ShellExecuteCommand(None, r"C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe", "", "")],
]
fc.application_items[0][0] = list_formatter.format(fc.application_items[0][0])

# ウェブサイト
fc.website_items = [
    ["Google",          keymap.ShellExecuteCommand(None, r"https://www.google.co.jp/", "", "")],
    ["Facebook",        keymap.ShellExecuteCommand(None, r"https://www.facebook.com/", "", "")],
    ["Twitter",         keymap.ShellExecuteCommand(None, r"https://twitter.com/", "", "")],
    ["Keyhac",          keymap.ShellExecuteCommand(None, r"https://sites.google.com/site/craftware/keyhac-ja", "", "")],
    ["Fakeymacs",       keymap.ShellExecuteCommand(None, r"https://github.com/smzht/fakeymacs", "", "")],
    ["NTEmacs＠ウィキ", keymap.ShellExecuteCommand(None, r"https://w.atwiki.jp/ntemacs/", "", "")],
]
fc.website_items[0][0] = list_formatter.format(fc.website_items[0][0])

# その他
fc.other_items = [
    ["Edit   config.py", keymap.command_EditConfig],
    ["Reload config.py", keymap.command_ReloadConfig],
]
fc.other_items[0][0] = list_formatter.format(fc.other_items[0][0])

fc.lancherList_listers = [
    ["App",     cblister_FixedPhrase(fc.application_items)],
    ["Website", cblister_FixedPhrase(fc.website_items)],
    ["Other",   cblister_FixedPhrase(fc.other_items)],
]

# [section-lancherList-2] --------------------------------------------------------------------------

####################################################################################################
## 拡張機能の設定
####################################################################################################
# [section-extensions] -----------------------------------------------------------------------------

# https://github.com/smzht/fakeymacs/blob/master/fakeymacs_manuals/extensions.org

# --------------------------------------------------------------------------------------------------

# VSCode 用のキーの設定を行う
if 1:
    fc.vscode_target  = ["Code.exe"]
    fc.vscode_target += ["chrome.exe",
                         "msedge.exe",
                         "firefox.exe"
                        ]
    # fc.vscode_prefix_key = [["C-;", "C-A-;"]]
    fc.use_ctrl_atmark_for_mark = False
    fc.use_direct_input_in_vscode_terminal = False
    fc.esc_mode_in_keyboard_quit = 1

    # VSCode Extension 用のキーの設定を行う
    fc.vscode_dired = False
    fc.vscode_recenter = False
    fc.vscode_occur = False
    fc.vscode_quick_select = True
    fc.vscode_input_sequence = True
    fc.vscode_insert_numbers = True

    exec(readConfigExtension(r"vscode_key\config.py"), dict(globals(), **locals()))
    # vscode_extensions\config.py は、vscode_key\config.py 内部から呼ばれている

# --------------------------------------------------------------------------------------------------

# Everything を起動するキーを指定する
if 0:
    exec(readConfigExtension(r"everything\config.py"), dict(globals(), **locals()))

# --------------------------------------------------------------------------------------------------

# ブラウザ向けのキーの設定を行う
if 0:
    exec(readConfigExtension(r"browser_key\config.py"), dict(globals(), **locals()))

# --------------------------------------------------------------------------------------------------

# Chrome 系ブラウザで Ctl-x C-b を入力した際、Chrome の拡張機能 Quick Tabs を起動する
# （github1s を利用する場合、本機能を有効にせずに Quick Tabs を利用すればキー被りが発生しません）
if 0:
    fc.quick_tabs_shortcut_key = "A-q"
    exec(readConfigExtension(r"chrome_quick_tabs\config.py"), dict(globals(), **locals()))

# --------------------------------------------------------------------------------------------------

# Emacs の shell-command-on-region の機能をサポートする
if 0:
    fc.linux_tool = "WSL"
    # fc.linux_tool = "MSYS2"
    # fc.linux_tool = "Cygwin"
    # fc.linux_tool = "BusyBox"
    # fc.bash_options = []
    fc.bash_options = ["-l"]
    exec(readConfigExtension(r"shell_command_on_region\config.py"), dict(globals(), **locals()))

# --------------------------------------------------------------------------------------------------

# 指定したアプリケーションソフトに F2（編集モード移行）を割り当てるキーを設定する
if 0:
    exec(readConfigExtension(r"edit_mode\config.py"), dict(globals(), **locals()))

# --------------------------------------------------------------------------------------------------

# Emacs の場合、IME 切り替え用のキーを C-\ に置き換える
if 0:
    exec(readConfigExtension(r"real_emacs\config.py"), dict(globals(), **locals()))

# --------------------------------------------------------------------------------------------------

# 英語キーボード設定をした OS 上で日本語キーボードを利用する場合の設定を行う
if 0:
    fc.change_keyboard_startup = "US"
    # fc.change_keyboard_startup = "JP"
    exec(readConfigExtension(r"change_keyboard\config.py"), dict(globals(), **locals()))

# --------------------------------------------------------------------------------------------------

# クリップボードに格納したファイルもしくはフォルダのパスを emacsclient で開く
if 0:
    fc.emacsclient_name = r"<emacsclient プログラムをインストールしている Windows のパス>\wslclient-n.exe"
    exec(readConfigExtension(r"emacsclient\config.py"), dict(globals(), **locals()))

# --------------------------------------------------------------------------------------------------

# 指定したキーを押下したときに IME の状態を表示する
if 0:
    fc.pop_ime_balloon_key = ["C-Semicolon"]
    # fc.pop_ime_balloon_key = ["O-" + fc.side_of_ctrl_key + "Ctrl"] # Ctrl キーの単押し
    exec(readConfigExtension(r"pop_ime_balloon\config.py"), dict(globals(), **locals()))

# --------------------------------------------------------------------------------------------------

# 60% US キーボードのキー不足（Delete キー、Backquote キー不足）の対策を行う
if 0:
    exec(readConfigExtension(r"compact_keyboard\config.py"), dict(globals(), **locals()))

# --------------------------------------------------------------------------------------------------
