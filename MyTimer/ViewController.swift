//
//  ViewController.swift
//  MyTimer
//
//  Created by takashimakenichi on 2020/12/28.
//  Copyright © 2020 takashimakenichi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    // タイマー用の変数
    var timer: Timer?
    // カウント（経過時間）
    var count = 0
    // 設定値を扱うキー
    let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // UserDefaultsのインスタンス生成
        let settings = UserDefaults.standard
        // 初期値を登録
        settings.register(defaults: [settingKey: 10])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // カウントを0に戻す
        count = 0
        // タイマー表示を更新
        // 戻り値は利用しないため、_ に代入する形
        _ = displayUpdate()
    }

    // settingViewControllerへ遷移
    @IBAction func settingButtonAction(_ sender: Any) {
        // タイマー実行中であれば停止
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
        
        // segueIDを使用して画面遷移
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        // timerをアンラップしてnowTimerに代入
        if let nowTimer = timer {
            // タイマーが実行中であれば何もしない
            if nowTimer.isValid == true {
                return
            }
        }
        // タイマースタート
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerInterrupt(_:)), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        if let nowTimer = timer {
            // タイマー実行中であれば、停止する
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
    }
    
    // 経過時間の処理
    @objc func timerInterrupt(_ timer: Timer) {
        count += 1
        
        // remainCountが0以下の時にタイマーを止める
        if displayUpdate() <= 0 {
            // 初期化
            count = 0
            // タイマー停止
            timer.invalidate()
            
            /* 終了時にダイアログ表示 */
            // ダイアログ作成
            let alertController = UIAlertController(title: "終了", message: "タイマー終了時間です", preferredStyle: .alert)
            // ダイアログ表示のOKボタン
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            // アクションを追加
            alertController.addAction(defaultAction)
            // ダイアログ表示
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    // 画面を更新する（戻り値：remainCount/残り時間）
    func displayUpdate() -> Int {
        let settings = UserDefaults.standard
        // userDefautから値取得
        let timerValue = settings.integer(forKey: settingKey)
        // 残り時間を生成
        let remainCount = timerValue - count
        
        countDownLabel.text = "残り\(remainCount)秒"
        return remainCount
    }
    
}

