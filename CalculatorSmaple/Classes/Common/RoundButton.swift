//
//  RoundButton.swift
//  CalculatorSmaple
//
//  Created by Ishida Naoya on 2020/07/09.
//  Copyright © 2020 G.F.C. All rights reserved.
//

import UIKit

/// 丸ボタンクラス
class RoundButton: UIButton {
    
    /// ストーリーボードからの初期化
    /// - Parameter aDecoder: aDecoder
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    /// 初期化
    /// - Parameter frame: frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    /// レイアウト更新時処理
    override func layoutSubviews() {
        super.layoutSubviews()
        // レイアウトを再セットアップする
        setup()
    }
    
    /// レイアウトをセットアップ
    private func setup() {
        // 角丸表示。半径は高さの1/2
        self.layer.cornerRadius = self.frame.height / 2
    }
}
