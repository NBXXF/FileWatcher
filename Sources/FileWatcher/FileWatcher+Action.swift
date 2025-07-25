import Cocoa

/**
 * Actions
 */
public extension FileWatcher {
    /**
     * Start listening for FSEvents
     */
    func start() {
        guard !hasStarted else { return } // -- make sure we are not already listening!
        var context = FSEventStreamContext(
            version: 0,
            info: Unmanaged.passUnretained(self).toOpaque(),
            retain: retainCallback,
            release: releaseCallback,
            copyDescription: nil
        )
        streamRef = FSEventStreamCreate(
            kCFAllocatorDefault,
            eventCallback,
            &context,
            filePaths as CFArray,
            FSEventStreamEventId(kFSEventStreamEventIdSinceNow),
            0,
            UInt32(kFSEventStreamCreateFlagUseCFTypes | kFSEventStreamCreateFlagFileEvents)
        )
        guard let streamRef = streamRef else {
            print("FSEventStreamCreate failed for paths: \(filePaths)")
            return
        }
        selectStreamScheduler()
        FSEventStreamStart(streamRef)
    }

    /**
     * Stop listening for FSEvents
     */
    func stop() {
        guard hasStarted else { return } // -- make sure we are indeed listening!
        FSEventStreamStop(streamRef!)
        FSEventStreamInvalidate(streamRef!)
        FSEventStreamRelease(streamRef!)
        streamRef = nil
    }
}
