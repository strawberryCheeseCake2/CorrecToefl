//
//  EditorViewController.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/26.
//

import UIKit
import SnapKit

class EditorViewController: UIViewController {
	
	lazy var backButton = UIBarButtonItem(image: UIImage(systemName: ImageName.backIcon.rawValue), style: .plain, target: self, action: #selector(backButtonPressd))
	
	lazy var submitButton: UIButton = {
		let button = UIButton()
		button.setTitle("완료", for: .normal)
		button.setTitleColor(.placeholderText, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
		button.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
		button.isUserInteractionEnabled = false
		return button
	}()
	
	let scrollView = UIScrollView()
	let topLevelStackView = StackView(axis: .vertical, spacing: 16)
	
	let separatorBackgroundView: StackView = {
		let stackView = StackView(axis: .vertical, spacing: 0.34)
		stackView.backgroundColor = .separator
		return stackView
	}()
	
	let questionTextView = InputTextView(gravity: .leadingCenter, placeholder: "문제를 입력하세요")
	let answerTextView = InputTextView(gravity: .leadingTop, placeholder: "첨삭받을 답안을 입력하세요")
	
	var ocrResultPrompt: Prompt?
	
	// MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
		addSubviews()
		configureTextView()
		setupLayout()
		
		hideKeyboardOnTapAround()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		setNavigationBarShadowColor(.clear)
		questionTextView.becomeFirstResponder()
		addKeyboardNotifications()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		setNavigationBarShadowColor(.separator)
		removeKeyboardNotifications()
	}
	
	private func configureTextView() {
		questionTextView.delegate = self
		answerTextView.delegate = self
		
	}
	
	
	
	
}

// MARK: Default VC Configuration & Layout
extension EditorViewController {
	private func configureVC() {
		view.backgroundColor = .background
		self.navigationItem.hidesBackButton = true
		self.navigationItem.leftBarButtonItem = backButton
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: submitButton)
		
	}
	
	private func setNavigationBarShadowColor(_ color: UIColor) {
		if let appearance = navigationController?.navigationBar.standardAppearance {
			appearance.shadowColor = color
			navigationController?.navigationBar.scrollEdgeAppearance = appearance
		}
	}
	
	private func addSubviews() {
		view.addSubview(scrollView)
		scrollView.addSubview(topLevelStackView)
		topLevelStackView.addArrangedSubview(separatorBackgroundView)
		separatorBackgroundView.addArrangedSubview(questionTextView)
		separatorBackgroundView.addArrangedSubview(answerTextView)
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
			make.top.equalToSuperview()
			make.width.equalToSuperview()
			make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
		}
		
		separatorBackgroundView.snp.makeConstraints { make in
			make.width.equalToSuperview()
		}
		
		questionTextView.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.height.equalTo(64)
		}
		
		answerTextView.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.height.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(-64)
		}
		
	}
	
	
}

// MARK: Button Methods
extension EditorViewController {
	@objc
	private func backButtonPressd() {
		navigationController?.popToRootVCWithFadeOut()
	}
	
	@objc
	private func submitButtonPressed() {
		let resultVC = ResultViewController(question: questionTextView.text, answer: answerTextView.text)
		navigationController?.pushWithFadeIn(resultVC)
	}
}

// MARK: TextViewDelegate
extension EditorViewController: UITextViewDelegate {
	private func updateLayout(with height: Double) {
		questionTextView.snp.remakeConstraints { make in
			make.top.equalToSuperview()
			make.height.equalTo(height)
			make.width.equalToSuperview()
		}
		
		answerTextView.snp.remakeConstraints { make in
			make.width.equalToSuperview()
			make.height.greaterThanOrEqualTo(scrollView.snp.height).offset(-64)
		}
	}
	
	private func adjustTextViewHeight() {
		let fixedWidth = questionTextView.frame.size.width
		let newSize = questionTextView.sizeThatFits(CGSize(width: fixedWidth, height: .greatestFiniteMagnitude))
		
		updateLayout(with: newSize.height)
		UIView.animate(withDuration: 0.3, animations: {
			self.view.layoutIfNeeded()
		})
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {

	}
	
	func textViewDidChange(_ textView: UITextView) {
		adjustTextViewHeight()
		
		if textView.text == "" {
			(textView as? InputTextView)?.placholderLabel.isHidden = false
			setSubmitButtonAvailability(to: false)
		} else {
			(textView as? InputTextView)?.placholderLabel.isHidden = true
			
			if questionTextView.text != "" && answerTextView.text != "" {
				setSubmitButtonAvailability(to: true)
			}
		}
		
	}
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		
	} // didBeginEditing
	
	
	private func setSubmitButtonAvailability(to: Bool) {
		if to {
			submitButton.isUserInteractionEnabled = true
			submitButton.setTitleColor(.brand, for: .normal)
		} else {
			submitButton.isUserInteractionEnabled = false
			submitButton.setTitleColor(.placeholderText, for: .normal)
		}
	}
	
	
}

// MARK: Keyboard Notifications
extension EditorViewController {
	func addKeyboardNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillShow(notification:)),
											   name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillHide(notification:)),
											   name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc
	func keyboardWillShow(notification: NSNotification) {

		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
			
			self.scrollView.snp.remakeConstraints { make in
				make.width.equalToSuperview()
				make.top.equalTo(view.safeAreaLayoutGuide)
				make.bottom.equalToSuperview().offset(-keyboardSize.height)
			}
			
			self.answerTextView.snp.remakeConstraints { make in
				make.width.equalToSuperview()
				make.height.greaterThanOrEqualTo(scrollView).offset(-64)
			}
			UIView.animate(withDuration: duration) {
				self.view.layoutIfNeeded()
			}
		}
		
	}
	
	@objc
	func keyboardWillHide(notification: NSNotification) {
		
		let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
		
		self.scrollView.snp.remakeConstraints { make in
			make.width.equalToSuperview()
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.bottom.equalToSuperview()
		}
		self.answerTextView.snp.remakeConstraints { make in
			make.width.equalToSuperview()
			make.height.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(-64)
		}
		
		self.view.frame.origin.y = 0
		UIView.animate(withDuration: duration) {
			self.view.layoutIfNeeded()
		}
	}
	
	func removeKeyboardNotifications() {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	private func hideKeyboardOnTapAround() {
		let vcTapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(vcTapGesture)
		
		let navigationBarTapGesture = UITapGestureRecognizer(target: self, action: #selector(navigationBarTap))
		
		navigationController?.navigationBar.addGestureRecognizer(navigationBarTapGesture)
	}
	
	@objc
	private func navigationBarTap(_ recognizer: UIGestureRecognizer) {
		view.endEditing(true)
	}
	

	
	
}
