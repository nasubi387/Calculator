//
//  CalculatorViewController.swift
//  CalculatorSmaple
//
//  Created by Ishida Naoya on 2020/06/05.
//  Copyright © 2020 G.F.C. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    // MARK:- property
    
    /// ボタンの順番
    private let buttonOrder: [CalculatorInputType] = [
        .clear, .plusMinus, .parcentage, .operation(.division),
        .number(7), .number(8), .number(9), .operation(.multiply),
        .number(4), .number(5), .number(6), .operation(.minus),
        .number(1), .number(2), .number(3), .operation(.plus),
        .number(0), .dot, .equal
    ]
    
    /// 計算管理
    private let calculatorManager = CalculatorManager()
    
    // MARK:- IBOutlet
    
    /// ボタンの配列。左上から右方向に順に紐付ける。
    @IBOutlet var CalculatorButtons: [CalculatorButton]!
    /// 結果表示用ラベル
    @IBOutlet weak var resultLabel: ResultLabel!
    
    // MARK:- IBAction
    
    /// ボタンタップ
    /// - Parameter sender: ボタン
    @IBAction func tapCalculatoButton(_ sender: CalculatorButton) {
        calculatorManager.input(type: sender.type)
        // 表示を出し分ける
        switch sender.type {
        case .number(_):
            // 値を入力中は入力中の値を表示する
            self.resultLabel.update(with: calculatorManager.calculationValue)
        case .dot:
            let calculationValue = calculatorManager.calculationValue
            let hasDecimalPart = hasDecimal(value: calculationValue)
            // 小数点を入力した場合、数値入力中とみなせるため入力中の値を表示する
            // 少数部分をもっていない場合、[.]が表示されないため追加する
            self.resultLabel.update(with: calculationValue, addDotToEnd: !hasDecimalPart)
        default:
            // 入力中以外は結果を表示する
            self.resultLabel.update(with: calculatorManager.currentResult ?? 0)
        }
    }
    
    
    // MARK:- Life Cycle
    
    /// 画面読み込み完了処理
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI初期化
        self.initializeUserInterface()
    }
    
    // MARK:- Private Method
    
    /// UIを初期化する
    private func initializeUserInterface() {
        // 各ボタンにタイプを設定する
        self.CalculatorButtons
            .enumerated()
            .forEach { index, button in
                button.setup(with: self.buttonOrder[index])
        }
        // ラベル初期化
        self.resultLabel.update(with: calculatorManager.calculationValue)
    }
    
    /// 引数が少数部分を持つか判定する
    /// - Parameter value: 判定する値
    /// - Returns: 結果
    private func hasDecimal(value: Double) -> Bool {
        // 一度Int型に変換することで整数部分を抜き出す
        let integerPart = Double(Int(value))
        // 整数部分と引数の値が一致しなければ小数部分をもっていると判断する
        return value != integerPart
    }
}

