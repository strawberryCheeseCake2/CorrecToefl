//
//  ResultView.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/27.
//
import UIKit
import SnapKit

class ResultView: StackView {
	
	let feedbackHeader = HeaderLabel(text: "피드백")
	let suggestionHeader = HeaderLabel(text: "이렇게 써보면 어떨까요?")
	
	let feedbackListItemView = FeedbackListItemView(type: .check, feedback: "피드백 피드백")
	let cross = FeedbackListItemView(type: .cross, feedback: "피드백")
	
	let suggestionContent: DefaultTextLabel = {
		let label = DefaultTextLabel(text: "abcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefg")
		label.numberOfLines = 0
		return label
	}()
	
	init() {
		super .init(axis: .vertical, distribution: .equalSpacing, spacing: 16, alignment: .leading)
		addSubviews()
		setupLayout()

	}
	
	private func addSubviews() {
		addArrangedSubview(feedbackHeader)
		addArrangedSubview(feedbackListItemView)
		addArrangedSubview(cross)
		addArrangedSubview(suggestionHeader)
		addArrangedSubview(suggestionContent)
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupLayout() {
//		feedbackListItemView.snp.makeConstraints { make in
//			make.width.equalToSuperview()
//			make.height.equalTo(32)
//		}
	}
}
