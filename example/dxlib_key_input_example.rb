$LOAD_PATH.unshift(File.expand_path('./'))

require 'dxlib_const_variables'
require 'dxlib'
require 'fiddle'

include DxLib
     
    input_handle = 0
    # バッファの準備 (変更可能なメモリ領域を確保)
    string_buffer_size = 256  # バッファサイズ
    string = Fiddle::Pointer.malloc(string_buffer_size)
    set_use_char_code_format(DX_CHARCODEFORMAT_UTF8)
    set_main_window_text("")
    change_window_mode(TRUE)
    set_wait_vsync_flag(FALSE)
    # DxLibの初期化
    return if dxlib_init == -1

    # 描画先を裏にする
    set_draw_screen(DX_SCREEN_BACK)

    # キー入力ハンドルを作る(キャンセルなし全角文字有り数値入力じゃなし)
    input_handle = make_key_input(50,FALSE,FALSE,FALSE)
    # 作成したキー入力ハンドルをアクティブにする
    set_active_key_input(input_handle)
    # キー入力終了待ちループ
    # (ProcessMessageをループごとに行う)
    while process_message() == TRUE do
        # 入力が終了している場合は終了
        #break if check_key_input(input_handle) != 0

        #break if check_hit_key(KEY_INPUT_1) == TRUE
        # 画面の初期化
        cls_draw_screen()
        # 入力モードを描画
        draw_key_input_mode_string(640,480)
        # 入力途中の文字列を描画
        draw_key_input_string(0,0,input_handle)
        # 裏画面の内容を表画面に反映させる
        screen_flip() 
    end

    # 入力された文字列を取得
    get_key_input_string(string,input_handle)
    # 用済みのインプットハンドルを削除する
    delete_key_input(input_handle)
    # 画面の初期化
    cls_draw_screen()
    # 入力された文字列を画面に表示する
    draw_string(0,0,"あなたが入力した文字列は",get_color(255,255,255))
    draw_string(0,16,string.to_s(string_buffer_size),get_color(255,255,255))
    # 裏画面の内容を表画面に反映させる
    screen_flip()
    # キー入力待ち
    wait_key()
    # ＤＸライブラリの使用終了
    dxlib_end()
    # 終了
    return
