//
//  HomeViewController.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/25.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
	
	let topLevelStackView = StackView(axis: .vertical, spacing: 0.34)
	
	lazy var questionInputViewButton = InputViewButton(gravity: .leadingCenter, placeholder: "문제를 입력하세요", action: inputViewPressed)
	
	lazy var answerInputViewButton = InputViewButton(gravity: .center, placeholder: "첨삭 받을 답안을 입력하세요", action: inputViewPressed)
	
	lazy var angularScanButton = AngularButton(color: .brand, title: "스캔해서 입력하기", action: scanToFillButtonPressed)
	
	// MARK: ViewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
		addSubviews()
		setupLayout()
		
	}
	


}

// MARK: Default Configuration
extension HomeViewController {
	private func configureVC() {
		view.backgroundColor = .background
		self.title = "CorrecTOEFL"
	}
	
	private func addSubviews() {
		view.addSubview(topLevelStackView)
		topLevelStackView.addArrangedSubview(questionInputViewButton)
		topLevelStackView.addArrangedSubview(answerInputViewButton)
		topLevelStackView.addArrangedSubview(angularScanButton)
	}
	
	private func setupLayout() {
		topLevelStackView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.width.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		questionInputViewButton.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.height.equalTo(64)
		}
		
		answerInputViewButton.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.top.equalTo(questionInputViewButton.snp.bottom).offset(Size.seperatorSize.rawValue)
			make.bottom.equalTo(angularScanButton.snp.top).offset(-Size.seperatorSize.rawValue)
		}
		
		angularScanButton.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.height.equalToSuperview().multipliedBy(0.23)
		}
	}
}

// MARK: Button Actions
extension HomeViewController {
	func scanToFillButtonPressed() {
		print("hit")
	}
	
	func inputViewPressed() {
		let editorVC = EditorViewController()
		navigationController?.pushWithFadeIn(editorVC)
	}
}
