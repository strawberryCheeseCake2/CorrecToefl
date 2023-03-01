//
//  InputTextView.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/26.
//

import UIKit

class InputTextView: UITextView {
	
	let gravity: InputViewGravity
	
	let placeholder: String
	
	lazy var placholderLabel: PlaceholderLabel = {
		let label = PlaceholderLabel()
		label.text = placeholder
		return label
	}()
	
	init(gravity: InputViewGravity, placeholder: String) {
		self.gravity = gravity
		self.placeholder = placeholder
		super .init(frame: .zero, textContainer: .none)
		configureTextView()
		addSubviews()
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureTextView() {

		self.backgroundColor = .background
		self.isScrollEnabled = false
		self.setContentHuggingPriority(.required, for: .vertical)
		self.textColor = .primary
		self.font = .systemFont(ofSize: 16, weight: .medium)
	}
	
	private func addSubviews() {
		addSubview(placholderLabel)
	}
	
	private func setupLayout() {
		self.textContainerInset = UIEdgeInsets(top: 24.03 , left: 12, bottom: 24.03, right: 16)

		placholderLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(24.02)
			make.bottom.equalToSuperview().offset(-24.02)
			make.left.equalToSuperview().offset(16)
		}
//		self.contentInset = UIEdgeInsets(top: 24.03 , left: 12, bottom: 24.03, right: 16)
	}
}
