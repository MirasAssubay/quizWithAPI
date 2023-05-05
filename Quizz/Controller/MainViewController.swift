//
//  MainViewController.swift
//  Quizz
//
//  Created by Мирас Асубай on 12.04.2023.
//

import UIKit

class MainViewController: UIViewController {
    var myCollectionView: UICollectionView?
    var categories: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        categories = fetchData()
        title = "Choose Category"
    }
    

    func setupView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 180, height: 170)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        
        myCollectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        myCollectionView?.backgroundColor = UIColor.white
        
        view.addSubview(myCollectionView ?? UICollectionView())
        
        self.view = view
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }

        let category = categories[indexPath.row]
        cell.set(category: category)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            let vc = ViewController()
            vc.categoryId = self?.categories[indexPath.row].id ?? "31"
            vc.category = self?.categories[indexPath.row].name ?? "Anime"
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}



extension MainViewController {
    func fetchData() -> [Category] {
        let animeCategory = Category(image: Images.anime, name: "Anime", id: "31")
        let bookCategory = Category(image: Images.book, name: "Book", id: "10")
        let filmCategory = Category(image: Images.film, name: "Film", id: "11")
        let musicCategory = Category(image: Images.music, name: "Music", id: "12")
        let gamesCategory = Category(image: Images.videoGames, name: "Video Games", id: "15")
        let generalCategory = Category(image: Images.general, name: "General Knowledge", id: "9")
        
        return [animeCategory, bookCategory, filmCategory, musicCategory, gamesCategory, generalCategory]
    }
}
