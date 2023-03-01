//
//  FeedbackInputTableViewHeaderView.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/03/01.
//

import UIKit

class FeedbackInputTableViewHeaderView: UITableViewHeaderFooterView {

	static let id = "FeedbackInputTableViewHeaderView"
	
	var question: String = "" {
		didSet {
			questionViewButton.text = question
		}
	}
	
	var answer: String = "" {
		didSet {
			answerViewButton.text = answer
		}
	}
	var action: (() -> Void)? {
		didSet {
			questionViewButton.action = action
			answerViewButton.action = action
		}
	}
	
	let container = StackView(axis: .vertical, distribution: .equalSpacing, spacing: 16, alignment: .fill)
	
	let seperateView: UIView = {
		let view = UIView()
		view.backgroundColor = .separator
		return view
	}()
	
	lazy var questionViewButton = InputViewButton(text: question, action: action)
	lazy var answerViewButton = InputViewButton(text: answer, action: action)

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
//		self.translatesAutoresizingMaskIntoConstraints = false
		addSubviews()
		setupLayout()
	}
	
	private func addSubviews() {
		addSubview(container)
		container.addArrangedSubview(questionViewButton)
		container.addArrangedSubview(seperateView)
		container.addArrangedSubview(answerViewButton)
	}
	
	private func setupLayout() {
		
		container.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(16)
			make.left.equalToSuperview().offset(16)
			make.bottom.equalToSuperview().offset(-16)
			make.right.equalToSuperview().offset(-16)
		}
		
		seperateView.snp.makeConstraints { make in
			make.height.equalTo(Size.separatorSize.rawValue)
//			make.width.equalToSuperview()
		}

		questionViewButton.snp.makeConstraints { make in
//			make.width.equalToSuperview()

		}

		answerViewButton.snp.makeConstraints { make in
//			make.width.equalToSuperview()

		}
		
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
