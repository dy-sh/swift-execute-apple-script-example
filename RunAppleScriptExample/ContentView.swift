import SwiftUI
import AppKit
import Foundation
import Cocoa



class AppleScriptManager {
    static func runScript(named scriptName: String) {
        if let scriptPath = Bundle.main.path(forResource: scriptName, ofType: "scpt") {
            let scriptURL = URL(fileURLWithPath: scriptPath)
            do {
                let script = try String(contentsOf: scriptURL, encoding: .utf8)
                var error: NSDictionary?
                if let appleScript = NSAppleScript(source: script) {
                    appleScript.executeAndReturnError(&error)
                    if let error = error {
                        print("Error: \(error)")
                    }
                }
            } catch {
                print("Error loading script: \(error)")
            }
        } else {
            print("Script not found")
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, SwiftUI!")
            Button("Run AppleScript") {
                AppleScriptManager.runScript(named: "MyScript")
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
