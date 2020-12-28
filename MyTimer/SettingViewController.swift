//
//  SettingViewController.swift
//  MyTimer
//
//  Created by takashimakenichi on 2020/12/28.
//  Copyright © 2020 takashimakenichi. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var timerSettingPicker: UIPickerView!
    
    // pickerViewに表示するデータの配列
    let settingArray: [Int] = [10, 20, 30, 40, 50, 60]
    // 設定値のキー
    let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // デリゲートとデータソースの通知先指定
        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
        // UserDefaultsの取得
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        
        // pickerの選択を合わせる
        for row in 0 ..< settingArray.count {
            if settingArray[row] == timerValue {
                timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func decisionButtonAction(_ sender: Any) {
        // 前画面に戻る
        // naviagationControllerに値が入っている場合のみ、popViewControllerを実行
        _ = navigationController?.popViewController(animated: true)
    }
    
    // UIPickerViewDataSource関連 : データのやり取りのための定義
    // pickerViewの列数を指定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // pickerViewの行数を指定
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingArray.count
    }
    
    // UIPickerViewDelegate関連 : イベント通知
    // pickerの表示内容の設定
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(settingArray[row])
//        return "\(row)"
    }
    
    // picker選択時に呼ばれる
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // UserDefaultsの設定
        let settings = UserDefaults.standard
        // 第一引数の値に上書き
        settings.setValue(settingArray[row], forKey: settingKey)
        // データを即時に永続化
        settings.synchronize()
    }
}
