//
//  FileManagerModel.swift
//  Photo Manager
//
//  Created by Thitiwat Buatip on 30/11/2565 BE.
//

import Foundation
import AppKit

class FileManagerModel {
    static let share : FileManagerModel = FileManagerModel()
    
    func openFinder() {
        let dialog = NSOpenPanel();

        dialog.title                   = "Choose an image | Our Code World";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.allowsMultipleSelection = false;
        dialog.canChooseFiles = false;
        dialog.canChooseDirectories = true;
        //dialog.allowedFileTypes        = ["png", "jpg", "jpeg", "gif"];

        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file

            if (result != nil) {
                let path: String = result!.path
                
                Gobal.foloderPath = path
                // path contains the file path e.g
                // /Users/ourcodeworld/Desktop/tiger.jpeg
                let fileManager = FileManager.default
                guard let documentsURL = URL(string: path) else { return }
                do {
                    let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
                    // process files
                    Gobal.selectFile.removeAll()
                    for item in fileURLs {
                        Gobal.selectFile.append(item.absoluteString)
                    }
                    
                    NotificationCenter.default.post(name: NSNotification.Name("InsertFile"), object: nil)
                    
                } catch {
                    print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
                }
            }
            
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    func browseFoloder() -> String {
        let dialog = NSOpenPanel();

        dialog.title                   = "Choose an foloder";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.allowsMultipleSelection = false;
        dialog.canChooseFiles = false;
        dialog.canChooseDirectories = true;
        
        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file

            if (result != nil) {
                let path: String = result!.path
                
                // path contains the file path e.g
                // /Users/ourcodeworld/Desktop/tiger.jpeg
                return path
            }
            else {
                return ""
            }
            
        } else {
            // User clicked on "Cancel"
            return ""
        }
    }
    
    func secureCopyItem(at srcURL: URL, to dstURL: URL) -> (Bool, Error?) {
            do {
                if FileManager.default.fileExists(atPath: dstURL.path) {
                    try FileManager.default.removeItem(at: dstURL)
                }
                try FileManager.default.copyItem(at: srcURL, to: dstURL)
            } catch (let error) {
                print("Cannot copy item at \(srcURL) to \(dstURL): \(error)")
                return (false, error)
            }
            return (true, nil)
        }
}
