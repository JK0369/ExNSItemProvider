//
//  ViewController.swift
//  ExNSItemProvider
//
//  Created by 김종권 on 2023/07/16.
//

import UIKit

class ViewController: UIViewController {
    private let textView: UITextView = {
        let view = UITextView()
        view.text = "텍스트... "
        view.textColor = .white
        view.font = .systemFont(ofSize: 20)
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        view.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        let textToCopy = "김종권의 iOS 앱 개발 알아가기"

        let itemProvider = NSItemProvider(object: textToCopy as NSString)
        let pasteboard = UIPasteboard.general
        pasteboard.setItemProviders([itemProvider], localOnly: true, expirationDate: Date().addingTimeInterval(10))

        // 알림 메시지 표시
        let alert = UIAlertController(
            title: "복사 성공!",
            message: "clipboard에 복사되었습니다.",
            preferredStyle: .alert
        )
        let dismissAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(dismissAction)
        present(alert, animated: true)
    }
}
