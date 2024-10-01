//
//  ViewController.swift
//  To Do List
//
//  Created by Гидаят Джанаева on 02.09.2024.
//

import UIKit
import CoreData

class ListView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(semiCircleView, helloLabel, beeImage, categoryCollectionView, createNewBtn)
        
        setupConstraints()
        loadCategories()
    }
    
//    var categories = [("Day", "0 tasks", UIImage(named: "dayIcon")),
//                 ("Personal", "0 tasks", UIImage(named: "personalIcon")),
//                 ("Work", "0 tasks", UIImage(named: "workIcon")),
//                 ("Shopping", "0 tasks", UIImage(named: "shoppingIcon"))
//                  ]

    var categories: [Category] = []
    
    private func loadCategories() {
        let context = CoreManager.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(fetchRequest)
            categoryCollectionView.reloadData()
        } catch {
            print("Failed to fetch categories: \(error)")
        }
    }
    
    lazy var semiCircleView = SemiCircleView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
    
    lazy var helloLabel: UILabel = {
        $0.text = "Hello, \nName"
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 34, weight: .light)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
     let beeImage: UIImageView = {
        $0.image = .bee
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UIImageView())
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var createNewBtn: UIButton = {
        $0.setTitle("Create new", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        
        return $0
    }(UIButton(type: .system))
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            helloLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 96),
            
            beeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            beeImage.centerYAnchor.constraint(equalTo: helloLabel.centerYAnchor),
            beeImage.heightAnchor.constraint(equalToConstant: 73),
            beeImage.widthAnchor.constraint(equalToConstant: 69),
            
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 222),
            categoryCollectionView.bottomAnchor.constraint(equalTo: createNewBtn.topAnchor, constant: -40),
            
            createNewBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createNewBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -69),
            createNewBtn.heightAnchor.constraint(equalToConstant: 30),
            createNewBtn.widthAnchor.constraint(equalToConstant: 150)
            
        ])
    }
    

}


extension ListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = categories[indexPath.row]
//        let taskCount = (category.tasks?.count ?? 0) as Int
        cell.configure(title: category.name ?? "", subtitle: "\(0) tasks", icon: UIImage(named: category.icon ?? ""))
        return cell
    }
    
}

extension ListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return CGSize(width: width, height: 100)
    }
}

extension ListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let category = categories[indexPath.row]
        let tasksVC = TaskView()
        tasksVC.category = category
        tasksVC.categoryName = category.name
        tasksVC.categoryIcon = UIImage(named: category.icon ?? "")
        navigationController?.pushViewController(tasksVC, animated: true)
    }
}



