# 33sqip_tool

YAML形式の仕様書から、以下の形式を出力する。
* 画面一覧
* 画面遷移一覧

## 実行例

### 仕様書

    $ cat spec.yaml
    - screen:
        name: "ユーザー・ログイン画面"
        img: null
        ui_parts:
          - name:       "IDフィールド"
            trigger:    null
            action:     "フィールドを入力不可にする"
            next:       null
            condition:  "「ログインエラー数」が5以上のとき"
            validation: |-
              最大文字数32
              初期値：空欄
            error_handling: null
          - name:       "Passwordフィールド"
            trigger:    "画面表示時"
            action:     "フィールドを入力不可にする"
            next:       null
            condition:  "「ログインエラー数」が5以上のとき"
            validation: |-
              最大文字数32
              初期値：空欄
            error_handling: null
          - name:         "ログインボタン"
            trigger:      "押下時"
            actions:
              - action:     "IDフィールドの内容を「ユーザID」に保存する。"
                next:       null
                condition:  "入力値が入力制限に抵触しない"
                validation: null
                error_handling: |-
                  「ログインエラー数」に+1してユーザー・ログイン画面を再表示する
                  共通エラー処理
              - action:     "Passwordフィールドの内容を「Password」に保存する。"
                next:       null
                condition:  "入力値が入力制限に抵触しない"
                validation: null
                error_handling: |-
                  「ログインエラー数」に+1してユーザー・ログイン画面を再表示する
                  共通エラー処理
              - action:     "「タスク情報全受信(ユーザID, Password)」 を実行する"
                next:       null
                condition:  null
                validation: null
                error_handling: |-
                  「ログインエラー数」に+1してユーザー・ログイン画面を再表示する
                  共通エラー処理
              - action:     "タスク一覧画面に遷移する"
                next:       "タスク一覧画面"
                conditions:
                  - condition:  "ID,Passwordが登録されたユーザーと一致する"
                    validation: null
                    error_handling: |-
                      「ログインエラー数」に+1してユーザー・ログイン画面を再表示する
                      共通エラー処理
                  - condition:  "すでにログインしている同一IDユーザーがいない"
                    validation: null
                    error_handling: |-
                      共通エラー処理

    - screen:
        name: "タスク一覧画面"
        ui_parts:
          - name:    "ボタン"
            trigger: "押下時"
            action:  "メンテナンス作業画面に遷移する"
            next:    "メンテナンス作業画面"

    - screen:
        name: "メンテナンス作業画面"
        ui_parts:
          - name:    "ボタン"
            trigger: "押下時"
            action:  "タスク情報画面に遷移する"
            next:    "タスク情報画面"

    - screen:
        name: "タスク情報画面"
        ui_parts:
          - name:    "ボタン"
            trigger: "押下時"
            action:  "メンテナンス作業画面に遷移する"
            next:    "メンテナンス作業画面"

### 画面一覧

    $ ruby screen_name_list.rb spec.yaml
    ユーザー・ログイン画面
    タスク一覧画面
    メンテナンス作業画面
    タスク情報画面

### 画面遷移一覧

    $ ruby screen_transition_list.rb spec.yaml
    タスク一覧画面 => メンテナンス作業画面
    メンテナンス作業画面 => タスク情報画面
    タスク情報画面 => メンテナンス作業画面
