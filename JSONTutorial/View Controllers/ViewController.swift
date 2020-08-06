//
//  ViewController.swift
//  JSONTutorial
//
//  Created by Christopher Devito on 8/6/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    // MARK: - Properties
    override var representedObject: Any? { didSet {} }
    let modelController = ModelController()

    // MARK: - Outlets
    @IBOutlet weak var recipeNameTextField: NSTextField!
    @IBOutlet weak var firstItemTextField: NSTextField!
    @IBOutlet weak var secondItemTextField: NSTextField!
    @IBOutlet weak var firstAmountTextField: NSTextField!
    @IBOutlet weak var secondAmountTextField: NSTextField!

    // MARK: - View methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions
    @IBAction func addRecipeTapped(_ sender: Any) {
        let name = recipeNameTextField.stringValue
        let firstItem = firstItemTextField.stringValue
        let firstAmount = firstAmountTextField.intValue
        let secondItem = secondItemTextField.stringValue
        let secondAmount = secondAmountTextField.intValue
        guard !name.isEmpty, !firstItem.isEmpty, !secondItem.isEmpty, firstAmount > 0, firstAmount <= 9, secondAmount < 9 else { return }

        let model = Model(name: name, firstItem: firstItem, firstAmount: Int(firstAmount), secondItem: secondItem, secondAmount: Int(secondAmount))
        modelController.appendToJSONFile(model: model)
        recipeNameTextField.stringValue = ""
        firstItemTextField.stringValue = ""
        firstAmountTextField.stringValue = ""
        secondItemTextField.stringValue = ""
        secondAmountTextField.stringValue = ""
    }

    // MARK: - Navigation
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let recipesVC = segue.destinationController as? RecipesViewController {
            recipesVC.modelController = modelController
            modelController.fetchFromJSONFile()
        }
    }


}

