//
//  CalculatorButton.swift
//  CalculatorSmaple
//
//  Created by Ishida Naoya on 2020/07/09.
//  Copyright © 2020 G.F.C. All rights reserved.
//

import UIKit

/// 電卓用ボタンクラス
class CalculatorButton: RoundButton {
    /// ボタンの種類
    var type: CalculatorInputType = .undefine
    
    /// UI設定する
    /// - Parameter type: ボタンの種別
    func setup(with type: CalculatorInputType) {
        self.type = type
        // typeに合わせてUI更新
        self.backgroundColor = type.getBackgroundColor()
        self.setTitleColor(type.getTextColor(), for: .normal)
        self.setTitle(type.getText(), for: .normal)
        
        self.titleLabel?.font = .systemFont(ofSize: 27)
    }
}
