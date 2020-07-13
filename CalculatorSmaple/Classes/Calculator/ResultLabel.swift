//
//  ResultLabel.swift
//  CalculatorSmaple
//
//  Created by Ishida Naoya on 2020/07/11.
//  Copyright © 2020 G.F.C. All rights reserved.
//

import UIKit

/// 結果表示用ラベルクラス
class ResultLabel: UILabel {
    // MARK:- Property
    
    // MARK:- Public Method
    
    /// 表示を更新する
    /// - Parameter number: 数値
    /// - Parameter addDotToEnd: 文末に[.]を追加するかどうか（デフォルト：false）
    func update(with number: Double, addDotToEnd: Bool = false) {
        if (addDotToEnd) {
            self.text = self.transform(number: number) + "."
        } else {
            self.text = self.transform(number: number)
        }
    }
    
    // MARK:- Private Method
    
    /// 数値をカンマ付き文字列に変換する（例：1,000,000）
    /// - Parameter number: 変換する数値
    /// - Returns: 変換後の文字列
    private func transform(number:Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        formatter.maximumFractionDigits = 5
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: number)) ?? "0"
    }
}
