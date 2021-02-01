//
//  ViewController.swift
//  HelloCoreData
//
//  Created by ido on 2021/02/01.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var dataArray = [Hello]()
    
    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    static let appDelgate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelgate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let entity = NSEntityDescription.entity(forEntityName: "Hello", in: context)
    }
    
    @IBAction func saveData(_ sender: UIButton) {
        let newData = Hello(context: self.context)
        newData.country = textField1.text
        newData.name = textField2.text
        dataArray.append(newData)
        self.save()
    }
    
    @IBAction func loadData(_ sender: UIButton) {
        load()
    }
    
    @IBAction func resetData(_ sender: UIButton) {
        reset()
    }
    
    
    func save() {
        do {
            try context.save()
            print("Succes save data")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func load() {
        do {
            dataArray = try context.fetch(Hello.fetchRequest())
            dataArray.forEach {
                print("\($0.name!): Hello \($0.country!)!")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func reset() {
        for data in dataArray {
            context.delete(data)
        }
        save()
    }
    
}


