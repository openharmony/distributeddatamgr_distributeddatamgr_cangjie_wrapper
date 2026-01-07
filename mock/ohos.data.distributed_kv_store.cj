/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package ohos.data.distributed_kv_store

import ohos.app.ability.BaseContext
import ohos.business_exception.BusinessException
import ohos.labels.*

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
public class DeviceKVStore <: SingleKVStore {
    static func getKVStore(id: Int64, storeId: String, options: KVOptions): DeviceKVStore {
        DeviceKVStore()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public func get(key: String): KVValueType {
        return KVValueType.StringValue(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public func getEntries(keyPrefix: String): Array<Entry> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public func getEntries(query: Query): Array<Entry> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public func getResultSet(keyPrefix: String): KVStoreResultSet {
        return KVStoreResultSet()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public func getResultSet(query: Query): KVStoreResultSet {
        return KVStoreResultSet()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public func getResultSize(query: Query): Int32 {
        return 0
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
public class DistributedKVStore {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true]
    public static func createKVManager(config: KVManagerConfig): KVManager {
        return KVManager()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
public class KVManager {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public func getKVStore<T>(storeId: String, options: KVOptions): T where T <: SingleKVStore {
        let KVStore = match (T.getKVStore(0, storeId, options) as T) {
            case Some(v) => v
            case _ => throw BusinessException(15100002, "Open existed database with changed options.")
        }
        return KVStore
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public func closeKVStore(appId: String, storeId: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public func deleteKVStore(appId: String, storeId: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public func getAllKVStoreId(appId: String): Array<String> {
        return Array()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
public class Constants {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public static let MAX_KEY_LENGTH: Int32 = 1024

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public static let MAX_VALUE_LENGTH: Int32 = 4194303

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public static let MAX_KEY_LENGTH_DEVICE: Int32 = 896

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public static let MAX_STORE_ID_LENGTH: Int32 = 128

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public static let MAX_QUERY_LENGTH: Int32 = 512000

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public static let MAX_BATCH_SIZE: Int32 = 128
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
public enum KVValueType {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"] StringValue(String)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"] Integer(Int32)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"] Float(Float32)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"] ByteArray(Array<Byte>)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"] Boolean(Bool)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"] Double(Float64)
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
public class KVManagerConfig {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public var bundleName: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public var context: BaseContext

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public init(context: BaseContext, bundleName: String) {
        super()
        this.bundleName = String()
        this.context = context
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
public enum KVSecurityLevel {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    S1
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    S2
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    S3
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    S4
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
public class FieldNode {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
    public var default: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
    public var nullable: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
    public var nodeType: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
    public init(name: String, nullable: Bool, default: String, nodeType: Int32) {
        super()
        this.default = String()
        this.nullable = true
        this.nodeType = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
public class Schema {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
    public var root: FieldNode

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
    public var indexes: Array<String>

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
    public var mode: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
    public var skip: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
    public init(root: FieldNode, indexes: Array<String>, mode: Int32, skip: Int32) {
        super()
        this.root = FieldNode(
            String(),
            true,
            String(),
            0
        )
        this.indexes = Array()
        this.mode = 0
        this.skip = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
public class KVOptions {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public var createIfMissing: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public var encrypt: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public var backup: Bool

    @!APILevel[since: "22", permission: "ohos.permission.DISTRIBUTED_DATASYNC", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public var autoSync: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public var securityLevel: KVSecurityLevel

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"]
    public var schema: ?Schema

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public init(securityLevel: KVSecurityLevel, createIfMissing!: Bool = true, encrypt!: Bool = false,
        backup!: Bool = true, autoSync!: Bool = false, schema!: ?Schema = None) {
        super()
        this.createIfMissing = true
        this.encrypt = true
        this.backup = true
        this.autoSync = true
        this.securityLevel = KVSecurityLevel.S1
        this.schema = None
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
public class Entry {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public var key: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public var value: KVValueType

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public init(key: String, value: KVValueType) {
        super()
        this.key = String()
        this.value = KVValueType.StringValue(String())
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
public class KVStoreResultSet {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public func getCount(): Int32 {
        return 0
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
public class Query {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core"]
public open class SingleKVStore {
    static func getKVStore(id: Int64, storeId: String, options: KVOptions): SingleKVStore {
        SingleKVStore()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public open func put(key: String, value: KVValueType): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public open func putBatch(entries: Array<Entry>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public open func delete(key: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public open func deleteBatch(keys: Array<String>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public open func get(key: String): KVValueType {
        return KVValueType.StringValue(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public open func backup(file: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public open func restore(file: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public open func startTransaction(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public open func commit(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", throwexception: true, workerthread: true]
    public open func rollback(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", workerthread: true]
    public open func enableSync(enabled: Bool): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.KVStore.Core", workerthread: true]
    public open func setSyncParam(defaultAllowedDelayMs: UInt32): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}