//
//  ViewController.swift
//  Quizz
//
//  Created by Мирас Асубай on 07.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var questions: ([Question]) = [Question]()
    private var answers: [String] = []
    private let quizView = QuizView()
    public var categoryId = "10"
    public var category = ""
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setToolbarHidden(true, animated: animated)
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setToolbarHidden(false, animated: animated)
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
        title = category
    }
    deinit {
        print("Deinitialized")
    }
    private func fetchData() {
        APICaller.shared.getRandomQuestions(category: categoryId) { result in
            switch result {
            case .success(let questionsResponse):
                self.quizView.questionsArray.append(contentsOf: questionsResponse)
                self.quizView.setQuestion(questions: questionsResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(quizView)
        quizView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            quizView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            quizView.topAnchor.constraint(equalTo: view.topAnchor),
            quizView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            quizView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

