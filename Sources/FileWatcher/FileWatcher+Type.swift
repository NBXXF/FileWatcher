import Cocoa
/**
 * Callback signature
 */
public extension FileWatcher {
    typealias CallBack = (_ fileWatcherEvent: FileWatcherEvent) -> Void
}
