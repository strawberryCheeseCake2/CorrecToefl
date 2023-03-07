//
//  QuestionForm.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/28.
//

import Foundation

struct FeedbackPrompt {
	var promptString: String
	let question: String
	let answer: String
	init(question: String, answer: String) {
		self.question = question
		self.answer = answer
		self.promptString = "Here's the a pair of  TOEFL writing/speaking question and answer. Question is '\(question)' and Answer is '\(answer)'. You must check the grammar strictly and if it's wrong, you must tell me what is wrong and you must check if it's natural. Total feedback count must be at least 5 and each of them should start with **. And at least 1 of them must be suggestion or negative feedback. Your feedbacks are:"
	}
}
