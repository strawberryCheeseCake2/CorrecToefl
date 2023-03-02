import UIKit
import Foundation


let text = "Some people believe that it is better for children to grow up in the city, while others think that the countryside is more suitable. Which do you think is better? Give reasons and examples to support your opinion.  I think city is much better. Children being raised in city have less stress than in country side since children being raised in city tend to get study stress."

var sentences: [String] = []
text.enumerateSubstrings(in: text.startIndex..., options: [.localized, .bySentences]) { (tag, _, _, _) in
	sentences.append(tag ?? "")
}

let question = sentences[0] + sentences[1]
var answer: String = ""

for chunk in sentences[2...] {
	answer += chunk
}
print("Q:")
print(question)
print("A: ")
print(answer)
//print(sentences)
