//
//  QuestionForm.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/28.
//

import Foundation

struct Prompt {
	var rawValue: String
	
	init(question: String, answer: String) {
//		rawValue = "I'll give you a pair of TOEFL speaking question and my answer. Give me the feedbacks. You must include feedback about if the answer gets to of the question. Positive feedback should start with ** and negative feedback should start with ##. The Question is '\(question)'. My Answer to this question is '\(answer)'. Your Feedbacks are: "
//		print(question, answer)
		rawValue = "Here's the TOEFL a pair of speaking question and answer. Question is '\(question)' and Answer is '\(answer)'. You must include a feedback about if the answer gets to of the question. Total feedback count must be at least 3 and each of them should start with **. Your feedbacks are:"
//		rawValue = "The answer does not address the question. If it is postive feedback number is 1 else 0. The number is:"
	}
}
