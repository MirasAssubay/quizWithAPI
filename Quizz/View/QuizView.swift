//
//  QuizView.swift
//  Quizz
//
//  Created by Мирас Асубай on 07.04.2023.
//

import UIKit

class QuizView: UIView {
    deinit {
        print("QuizView Deinitialized")
    }

    private var questionNumber = 0
    private var questionsCount = 0
    public var questionsArray: [Question] = []
    private var scoreCounter = 0
    
    private let answer1 = UIButton.customButton(backgroundColor: .systemCyan, text: "Answer1")
    private let answer2 = UIButton.customButton(backgroundColor: .systemGray, text: "Answer2")
    private let answer3 = UIButton.customButton(backgroundColor: .systemMint, text: "Answer3")
    private let answer4 = UIButton.customButton(backgroundColor: .systemTeal, text: "Answer4")
    
    
    
    private let question: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "What nursery rhyme is about a girl who went to the woods?"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [answer1, answer2, answer3, answer4])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(question)
        addSubview(stackView)
        
        answer1.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        answer2.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        answer3.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        answer4.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        
        let margins = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: margins.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            question.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            question.topAnchor.constraint(equalTo: margins.topAnchor),
            question.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            question.bottomAnchor.constraint(equalTo: stackView.topAnchor)
        ])
    }
    
    @objc private func checkAnswer(sender: UIButton!) {
        if sender.titleLabel?.text == questionsArray[questionNumber].correct_answer {
            scoreCounter += 1
            if questionNumber + 1 <= questionsArray.count - 1 {
                let alert = UIAlertController(title: "Correct!", message: "Move to the next question", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.window?.rootViewController?.present(alert, animated: true)
                questionNumber += 1
            }
            else {
                let alert = UIAlertController(title: "Completed", message: "Your total score is \(scoreCounter)/\(questionsArray.count)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.window?.rootViewController?.present(alert, animated: true)
                questionNumber = 0
                scoreCounter = 0
            }
            
        }
        else {
            if questionNumber + 1 <= questionsArray.count - 1 {
                let correctAnswer = String(htmlEncodedString: questionsArray[questionNumber].correct_answer)
                let alert = UIAlertController(title: "Incorrect!", message: "Correct Answer is: \(correctAnswer ?? "Can't encode htmlString")", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.window?.rootViewController?.present(alert, animated: true)
                questionNumber += 1
            }
            else {
                let alert = UIAlertController(title: "Completed", message: "Your total score is \(scoreCounter)/\(questionsArray.count)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.window?.rootViewController?.present(alert, animated: true)
                questionNumber = 0
                scoreCounter = 0
            }
        }
        setQuestion(questions: questionsArray)
        
    }
    
    
    @objc func updateUI() {
        setQuestion(questions: questionsArray)
    }
    
    public func setQuestion(questions: [Question]){
        var answers = [
            String(htmlEncodedString: questions[questionNumber].incorrect_answers[0]),
            String(htmlEncodedString: questions[questionNumber].incorrect_answers[1]),
            String(htmlEncodedString: questions[questionNumber].incorrect_answers[2]),
            String(htmlEncodedString: questions[questionNumber].correct_answer)]
        answers.shuffle()
        DispatchQueue.main.async { [unowned self] in
            let questionText = String(htmlEncodedString: questions[questionNumber].question)
            self.question.text = questionText
            self.answer1.setTitle(answers[0], for: .normal)
            self.answer2.setTitle(answers[1], for: .normal)
            self.answer3.setTitle(answers[2], for: .normal)
            self.answer4.setTitle(answers[3], for: .normal)
//            print(QuizView.questionsCount)
        }
    }
    
    
    
}

extension UIButton {
    static func customButton(backgroundColor: UIColor, text: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(text, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
//        button.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        return button
    }
    
   
}

extension String {

    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }

}
