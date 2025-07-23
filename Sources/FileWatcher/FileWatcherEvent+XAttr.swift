//
//  FileWatcherEvent+XAttr.swift
//  FileWatcher
//
//  Created by xxf on 2025/7/23.
//

import Foundation

public extension FileWatcherEvent {
    /// 扩展属性变化（如标签）
    var xattrChange: Bool {
        (flags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemXattrMod)) != 0
    }
}
