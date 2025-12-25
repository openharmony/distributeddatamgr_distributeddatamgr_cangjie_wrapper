/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.data.distributed_kv_store

import std.sync.Mutex
import ohos.labels.{APILevel, Hide}
import std.collection.ArrayList
import ohos.ffi.{releaseFFIData, RemoteDataLite, SUCCESS_CODE, toArrayCString}
import ohos.business_exception.BusinessException
import ohos.callback_invoke.CallbackObject
import ohos.data.data_share_predicates.DataSharePredicates
import std.collection.HashMap
import ohos.callback_invoke.{ Callback1Argument, CallbackObject }

class SingleKVStoreFinalizer {
    SingleKVStoreFinalizer(let id: Int64) {}
    ~init() {
        releaseFFIData(id)
    }
}

class SingleKVStoreImpl {}

/**
 * Provides methods related to single-version distributed databases.
 * To create a SingleKVStore database,
 * you can use the getKVStore​(KVOptions, String) method
 * with KVStoreType set to SingleVersion for the input parameter KVOptions.
 * This database synchronizes data to other databases in time sequence.
 * The SingleKVStore database does not support
 * synchronous transactions, or data search using snapshots.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
]
public open class SingleKVStore <: RemoteDataLite {
    private let callbackList_d = ArrayList<(CallbackObject, Int64)>()
    private let callbackList_s = ArrayList<(CallbackObject, Int64)>()
    private let onOffMutex = Mutex()
    private let finalizer: SingleKVStoreFinalizer
    private let impl: SingleKVStoreImpl = SingleKVStoreImpl()

    init(id: Int64) {
        super(id)
        finalizer = SingleKVStoreFinalizer(id)
    }

    static func getKVStore(id: Int64, storeId: String, options: KVOptions): SingleKVStore {
        SingleKVStore(KVManager.getKVStoreId(id, storeId, options, SingleVersion))
    }

    /**
     * Writes a key-value pair of the string type into the SingleKVStore database.
     * If you do not want to synchronize this key-value pair to other devices, set the write option in the local
     * database.
     *
     * @param { String } key - Indicates the key. Length must be less than MAX_KEY_LENGTH.
     * Spaces before and after the key will be cleared.
     * @param { KVValueType } value - Indicates the value to be inserted.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     * @throws { BusinessException } 14800047 - The WAL file size exceeds the default limit.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core",
        throwexception: true,
        workerthread: true
    ]
    public open func put(key: String, value: KVValueType): Unit {
        unsafe {
            try (
                cKey = LibC.mallocCString(key).asResource(),
                cValue = CKVValueType(value).asResource()
            ) {
                let errCode = FfiOHOSDistributedKVStoreSingleKVStorePut(getID(), cKey.value, cValue.value)
                if (errCode != SUCCESS_CODE) {
                    KV_STORE_LOG.info("Failed to put. code: ${errCode}")
                    throw BusinessException(getErrorCode(errCode), "KVStore put failed: ${getErrorMsg(errCode)}")
                }
            }
        }
    }

    /**
     * Inserts key-value pairs into the SingleKVStore database in batches.
     *
     * @param { Array<Entry> } entries - Indicates the key-value pairs to be inserted in batches.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     * @throws { BusinessException } 14800047 - The WAL file size exceeds the default limit.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core",
        throwexception: true,
        workerthread: true
    ]
    public open func putBatch(entries: Array<Entry>): Unit {
        unsafe {
            let cArrEntry = CArrEntry(entries)
            let errCode = FfiOHOSDistributedKVStoreSingleKVStorePutBatch(getID(), cArrEntry)
            cArrEntry.free()
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to putBatch. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore putBatch failed: ${getErrorMsg(errCode)}")
            }
        }
    }

    @!Hide[isChecked: true]
    public open func putBatch(value: Array<HashMap<String, KVValueType>>): Unit {}

    /**
     * Deletes the key-value pair based on a specified key.
     *
     * @param { String } key - Indicates the key. Length must be less than MAX_KEY_LENGTH.
     * Spaces before and after the key will be cleared.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     * @throws { BusinessException } 14800047 - The WAL file size exceeds the default limit.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core",
        throwexception: true,
        workerthread: true
    ]
    public open func delete(key: String): Unit {
        unsafe {
            let cKey = LibC.mallocCString(key)
            let errCode = FfiOHOSDistributedKVStoreSingleKVStoreDelete(getID(), cKey)
            LibC.free(cKey)
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to delete. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore delete failed: ${getErrorMsg(errCode)}")
            }
        }
    }

    @!Hide[isChecked: true]
    public open func delete(predicates: DataSharePredicates): Unit {}

    /**
     * Deletes key-value pairs in batches from the SingleKVStore database.
     *
     * @param { Array<String> } keys - Indicates the key-value pairs to be deleted in batches, It can not be empty.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     * @throws { BusinessException } 14800047 - The WAL file size exceeds the default limit.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core",
        throwexception: true,
        workerthread: true
    ]
    public open func deleteBatch(keys: Array<String>): Unit {
        unsafe {
            let cArrString = toArrayCString(keys)
            let errCode = FfiOHOSDistributedKVStoreSingleKVStoreDeleteBatch(getID(), cArrString)
            cArrString.free()
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to deleteBatch. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore deleteBatch failed: ${getErrorMsg(errCode)}")
            }
        }
    }

    @!Hide[isChecked: true]
    public open func removeDeviceData(deviceId: String): Unit {}

    /**
     * Obtains the value of a specified key.
     *
     * @param { String } key - Indicates the key. The length must be less than MAX_KEY_LENGTH.
     * @returns { KVValueType } the returned value specified by the key.
     * {KVValueType}: the returned value specified by the key.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100004 - Not found.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core",
        throwexception: true,
        workerthread: true
    ]
    public open func get(key: String): KVValueType {
        unsafe {
            let cKey = LibC.mallocCString(key)
            var errCode: Int32 = 0
            let cValue = FfiOHOSDistributedKVStoreSingleKVStoreGet(getID(), cKey, inout errCode)
            LibC.free(cKey)
            let result = cValue.toValueType()
            cValue.free()
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to get. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore get failed: ${getErrorMsg(errCode)}")
            }
            return result
        }
    }

    @!Hide[isChecked: true]
    public open func getEntries(keyPrefix: String): Array<Entry> {
        throw Exception()
    }

    @!Hide[isChecked: true]
    public open func getEntries(query: Query): Array<Entry> {
        throw Exception()
    }

    @!Hide[isChecked: true]
    public open func getResultSet(keyPrefix: String): KVStoreResultSet {
        throw Exception()
    }

    @!Hide[isChecked: true]
    public open func getResultSet(query: Query): KVStoreResultSet {
        throw Exception()
    }

    @!Hide[isChecked: true]
    public open func getResultSet(predicates: DataSharePredicates): KVStoreResultSet {
        throw Exception()
    }

    @!Hide[isChecked: true]
    public open func closeResultSet(resultSet: KVStoreResultSet): Unit {}

    @!Hide[isChecked: true]
    public open func getResultSize(query: Query): Int32 {
        throw Exception()
    }

    /**
     * Backs up a database in the specified filename.
     *
     * @param { String } file - Indicates the database backup filename, It can not be empty and
     * The length must be less than MAX_KEY_LENGTH.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core",
        throwexception: true,
        workerthread: true
    ]
    public open func backup(file: String): Unit {
        unsafe {
            let cFile = LibC.mallocCString(file)
            let errCode = FfiOHOSDistributedKVStoreSingleKVStoreBackup(getID(), cFile)
            LibC.free(cFile)
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to backup. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore backup failed: ${getErrorMsg(errCode)}")
            }
        }
    }

    /**
     * Restores a database from a specified database file.
     *
     * @param { String } file - Indicates the database backup filename, It can not be empty and
     * The length must be less than MAX_KEY_LENGTH.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core",
        throwexception: true,
        workerthread: true
    ]
    public open func restore(file: String): Unit {
        unsafe {
            let cFile = LibC.mallocCString(file)
            let errCode = FfiOHOSDistributedKVStoreSingleKVStoreRestore(getID(), cFile)
            LibC.free(cFile)
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to restore. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore restore failed: ${getErrorMsg(errCode)}")
            }
        }
    }

    @!Hide[isChecked: true]
    public open func deleteBackup(files: Array<String>): Array<(String, Int32)> {
        throw Exception()
    }

    /**
     * Starts a transaction operation in the SingleKVStore database.
     * After the database transaction is started, you can submit or roll back the operation.
     *
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     * @throws { BusinessException } 14800047 - The WAL file size exceeds the default limit.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core",
        throwexception: true,
        workerthread: true
    ]
    public open func startTransaction(): Unit {
        unsafe {
            let errCode = FfiOHOSDistributedKVStoreSingleKVStoreStartTransaction(getID())
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to startTransaction. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode),
                    "KVStore startTransaction failed: ${getErrorMsg(errCode)}")
            }
        }
    }

    /**
     * Submits a transaction operation in the SingleKVStore database.
     *
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core",
        throwexception: true,
        workerthread: true
    ]
    public open func commit(): Unit {
        unsafe {
            let errCode = FfiOHOSDistributedKVStoreSingleKVStoreCommit(getID())
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to commit. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore commit failed: ${getErrorMsg(errCode)}")
            }
        }
    }

    /**
     * Rolls back a transaction operation in the SingleKVStore database.
     *
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core",
        throwexception: true,
        workerthread: true
    ]
    public open func rollback(): Unit {
        unsafe {
            let errCode = FfiOHOSDistributedKVStoreSingleKVStoreRollback(getID())
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to rollback. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore rollback failed: ${getErrorMsg(errCode)}")
            }
        }
    }

    /**
     * Sets whether to enable synchronization.
     *
     * @param { Bool } enabled - Specifies whether to enable synchronization. The value true
     * means to enable synchronization, and false means the opposite.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core",
        workerthread: true
    ]
    public open func enableSync(enabled: Bool): Unit {
        unsafe {
            let errCode = FfiOHOSDistributedKVStoreSingleKVStoreEnableSync(getID(), enabled)
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to enableSync. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore enableSync failed: ${getErrorMsg(errCode)}")
            }
        }
    }

    @!Hide[isChecked: true]
    public open func setSyncRange(localLabels: Array<String>, remoteSupportLabels: Array<String>): Unit {}

    /**
     * Sets the default delay allowed for database synchronization.
     *
     * @param { UInt32 } defaultAllowedDelayMs - Indicates the default delay allowed for the
     * database synchronization, in milliseconds.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core",
        workerthread: true
    ]
    public open func setSyncParam(defaultAllowedDelayMs: UInt32): Unit {
        unsafe {
            let errCode = FfiOHOSDistributedKVStoreSingleKVStoreSetSyncParam(getID(), defaultAllowedDelayMs)
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to setSyncParam. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore setSyncParam failed: ${getErrorMsg(errCode)}")
            }
        }
    }

    @!Hide[isChecked: true]
    public open func sync(deviceIds: Array<String>, mode: SyncMode): Unit {}

    @!Hide[isChecked: true]
    public open func sync(deviceIds: Array<String>, mode: SyncMode, delayMs: Int32): Unit {}

    @!Hide[isChecked: true]
    public open func sync(deviceIds: Array<String>, query: Query, mode: SyncMode): Unit {}

    @!Hide[isChecked: true]
    public open func sync(deviceIds: Array<String>, query: Query, mode: SyncMode, delayMs: Int32): Unit {}

    @!Hide[isChecked: true]
    public open func on(event: KVStoreEvent, `type`: SubscribeType, listener: Callback1Argument<ChangeNotification>): Unit {}

    @!Hide[isChecked: true]
    public open func on(event: KVStoreEvent, syncCallback: Callback1Argument<Array<(String, Int32)>>): Unit {}

    @!Hide[isChecked: true]
    public open func off(event: KVStoreEvent, listener: CallbackObject): Unit {}

    @!Hide[isChecked: true]
    public open func off(event: KVStoreEvent): Unit {}

    @!Hide[isChecked: true]
    public open func getSecurityLevel(): KVSecurityLevel {
        throw Exception()
    }
}

@!Hide[isChecked: true]
public enum KVStoreEvent {
    @!Hide[isChecked: true]
    DataChange
    |
    @!Hide[isChecked: true]
    SyncComplete
    | ...
}

@!Hide[isChecked: true]
public enum SyncMode {
    @!Hide[isChecked: true]
    PullOnly
    |
    @!Hide[isChecked: true]
    PushOnly
    |
    @!Hide[isChecked: true]
    PushPull
    | ...
}

@!Hide[isChecked: true]
public enum SubscribeType {
    @!Hide[isChecked: true]
    SubscribeTypeLocal
    |
    @!Hide[isChecked: true]
    SubscribeTypeRemote
    |
    @!Hide[isChecked: true]
    SubscribeTypeAll
    | ...
}

@!Hide[isChecked: true]
public class ChangeNotification {
    init() {}
}