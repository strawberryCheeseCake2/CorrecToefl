//
//  AngularButton.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/26.
//

import UIKit

class AngularButton: UIButton {
	
	private var title: String
	private var action: (() -> Void)?
	
	private let contentContainer: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.alignment = .center
		stackView.spacing = 8
		stackView.isUserInteractionEnabled = false
		return stackView
	}()
	
	private let iconView: UIImageView = {
		let imageView = UIImageView()
		let configuration = UIImage.SymbolConfiguration(pointSize: 64)
		imageView.image = UIImage(systemName: ImageName.scanIcon.rawValue, withConfiguration: configuration)
		imageView.isUserInteractionEnabled = false
		return imageView
	}()
	
	private lazy var customTitleLabel: UILabel = {
		let label = UILabel()
		label.text = title
		label.textColor = .white
		label.font = .systemFont(ofSize: 16, weight: .medium)
		label.isUserInteractionEnabled = false
		return label
	}()
	
	init(color: UIColor, title: String, action: (() -> Void)? = nil) {
		self.title = title
		self.action = action
		super .init(frame: .zero)
		configureButton(color: color)
		addSubviews()
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureButton(color: UIColor) {
		self.backgroundColor = color
		self.tintColor = .white
		self.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
	}
	
	private func addSubviews() {
		addSubview(contentContainer)
		contentContainer.addArrangedSubview(iconView)
		contentContainer.addArrangedSubview(customTitleLabel)
	}
	
	private func setupLayout() {
		contentContainer.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.centerX.equalToSuperview()
		}
	}
	
	@objc
	private func handleTap() {
		if let safeAction = action {
			safeAction()
		}
	}
	
	
	
}
