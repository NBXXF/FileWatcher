import Cocoa
import FileWatcher_macOS

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet var window: NSWindow!
    func applicationDidFinishLaunching(_: Notification) {
        let filewatcher = FileWatcher([NSString(string: "~/Desktop").expandingTildeInPath])
        filewatcher.callback = { (event: FileWatcherEvent) in
            print("Something happened here: \(event.path)")
            Swift.print("event.description:  \(event.description)")
            if !FileManager().fileExists(atPath: event.path) { Swift.print("was deleted") }
            Swift.print("event.flags:  \(event.flags)")
        }
        filewatcher.start() // start monitoring
    }

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }
}
