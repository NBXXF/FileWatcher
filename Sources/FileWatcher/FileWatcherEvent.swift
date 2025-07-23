import Foundation

/**
 * - Parameters:
 *    - id: is an id number that the os uses to differentiate between events.
 *    - path: is the path the change took place. its formated like so: Users/John/Desktop/test/text.txt
 *    - flag: pertains to the file event type.
 * ## Examples:
 * let url = NSURL(fileURLWithPath: event.path)//<--formats paths to: file:///Users/John/Desktop/test/text.txt
 * Swift.print("fileWatcherEvent.fileChange: " + "\(event.fileChange)")
 * Swift.print("fileWatcherEvent.fileModified: " + "\(event.fileModified)")
 * Swift.print("\t eventId: \(event.id) - eventFlags:  \(event.flags) - eventPath:  \(event.path)")
 */
public class FileWatcherEvent {
    public var id: FSEventStreamEventId
    public var path: String
    public var flags: FSEventStreamEventFlags
    init(_ eventId: FSEventStreamEventId, _ eventPath: String, _ eventFlags: FSEventStreamEventFlags) {
        id = eventId
        path = eventPath
        flags = eventFlags
    }
}
