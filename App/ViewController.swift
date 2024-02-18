//
//  ViewController.swift
//  App
//
//  Created by 和田康一 on 2024/01/13.
//
// 本画面はパスワードを生成するための画面です。

import UIKit

class ViewController: UIViewController {
    
    var screenChangeMessage: String = "４桁のパスワード生成ページへ遷移しました。"
    var result_NumPass: String = ""
    var stringPassword = ["4文字", "8文字", "16文字", "その他"]
    
    @IBOutlet weak var outputSecurityMessageLabel: UILabel!
    @IBOutlet weak var outputTableView: UITableView!
    @IBOutlet weak var outputPasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputTableView.dataSource = self
        outputTableView.tableFooterView = UIView()
    }
    
    //「パスワードを生成」ボタンをタップするとtapPasswordCreateButton関数が実行される。
    // 半角英数字記号を含む、ランダムな文字列が生成される。
    @IBAction func tapCreatePasswordButton(_ sender: Any) {
        // パスワード生成に使う数字たち
        let randomInt = Int.random(in: 1...100)
        let randomInt_Re = Int.random(in: 1000...100000)
        
        // 一回目乱数発生(数字)
        let randomNumber = String(randomInt)
        
        // パスワード生成時に使う記号やアルファベットたち
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+!~|\';/.,"
        
        // 乱数発生(英字記号 / 16桁) メモ：ユーザが選択できるようにする予定
        let randomStr = String((0..<(16)).map{ _ in base.randomElement()! })
        
        // 二回目乱数発生(数字)
        let randomNumber_Re = String(randomInt_Re)
        
        // 合体
        let passANS = randomNumber + randomStr + randomNumber_Re
        
        print(passANS)
        outputPasswordLabel.text = passANS
    }
    
    //「暗証番号の生成」ボタンをタップすると、tapPasswordMaskButton関数が実行される。
    // パスワードが非表示になる。
    @IBAction func tapPasswordMaskButton(_ sender: Any) {
        // セキュリティーメッセージ用のテキストボックスへ出力
        let text: String? = "セキュリティ上の観点から非表示中"
        outputSecurityMessageLabel.text = text
        
        // パスワード出力テキストボックス 非表示・表示処理
        outputPasswordLabel.isHidden = !outputPasswordLabel.isHidden
        
        // セキュリティーメッセージ用のテキストボックス 非表示・表示処理
        outputSecurityMessageLabel.isHidden = !outputPasswordLabel.isHidden
    }
    
    //「暗証番号の生成」ボタンをタップすると、tapNextScreenButton関数が実行される。
    // ４桁のパスワードを生成するための専用画面へ遷移する。
    @IBAction func tapNextScreenButton(_ sender: UIButton) {
        let nextVC = NextViewController()
        nextVC.name = self.screenChangeMessage
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //「暗証番号の生成」ボタンをタップすると、tabGetNumberPasswordButton関数が実行される。
    // 生成した４桁のパスワードをdelegateを使って子画面から親画面に渡す。
    @IBAction func tabGetNumberPasswordButton(_ sender: Any) {
        let nextVC = NextViewController()
        nextVC.delegate = self
        print("ボタンが押されました。")
        print(result_NumPass)
    }
}

extension ViewController: UITableViewDataSource {
    // リストの数を指定する　passlistの配列の個数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringPassword.count
    }
    
    // リストの中身を出力する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "paslis", for: indexPath)
        
        cell.textLabel?.text = stringPassword[indexPath.row]
        return cell
    }
}

// 子画面から親画面へ４桁の暗証番号を渡す。
extension ViewController: NextViewControllerDelegate{
    func update(result_num: String) {
        self.result_NumPass = result_num
    }
}

extension ViewController: NextNextViewControllerDelegate {
    func didSelectItem(ppicker: NextNextViewController, didSelectItem item: String) {
        print("\(item)")
    }
}
