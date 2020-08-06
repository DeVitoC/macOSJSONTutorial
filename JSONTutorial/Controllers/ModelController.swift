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
//    let bundle = Bundle.main
//    lazy var path1 = bundle.path(forResource: "modelExample", ofType: "json")!
    let filename = "modelExample.json"

    func fetchFromJSONFile() {
        let jsonDecoder = JSONDecoder()

        // Get JSON and decode it
//        guard let jsonData = NSData(contentsOfFile: path.appendingPathComponent(filename).absoluteString) else { return }
        guard let jsonData = NSData(contentsOfFile: path.appendingPathComponent(filename).path) else { return }


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
            let startString = "[\n".data(using: .utf8)?.base64EncodedString(),
            let startData = Data(base64Encoded: startString) else { return }

        do {
            let data = try jsonEncoder.encode(model)
            let fileHandle: FileHandle
            if !fm.fileExists(atPath: path.appendingPathComponent(filename).path) {
                try startData.write(to: path.appendingPathComponent(filename))
                fileHandle = try FileHandle(forWritingTo: path.appendingPathComponent(filename))
                try fileHandle.seekToEnd()
            } else {
                fileHandle = try FileHandle(forWritingTo: path.appendingPathComponent(filename))
                let attr = try fm.attributesOfItem(atPath: path.appendingPathComponent(filename).path)
                let fileSize = attr[FileAttributeKey.size] as! UInt64
                let offset = fileSize - 2
                try fileHandle.seek(toOffset: offset)
                fileHandle.write(appendData)
            }
            fileHandle.write(data)
            fileHandle.write(closeData)
            fileHandle.closeFile()
        } catch let error {
            NSLog("\(error)")
        }
    }
}
