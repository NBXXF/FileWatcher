//
//  FileWatcherEvent+Flags.swift
//  FileWatcher
//
//  Created by xxf on 2025/7/23.
//
import Foundation

/**
 * The following code is to differentiate between the FSEvent flag types (aka file event types)
 * - Remark: Be aware that .DS_STORE changes frequently when other files change
 */
public extension FileWatcherEvent {
    // MARK: - General Flags

    /// 是否是一个“文件”的变更事件（ItemIsFile 标志位）
    /// - Note: 该标志只表示事件的对象是一个文件，不代表文件内容是否真的变化
    /// - Example: 创建、删除、重命名一个文件时该标志为 true
    var fileChange: Bool {
        (flags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemIsFile)) != 0
    }

    /// 是否是一个“目录”的变更事件（ItemIsDir 标志位）
    /// - Note: 表示事件的对象是一个目录
    /// - Example: 创建、删除、重命名目录时该标志为 true
    var dirChange: Bool {
        (flags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemIsDir)) != 0
    }

    // MARK: - CRUD Flags

    /// 是否是“创建”事件（ItemCreated 标志位）
    /// - Applicable to: 文件或目录
    /// - Example: 创建文件或目录时为 true
    var created: Bool {
        (flags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemCreated)) != 0
    }

    /// 是否是“删除”事件（ItemRemoved 标志位）
    /// - Applicable to: 文件或目录
    /// - Example: 删除文件或目录时为 true
    var removed: Bool {
        (flags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemRemoved)) != 0
    }

    /// 是否是“重命名”事件（ItemRenamed 标志位）,注意移动也是这个事件
    /// - Applicable to: 文件或目录
    /// - Example: 文件重命名、目录更名时为 true
    var renamed: Bool {
        (flags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemRenamed)) != 0
    }

    /// 是否是“修改”事件（ItemModified 标志位）
    /// - Applicable to: 文件或目录（更常用于文件内容修改）
    /// - Example: 文件内容写入、目录结构发生变化（如新增子项）可能触发该标志
    var modified: Bool {
        (flags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemModified)) != 0
    }
}

/**
 * Convenince
 */
/**
 * Convenience 分类（更具体化的文件 / 目录操作判断）
 */
public extension FileWatcherEvent {
    // MARK: - File-Specific Events

    /// 文件创建事件（是文件 && 是创建）
    /// - Example: 新建 txt、png、doc 文件等
    var fileCreated: Bool { fileChange && created }

    /// 文件删除事件（是文件 && 是删除）
    /// - Example: 删除任意文件（移至废纸篓或永久删除）
    var fileRemoved: Bool { fileChange && removed }

    /// 文件重命名事件（是文件 && 是重命名）
    /// - Example: 将“1.txt”改为“2.txt”
    var fileRenamed: Bool { fileChange && renamed }

    /// 文件修改事件（是文件 && 是修改）
    /// - Example: 编辑 txt 文件内容，保存后触发
    var fileModified: Bool { fileChange && modified }

    // MARK: - Directory-Specific Events

    /// 目录创建事件（是目录 && 是创建）
    /// - Example: 新建文件夹
    var dirCreated: Bool { dirChange && created }

    /// 目录删除事件（是目录 && 是删除）
    /// - Example: 删除文件夹
    var dirRemoved: Bool { dirChange && removed }

    /// 目录重命名事件（是目录 && 是重命名）
    /// - Example: 修改文件夹名称
    var dirRenamed: Bool { dirChange && renamed }

    /// 目录修改事件（是目录 && 是修改）
    /// - Example: 在目录内新增或删除子文件可能触发此标志
    var dirModified: Bool { dirChange && modified }
}

/**
 * Simplifies debugging
 * ## Examples:
 * Swift.print(event.description) // Outputs: The file /Users/John/Desktop/test/text.txt was modified
 */
public extension FileWatcherEvent {
    var description: String {
        var result = "The \(fileChange ? "file" : "directory") \(path) was"
        if removed { result += " removed" }
        else if created { result += " created" }
        else if renamed { result += " renamed" }
        else if modified { result += " modified" }
        return result
    }
}
