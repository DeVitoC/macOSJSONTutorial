//
//  RecipesViewController.swift
//  JSONTutorial
//
//  Created by Christopher Devito on 8/6/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Cocoa

class RecipesViewController: NSViewController {

    // MARK: - Properties
    var modelController: ModelController?

    // MARK: - Outlets
    @IBOutlet weak var tableView: NSTableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

extension RecipesViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return modelController?.models.count ?? 0
    }
}

extension RecipesViewController: NSTableViewDelegate {
    enum CellIdentifiers {
        static let RecipeCell = "RecipeCellID"
        static let FirstItemCell = "FirstItemCellID"
        static let FirstAmountCell = "FirstAmountCellID"
        static let SecondItemCell = "SecondItemCellID"
        static let SecondAmountCell = "SecondAmountCellID"
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

        return NSView()
    }
}
