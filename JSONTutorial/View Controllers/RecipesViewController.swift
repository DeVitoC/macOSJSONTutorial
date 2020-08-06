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
    override var representedObject: Any? {
        didSet {
            modelController?.fetchFromJSONFile()
            reloadFileList()
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var tableView: NSTableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        modelController?.fetchFromJSONFile()
        reloadFileList()
    }

    func reloadFileList() {
        tableView.reloadData()
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
        guard let item = modelController?.models[row] else { return nil }
        var cellIdentifier: String = ""
        var text: String = ""

        if tableColumn == tableView.tableColumns[0] {
            text = item.name
            cellIdentifier = CellIdentifiers.RecipeCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = item.firstItem
            cellIdentifier = CellIdentifiers.FirstItemCell
        } else if tableColumn == tableView.tableColumns[2] {
            text = "\(item.firstAmount)"
            cellIdentifier = CellIdentifiers.FirstAmountCell
        } else if tableColumn == tableView.tableColumns[3] {
            text = item.secondItem
            cellIdentifier = CellIdentifiers.SecondItemCell
        } else if tableColumn == tableView.tableColumns[4] {
            text = "\(item.secondAmount)"
            cellIdentifier = CellIdentifiers.SecondAmountCell
        }

        let cellIdentifier2 = NSUserInterfaceItemIdentifier(cellIdentifier)

        if let cell = tableView.makeView(withIdentifier: cellIdentifier2, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
}
