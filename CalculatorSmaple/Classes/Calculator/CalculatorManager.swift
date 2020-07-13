//
//  CalcuratorManager.swift
//  CalculatorSmaple
//
//  Created by Ishida Naoya on 2020/07/11.
//  Copyright © 2020 G.F.C. All rights reserved.
//

import Foundation

/// 電卓の計算を一元管理するクラス。外部からは入力中の値と計算結果のみを公開し、input経由でのみ値の操作ができるようにする
class CalculatorManager {
    /// 入力のステータス
    enum InputState {
        case editingInteger
        case editingDecimal
        case operation
        case equal
    }
    
    // MARK:- Property
    
    /// 現在の計算結果
    private(set) var currentResult: Double?
    /// 計算する値。currentResultにこの値で四則演算を行う
    var calculationValue: Double {
        get {
            return integerPart + decimalPart
        }
    }
    /// 編集中か
    private var state: InputState = .editingInteger
    /// 計算操作の種類
    private var currentOperation: CalculatorInputType.Operator?
    /// 桁数
    private var digitCoefficient: Int = 1
    /// 整数部
    private var integerPart: Double = 0
    /// 小数部
    private var decimalPart: Double = 0
    /// 少数にかける係数
    private var decimalCoefficient: Double = 0.1
    
    // MARK:- Public Method
    
    /// 入力
    /// - Parameter type: 入力タイプ
    func input(type: CalculatorInputType) {
        // タイプに合わせてそれぞれの処理に分岐させる
        switch type {
        case .number(let value):
            inputNumber(value: value)
        case .operation(let operation):
            inputOperation(operation: operation)
        case .equal:
            inputEqual()
        case .dot:
            inputDot()
        case .plusMinus:
            inputPlusMinus()
        case .parcentage:
            inputParcentage()
        case .clear:
            inputClear()
        case .undefine:
            return
        }
    }
    
    // MARK:- Private Method
    
    /// 数値入力処理
    /// - Parameter value: 入力値
    private func inputNumber(value: Int) {
        // 値を更新する
        updateCalculationValue(inputNumber: value)
    }
    
    /// 演算子入力処理
    private func inputOperation(operation: CalculatorInputType.Operator) {
        currentOperation = operation
        // 演算子を連打するとその分計算結果が更新されてしまうため数字入力後以外はガードする
        guard state == .editingInteger || state == .editingDecimal else {
            state = .operation
            return
        }
        // 結果を計算する
        currentResult = calculate(operation: operation,
                                  currentResult: currentResult,
                                  value: calculationValue)
        state = .operation
    }
    
    /// イコール入力処理
    private func inputEqual() {
        guard let operation = currentOperation else {
            // 結果がnilの場合は計算値を結果として扱う
            if currentResult == nil {
                currentResult = calculationValue
            }
            state = .equal
            return
        }
        // 結果を計算する
        currentResult = calculate(operation: operation,
                                  currentResult: currentResult,
                                  value: calculationValue)
        state = .equal
    }
    
    /// ドット入力処理
    private func inputDot() {
        // 少数入力中の場合無視する
        guard state != .editingDecimal else {
            return
        }
        // 数値入力中以外の場合(=を入力した直後など)計算する値を初期化する
        // state != .editingDecimalはすでにガードしているため不要だが数値入力以外ということを明示的に示している
        if state != .editingDecimal && state != .editingInteger {
            integerPart = 0
            decimalPart = 0
        }
        state = .editingDecimal
        decimalCoefficient = 0.1
    }
    
    /// ±入力処理
    private func inputPlusMinus() {
        // 符号変換後は[=]を入力した状態と同じとして扱う
        state = .equal
        // 符号変換
        currentResult = -1 * (currentResult ?? calculationValue)
    }
    
    /// ％入力処理
    private func inputParcentage() {
        // ％計算後は[=]を入力した状態と同じとして扱う
        state = .equal
        // %変換
        currentResult = (currentResult ?? calculationValue) / 100
    }
    
    /// クリア入力処理
    private func inputClear() {
        /// 全ての値を初期化する
        state = .editingInteger
        currentResult = nil
        integerPart = 0
        decimalPart = 0
        decimalCoefficient = 0.1
        currentOperation = nil
    }
    
    /// オペレータに合わせて計算をする
    /// - Parameters:
    ///   - operation: オペレータ
    ///   - currentResult: 現在の結果
    ///   - inputtingValue: 入力された値
    /// - Returns: 計算結果
    private func calculate(operation: CalculatorInputType.Operator, currentResult: Double?, value: Double) -> Double {
        guard let currentResult = currentResult else {
            return value
        }
        switch operation {
        case .plus:
            return currentResult + value
        case .minus:
            return currentResult - value
        case .multiply:
            return currentResult * value
        case .division:
            return currentResult / value
        }
    }
    
    /// 計算値を更新する
    /// - Parameters:
    ///   - state: 入力状態
    ///   - inputNumber: 入力値
    private func updateCalculationValue(inputNumber: Int) {
        switch state {
        case .editingInteger:
            // 整数計算
            integerPart = integerPart * 10 + Double(inputNumber)
        case .editingDecimal:
            // 少数計算
            decimalPart = decimalPart + Double(inputNumber) * decimalCoefficient
            decimalCoefficient = decimalCoefficient * 0.1
        case .operation:
            // 初期化
            integerPart = 0
            decimalPart = 0
            decimalCoefficient = 0.1
            state = .editingInteger
            // 整数計算
            integerPart = integerPart * 10 + Double(inputNumber)
        case .equal:
            // 初期化
            integerPart = 0
            decimalPart = 0
            decimalCoefficient = 0.1
            currentResult = nil
            state = .editingInteger
            // 整数計算
            integerPart = integerPart * 10 + Double(inputNumber)
        }
    }
}
