//
//  CalculatorInputType.swift
//  CalculatorSmaple
//
//  Created by Ishida Naoya on 2020/07/09.
//  Copyright © 2020 G.F.C. All rights reserved.
//

import UIKit

/// 入力ボタンのタイプ
enum CalculatorInputType {
    /// 演算子
    enum Operator {
        case plus
        case minus
        case multiply
        case division
    }
    case clear
    case plusMinus
    case parcentage
    case number(Int)
    case operation(Operator)
    case equal
    case dot
    case undefine
    
    /// タイプに合わせたテキストカラーを返す
    /// - Returns: テキストカラー
    func getTextColor() -> UIColor {
        switch self {
        case .clear, .plusMinus, .parcentage:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        default:
            return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    /// タイプに合わせたボタンの背景色を返す
    /// - Returns: ボタンの背景色
    func getBackgroundColor() -> UIColor {
        switch self {
        case .clear, .plusMinus, .parcentage:
            return #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        case .operation(_), .equal:
            return #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        case .number(_), .dot:
            return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        case .undefine:
            return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    /// タイプに合わせた文言を返す
    /// - Returns: 文言
    func getText() -> String {
        switch self {
        case .clear:
            return "AC"
        case .plusMinus:
            return "+/-"
        case .parcentage:
            return "%"
        case .operation(let type):
            switch type {
            case .plus:
                return "+"
            case .minus:
                return "-"
            case .multiply:
                return "×"
            case .division:
                return "÷"
            }
        case .equal:
            return "="
        case .dot:
            return "."
        case .number(let value):
            return "\(value)"
        case .undefine:
            return ""
        }
    }
}
