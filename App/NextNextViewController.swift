//
//  NextNextViewController.swift
//  Password-generator
//
//  Created by 和田康一 on 2024/02/11.
//

import UIKit

protocol NextNextViewControllerDelegate: AnyObject {
    func didSelectItem(ppicker: NextNextViewController, didSelectItem item: String)
}

final class NextNextViewController: UIViewController {
    
    var name2: String = ""
    
    weak var delegate: NextNextViewControllerDelegate?
    private var selectedItem: String = "最後の画面までいきました。"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var result2Text: UILabel!
    
    @IBAction func apply2Button(_ sender: Any) {
        result2Text.text = name2
        delegate?.didSelectItem(ppicker: self, didSelectItem: selectedItem)
    }
    
    
    func configureBarButtonItems() {
        let closeButton = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(didTapCloseButton))
        navigationItem.rightBarButtonItem = closeButton // leftかrightかで左右を選択
    }
    
    @objc func didTapCloseButton() {
        // ボタンがタップされたときの処理
        // 前の画面へ戻る処理（ViewControllerは前画面を表している。）
        let backVC = ViewController()
        navigationController?.pushViewController(backVC, animated: true)
    }
}
