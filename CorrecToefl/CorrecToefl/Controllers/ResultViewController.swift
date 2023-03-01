//
//  ResultViewController.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/28.
//

import SkeletonView
import SnapKit
import UIKit

class ResultViewController: UIViewController {
	var feedbacks = [Feedback]()
	var question: String
	var answer: String
	
	lazy var backButton = UIBarButtonItem(image: UIImage(systemName: ImageName.backIcon.rawValue), style: .plain, target: self, action: #selector(backButtonPressd))
	
	let feedbackTableView = UITableView()
	let scrollView = UIScrollView()
	let topLevelStackView = StackView(axis: .vertical, distribution: .equalSpacing, spacing: 24, alignment: .leading)
	
	let seperateView: UIView = {
		let view = UIView()
		view.backgroundColor = .separator
		return view
	}()
	
	lazy var questionButton = InputViewButton(text: question, action: inputViewButtonPressed)
	lazy var answerLabelButton = InputViewButton(text: answer, action: inputViewButtonPressed)
	
	let feedbackHeader = HeaderLabel(text: "피드백")
	let feedbackStackView = StackView(axis: .vertical, spacing: 16)
	
	let promptManger = PromptManger()
	
	init(question: String, answer: String) {
		self.question = question
		self.answer = answer
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
		addSubviews()
		setupLayout()
		generateSkeletons(howMany: SkeletonNumbers.feedback.rawValue)
//		loadFeedback()
	}
	
	private func loadFeedback() {
		promptManger.getFeedback(question: question, answer: answer) { [weak self] result in

			guard self != nil,
			      let safePromptManger = self?.promptManger,
			      let feedbackSkeletons = self?.feedbackStackView.arrangedSubviews
			else { return }
			
			self?.feedbacks = safePromptManger.parsePrompt(result)
			print(self!.feedbacks)
			
			self?.updateFeedbackView()
//			self?.scrollToBottom()
		}
	}
  
	private func updateFeedbackView() {
		let dataCount = feedbacks.count
		let skeletonCount = SkeletonNumbers.feedback.rawValue
		let extraNumber = skeletonCount - dataCount
		
		guard let feedbackViews = feedbackStackView.arrangedSubviews as? [FeedbackListItemView] else { return }
		
		// Adjust count of feedback views
		if skeletonCount > dataCount {
			// Hide unnecessary feedback views
			for index in 0 ..< extraNumber {
				feedbackViews[dataCount + index].isHidden = true
			}
		} else {
			// Add needed feedback views
			generateSkeletons(howMany: extraNumber)
		}
		print("update")
		// Update feedback view data & Hide skeletons
		DispatchQueue.main.async {
			for feedbackIndex in 0 ..< dataCount {
				print(self.feedbacks[feedbackIndex].feedbackString)
				let feedbackView = feedbackViews[feedbackIndex]
				feedbackViews[feedbackIndex].feedbackLabel.text = self.feedbacks[feedbackIndex].feedbackString
				feedbackViews[feedbackIndex].icon.hideSkeleton()
				feedbackViews[feedbackIndex].feedbackLabel.hideSkeleton()
			}
		}
	
		
	}
	
	private func scrollToBottom() {
		let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.adjustedContentInset.bottom)
		scrollView.setContentOffset(bottomOffset, animated: true)
	}
}

// MARK: Button Action Methods

extension ResultViewController {
	@objc
	private func backButtonPressd() {
		navigationController?.popToRootVCWithFadeOut()
	}
	
	@objc
	private func inputViewButtonPressed() {
		navigationController?.popWithFadeOut()
	}
}

// MARK: Default VC Configuration & Layout

extension ResultViewController {
	private func configureVC() {
		view.backgroundColor = .background
		navigationItem.hidesBackButton = true
		navigationItem.leftBarButtonItem = backButton
	}
	
	private func addSubviews() {
		view.addSubview(scrollView)
		scrollView.addSubview(topLevelStackView)
		topLevelStackView.addArrangedSubview(questionButton)
		topLevelStackView.addArrangedSubview(seperateView)
		topLevelStackView.addArrangedSubview(answerLabelButton)
		topLevelStackView.addArrangedSubview(feedbackHeader)
		topLevelStackView.addArrangedSubview(feedbackStackView)
	}
	
	private func setupLayout() {
		scrollView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.width.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		scrollView.contentLayoutGuide.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		topLevelStackView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(16)
			make.left.equalToSuperview().offset(16)
			make.right.equalToSuperview().offset(-16)
			make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
		}
		
		seperateView.snp.makeConstraints { make in
			make.height.equalTo(Size.seperatorSize.rawValue)
			make.width.equalToSuperview()
		}
		
		questionButton.snp.makeConstraints { make in
			make.width.equalToSuperview()
		}
		
		feedbackStackView.snp.makeConstraints { make in
			make.width.equalToSuperview()
		}
	}
}

// MARK: Skeleton

extension ResultViewController {
	private func generateSkeletons(howMany count: Int) {
		for _ in 0 ..< count {
			let skeletonFeedback = FeedbackListItemView(type: .check, feedback: "TheDefaultTextForSkeletonViewTheDefaultTextForSkeletonViewTheDefaultTextForSkeletonView")
			feedbackStackView.addArrangedSubview(skeletonFeedback)
		}
	}
	
	private func hideSkeletons() {}
}
