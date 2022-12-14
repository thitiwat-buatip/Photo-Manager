//
//  ViewController.swift
//  Photo Manager
//
//  Created by Thitiwat Buatip on 12/1/2565 BE.
//

import Cocoa

class ViewController: NSViewController {
    
    
    @IBOutlet var listFileTxt: NSTextView!
    @IBOutlet weak var fileTypeTxt: NSTextField!
    @IBOutlet weak var foloderPathLabel: NSTextField!
    @IBOutlet weak var originFolorPathLabel: NSTextField!
    @IBOutlet weak var destinationFoloderPath: NSTextField!
    @IBOutlet weak var prefixTxt: NSTextField!
    
    let fileType = ["All Image", "JPEG , JPG", "PNG", "RAW", "GIF", "TIFF", "PSD", "SVG", "อื่น ๆ"]
    
    var destinationPath : String = ""
    var originPath : String = ""
    
    private var selectType : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(insertSelectFile), name: NSNotification.Name("InsertFile"), object: nil)
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @objc private func insertSelectFile() {
        foloderPathLabel.stringValue = Gobal.foloderPath
        for item in Gobal.selectFile {
            listFileTxt.insertText(item, replacementRange: listFileTxt.selectedRange())
            listFileTxt.insertNewline(nil)
        }
    }
    @IBAction func browsOrigin(_ sender: Any) {
        originPath = FileManagerModel.share.browseFoloder()
        originFolorPathLabel.stringValue = originPath
    }
    @IBAction func browseDestination(_ sender: Any) {
        destinationPath = FileManagerModel.share.browseFoloder()
        destinationFoloderPath.stringValue = destinationPath
    }
    
    @IBAction func openTextFile(_ sender: Any) {
//        guard let textFile = FileManagerModel.share.openFileTxt() else { return }
//        listFileTxt.insertText(textFile, replacementRange: listFileTxt.selectedRange())
    }
    @IBAction func exportTextFile(_ sender: Any) {
        //FileManagerModel.share.saveDocument(textString: listFileTxt.string)
    }
    @IBAction func openFile(_ sender: Any) {
        FileManagerModel.share.openFinder()
    }
    @IBAction func clearSelectFile(_ sender: Any) {
        listFileTxt.string = ""
    }
    
    @IBAction func copyFile(_ sender: Any) {
        var errorString : String = ""
        
        let componnentFile = listFileTxt.string.components(separatedBy: "\n")
        for item in componnentFile {
            if item != "" {
                let openPath : String =  originPath + prefixTxt.stringValue  + item + "." + fileTypeTxt.stringValue
                
                let componentPath : [String] = item.components(separatedBy: "/")
                let itemPath = "\(componentPath.last ?? item)"
                
                let newPath : String = destinationPath + prefixTxt.stringValue + itemPath + "." + fileTypeTxt.stringValue
                if let openPathUrl = URL(string: openPath) , let destinationPathUrl = URL(string: newPath) {
                    let (status, error) = FileManagerModel.share.secureCopyItem(at: openPathUrl, to: destinationPathUrl)
                    if status == false {
                        errorString = errorString + "\(error)\n"
                    }
                    print("Copy : \(status)")
                }
            }
        }
        
        let alert: NSAlert = NSAlert()
        alert.messageText = "การคัดลอกเสร็จสิ้น"
        alert.informativeText = errorString
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}
