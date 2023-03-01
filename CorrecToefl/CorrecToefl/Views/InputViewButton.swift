//
//  InputButton.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/26.
//

import UIKit
import SnapKit

class InputViewButton: UIButton {
	
	var gravity: InputViewGravity
	var placeholderText: String
	var action: (() -> Void)?
	
	var text: String
	
	lazy var placeholderLabel: PlaceholderLabel = {
		let label = PlaceholderLabel()
		label.text = placeholderText
		label.isUserInteractionEnabled = false
		return label
	}()
	
	lazy var textLabel: DefaultTextLabel = {
		let label = DefaultTextLabel(text: text)
		label.isUserInteractionEnabled = false
		return label
	}()
	
	init(gravity: InputViewGravity, placeholder: String, action: (() -> Void)?, text: String) {
		self.gravity = gravity
		self.placeholderText = placeholder
		self.action = action
		self.text = text
		super .init(frame: .zero)
				
		configureButton()
		addSubviews()
		setupLayout()
	}
	
	convenience init(gravity: InputViewGravity, placeholder: String, action: (() -> Void)?) {
		self.init(gravity: gravity, placeholder: placeholder, action: action, text: "")
	}
	
	convenience init(text: String, action: (() -> Void)?) {
		self.init(gravity: .leadingTop, placeholder: "", action: action, text: text)
	}
	
	private func configureButton() {
		self.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
	}
	
	private func addSubviews() {
		addSubview(placeholderLabel)
		
		if placeholderText != "" {
			self.addBottomBorder(with: .separator, andWidth: 0.2)
		}
		
		addSubview(textLabel)
	}
	
	private func setupLayout() {
		placeholderLabel.snp.makeConstraints { make in
			if gravity == .leadingCenter {
				make.top.equalToSuperview().offset(16)
				make.bottom.equalToSuperview().offset(-16)
				make.left.equalToSuperview().offset(16)
			} else {
				make.centerX.equalToSuperview()
				make.centerY.equalToSuperview()
			}
		}
		
		textLabel.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		
	}
	
	@objc
	private func handleTap() {
		if let safeAction = action {
			safeAction()
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
