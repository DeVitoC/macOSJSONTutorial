//
//  ModelController.swift
//  JSONTutorial
//
//  Created by Christopher Devito on 8/6/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class ModelController {
    var models: [Model] = []
    let fm = FileManager.default
    lazy var path: URL = {
        let path = fm.urls(for: .desktopDirectory, in: .userDomainMask)[0]
        return path
    }()
    let filename = "modelExample.json"

    func fetchFromJSONFile() {
        let jsonDecoder = JSONDecoder()

        // Get JSON and decode it
        guard let jsonData = NSData(contentsOfFile: path.appendingPathComponent(filename).absoluteString) else { return }

        do {
            let data = Data(jsonData)
            models = try jsonDecoder.decode([Model].self, from: data)
        } catch let error {
            NSLog("\(error)")
        }
    }

    func appendToJSONFile(model: Model) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        guard let appendString = ",\n".data(using: .utf8)?.base64EncodedString(),
            let appendData = Data(base64Encoded: appendString),
            let closeString = "\n]".data(using: .utf8)?.base64EncodedString(),
            let closeData = Data(base64Encoded: closeString),
            let startString = "[\n...".data(using: .utf8)?.base64EncodedString(),
            let startData = Data(base64Encoded: startString) else { return }

        do {
            if fm.fileExists(atPath: path.appendingPathComponent(filename).absoluteString) {
                try startData.write(to: path.appendingPathComponent(filename))
            }
            let fileHandle = try FileHandle(forWritingTo: path.appendingPathComponent(filename))
            let data = try jsonEncoder.encode(model)
            let attr = try fm.attributesOfItem(atPath: path.appendingPathComponent(filename).absoluteString)
            let fileSize = attr[FileAttributeKey.size] as! UInt64
            let offset = fileSize - 3
            try fileHandle.seek(toOffset: offset)
            fileHandle.write(appendData)
            fileHandle.write(data)
            fileHandle.write(closeData)
            fileHandle.closeFile()
        } catch let error {
            NSLog("\(error)")
        }
    }
}
