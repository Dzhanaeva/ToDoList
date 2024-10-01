//
//  TaskView.swift
//  To Do List
//
//  Created by Гидаят Джанаева on 10.09.2024.
//

import UIKit
import CoreData

class TaskView: UIViewController, NSFetchedResultsControllerDelegate {
    
    var category: Category!
    
    var categoryName: String?
    var categoryIcon: UIImage?
    private let manager = CoreManager.shared
    
    private var currentTasks: [Tasks] = []
    private var fetchedResultsController: NSFetchedResultsController<Tasks>!
    lazy var semiCircleView = SemiCircleView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(semiCircleView, iconImageView, nameLabel, taskTableView, addButton)
        setupConstraints()
        setupFetchedResultsController()
     
 
        
        if let categoryName = categoryName {
            nameLabel.text = categoryName
        }
        
        if let categoryIcon = categoryIcon {
            iconImageView.image = categoryIcon
        }
    }

    private lazy var iconImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 78).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 78).isActive = true
        return $0
        
    }(UIImageView())
    
    
    private lazy var nameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 37, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UILabel())
    
    private lazy var taskTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        $0.dataSource = self
        $0.delegate = self
        
        return $0
    }(UITableView())
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .yellowBtn
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        button.layer.cornerRadius = 32
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func addButtonTapped() {
        showAddTaskAlert()
    }
    
    private func showAddTaskAlert() {
        let alert = UIAlertController(title: "New Task", message: "Enter task details", preferredStyle: .alert)
        
        alert.addTextField() { textField in
            textField.placeholder = "Title"
        }
        
        alert.addTextField() { textField in
            textField.placeholder = "Details"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
                guard let title = alert.textFields?.first?.text, !title.isEmpty,
                      let details = alert.textFields?[1].text else {return}
            self.manager.createTask(title: title, details: details, isCompleted: false, category: self.category)
            self.updateCurrentTasks()



        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    



    private func updateCurrentTasks() {
        if let fetchedObjects = fetchedResultsController.fetchedObjects {
            // Здесь мы фильтруем задачи по категории и обновляем currentTasks
            currentTasks = fetchedObjects.filter { $0.category == category }
            taskTableView.reloadData() // Обновляем таблицу
        }
    }
    private func setupFetchedResultsController() {
        let context = manager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)

        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self // Устанавливаем делегат

        do {
            try fetchedResultsController.performFetch()
//            taskTableView.reloadData() 
            updateCurrentTasks()
        } catch {
            print("Failed to fetch tasks: \(error)")
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateCurrentTasks() // Обновляем массив текущих задач при изменении данных
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            iconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            taskTableView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 17),
            taskTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            addButton.heightAnchor.constraint(equalToConstant: 66),
            addButton.widthAnchor.constraint(equalToConstant: 66)
        ])

    }
}

extension TaskView: UITableViewDelegate {
    
}

extension TaskView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task =  currentTasks[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = task.title
        config.secondaryText = task.details
//        cell.textLabel?.text = task.title
//        cell.accessoryType = .checkmark
        
        cell.contentConfiguration = config
        return cell
    }
    
    
}



//    private func loadTasks() {
//        let context = CoreManager.shared.persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
//
//        do {
//            currentTasks = try context.fetch(fetchRequest)
//            taskTableView.reloadData()
//        } catch {
//            print("Failed to fetch tasks: \(error)")
//        }
//
//        print("Current tasks count: \(currentTasks.count)")
//        for task in currentTasks {
//            print("Task title: \(task.title)")
//        }
//    }
