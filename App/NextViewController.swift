//
//  NextViewController.swift
//  Password-generator
//
//  Created by 和田康一 on 2024/02/11.
//
// 本画面は暗証番号(４桁)を生成するための画面です。

import UIKit

protocol NextViewControllerDelegate: AnyObject{
    func update(resultNum: String)
}

class NextViewController: UIViewController {
    
    // MARK: - Properties
    
    var name: String = ""
    var name2: String = "最後の画面です。"
    var resultNum: String = ""
    
    weak var delegate: NextViewControllerDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    // MARK: - View Life-Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarButtonItems()
    }
    
    // MARK: - IBActions
    
    // 「４桁のパスワードを生成」ボタンをタップするとtapCreateNumberPasswordButton関数が実行される。
    // ４桁の数字がランダム表示される。
    @IBAction func tapCreateNumberPasswordButton(_ sender: Any) {
        print("ボタンが押されました")
        // 適用ボタンが押されたら、ViewController.swiftから文字列を受け取る。
        // 文字列の内容：４桁の生成ページへ遷移しました。
        messageLabel.text = name
        
        // パスワード生成時に使う数字たち
        let numbase = "1234567890"
        
        // 乱数発生(数字 / 4桁)
        let randomNum = String((0..<(4)).map{ _ in numbase.randomElement()! })
        print(randomNum)
        resultLabel.text = randomNum
        resultNum = randomNum
    }
    
    // 画面遷移（作成中です。）
    @IBAction func nextTapButton(_ sender: UIButton) {
        let nextnextVC = NextNextViewController()
        nextnextVC.name2 = self.name2
        navigationController?.pushViewController(nextnextVC, animated: true)
    }
    
    // MARK: - Other Methods
    
    /// バーボタンアイテムの設定
    private func configureBarButtonItems() {
        let closeButton = UIBarButtonItem(title: "戻る",
                                          style: .plain,
                                          target: self,
                                          action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    /// 戻るボタンがタップされた
    @objc func didTapBackButton() {
        //　生成した４桁の数字を親画面へ渡す。
        delegate?.update(resultNum: resultNum)
        // １つ前の画面に戻る
        navigationController?.popViewController(animated: true)
    }
}
