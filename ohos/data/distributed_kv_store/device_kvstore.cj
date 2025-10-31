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

import ohos.labels.APILevel
import ohos.ffi.{releaseFFIData, SUCCESS_CODE}
import ohos.business_exception.BusinessException

/**
 * Provides methods related to device-collaboration distributed databases.
 * <p>To create a {@code DeviceKVStore} database, you can use the
 * {@link data.distributed.common.KVManager.getKVStore(KVOptions, String)}
 * method with {@code KVStoreType} set to {@code DeviceCollaboration} for the input parameter KVOptions.
 * This database manages distributed
 * data by device, and cannot modify data synchronized from remote devices. When an application writes a
 * key-value pair entry
 * into the database, the system automatically adds the ID of the device running the application to the key.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
]
public class DeviceKVStore <: SingleKVStore {
    init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    static func getKVStore(id: Int64, storeId: String, options: KVOptions): DeviceKVStore {
        DeviceKVStore(KVManager.getKVStoreId(id, storeId, options, DeviceCollaboration))
    }
    
    /**
     * Obtains the value matching the local device ID and specified key.
     *
     * @param { String } key - Indicates the key. The length must be less than {@code MAX_KEY_LENGTH}.
     * @returns { KVValueType } KVValueType - the returned value specified by the key.
     *
     * @throws { BusinessException } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameters types;
     * <br>3.Parameter verification failed.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100004 - Not found.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public func get(key: String): KVValueType {
        return get("", key)
    }

    /**
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100004 - Not found.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    func get(deviceId: String, key: String): KVValueType {
        unsafe {
            var result = KVValueType.Integer(0)
            try (
                cDeviceId = LibC.mallocCString(deviceId).asResource(),
                cKey = LibC.mallocCString(key).asResource()
            ) {
                var errCode: Int32 = 0
                let cValue = FfiOHOSDistributedKVStoreDeviceKVStoreGet(getID(), cDeviceId.value, cKey.value,
                    inout errCode)
                result = cValue.toValueType()
                cValue.free()
                if (errCode != SUCCESS_CODE) {
                    KV_STORE_LOG.info("Failed to get. code: ${errCode}")
                    throw BusinessException(getErrorCode(errCode), "KVStore get failed: ${getErrorMsg(errCode)}")
                }
            }
            return result
        }
    }

    /**
     * Obtains all key-value pairs that match the local device ID and specified key prefix.
     *
     * @param { String } keyPrefix - Indicates the key prefix to match.
     * @returns { Array<Entry> } Array<Entry> - the list of all key-value pairs that match the specified key prefix.
     * @throws { BusinessException } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameters types.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public func getEntries(keyPrefix: String): Array<Entry> {
        return getEntries("", keyPrefix)
    }

    /**
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    func getEntries(deviceId: String, keyPrefix: String): Array<Entry> {
        unsafe {
            var entries = Array<Entry>()
            try (
                cDeviceId = LibC.mallocCString(deviceId).asResource(),
                cKeyPrefix = LibC.mallocCString(keyPrefix).asResource()
            ) {
                var errCode: Int32 = 0
                let cEntries = FfiOHOSDistributedKVStoreDeviceKVStoreGetEntries(getID(), cDeviceId.value,
                    cKeyPrefix.value, inout errCode)
                entries = cEntries.toArray()
                cEntries.free()
                if (errCode != SUCCESS_CODE) {
                    KV_STORE_LOG.info("Failed to getEntries. code: ${errCode}")
                    throw BusinessException(getErrorCode(errCode), "KVStore getEntries failed: ${getErrorMsg(errCode)}")
                }
            }
            return entries
        }
    }

    /**
     * Obtains the list of key-value pairs matching the local device ID and specified {@code Query} object.
     *
     * @param { Query } query - Indicates the {@code Query} object.
     * @returns { Array<Entry> } Array<Entry> - the list of all key-value pairs matching the
     * specified {@code Query} object.
     * @throws { BusinessException } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameters types.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public func getEntries(query: Query): Array<Entry> {
        return getEntries("", query)
    }

    /**
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    func getEntries(deviceId: String, query: Query): Array<Entry> {
        unsafe {
            let cDeviceId = LibC.mallocCString(deviceId)
            var errCode: Int32 = 0
            let cEntries = FfiOHOSDistributedKVStoreDeviceKVStoreGetEntriesQuery(getID(), cDeviceId, query.getID(),
                inout errCode)
            LibC.free(cDeviceId)
            let entries = cEntries.toArray()
            cEntries.free()
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to getEntries. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore getEntries failed: ${getErrorMsg(errCode)}")
            }
            return entries
        }
    }

    /**
     * Obtains the result set with the local device ID and specified prefix from a {@code DeviceKVStore} database.
     * The {@code KVStoreResultSet} object can be used to query all key-value pairs that meet the search criteria.
     * Each {@code DeviceKVStore} instance can have a maximum of four {@code KVStoreResultSet} objects at the
     * same time.
     * If you have created four objects, calling this method will return a failure. Therefore, you are advised to
     * call the closeResultSet method to close unnecessary {@code KVStoreResultSet} objects in a timely manner.
     *
     * @param { String } keyPrefix - Indicates the key prefix to match.
     * @returns { KVStoreResultSet } KVStoreResultSet - the {@code KVStoreResultSet}
     * object matching the specified keyPrefix.
     * @throws { BusinessException } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameters types.
     * @throws { BusinessException } 15100001 - Over max limits.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public func getResultSet(keyPrefix: String): KVStoreResultSet {
        return getResultSet("", keyPrefix)
    }

    /**
     * @throws { BusinessException } 15100001 - Over max limits.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    func getResultSet(deviceId: String, keyPrefix: String): KVStoreResultSet {
        unsafe {
            var resultSetId = 0
            try (
                cDeviceId = LibC.mallocCString(deviceId).asResource(),
                cKeyPrefix = LibC.mallocCString(keyPrefix).asResource()
            ) {
                var errCode: Int32 = 0
                resultSetId = FfiOHOSDistributedKVStoreDeviceKVStoreGetResultSet(getID(), cDeviceId.value,
                    cKeyPrefix.value, inout errCode)
                if (errCode != SUCCESS_CODE) {
                    KV_STORE_LOG.info("Failed to getResultSet. code: ${errCode}")
                    throw BusinessException(getErrorCode(errCode),
                        "KVStore getResultSet failed: ${getErrorMsg(errCode)}")
                }
            }
            return KVStoreResultSet(resultSetId)
        }
    }

    /**
     * Obtains the {@code KVStoreResultSet} object matching the local device ID and specified {@code Query} object.
     *
     * @param { Query } query - Indicates the {@code Query} object.
     * @returns { KVStoreResultSet } KVStoreResultSet - the {@code KVStoreResultSet}
     * object matching the specified {@code Query} object.
     * @throws { BusinessException } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameters types.
     * @throws { BusinessException } 15100001 - Over max limits.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public func getResultSet(query: Query): KVStoreResultSet {
        return getResultSet("", query)
    }

    /**
     * @throws { BusinessException } 15100001 - Over max limits.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    func getResultSet(deviceId: String, query: Query): KVStoreResultSet {
        unsafe {
            let cDeviceId = LibC.mallocCString(deviceId)
            var errCode: Int32 = 0
            let resultSetId = FfiOHOSDistributedKVStoreDeviceKVStoreGetResultSetQuery(getID(), cDeviceId, query.getID(),
                inout errCode)
            LibC.free(cDeviceId)
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to getResultSet. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore getResultSet failed: ${getErrorMsg(errCode)}")
            }
            return KVStoreResultSet(resultSetId)
        }
    }

    /**
     * Obtains the number of results matching the local device ID and specified {@code Query} object.
     *
     * @param { Query } query - Indicates the {@code Query} object.
     * @returns { Int32 } Int32 - the number of results matching the specified {@code Query} object.
     * @throws { BusinessException } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameters types.
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public func getResultSize(query: Query): Int32 {
        return getResultSize("", query)
    }

    /**
     * @throws { BusinessException } 15100003 - Database corrupted.
     * @throws { BusinessException } 15100005 - Database or result set already closed.
     */
    func getResultSize(deviceId: String, query: Query): Int32 {
        unsafe {
            let cDeviceId = LibC.mallocCString(deviceId)
            var errCode: Int32 = 0
            let result = FfiOHOSDistributedKVStoreDeviceKVStoreGetResultSize(getID(), cDeviceId, query.getID(),
                inout errCode)
            LibC.free(cDeviceId)
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to getResultSize. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode), "KVStore getResultSize failed: ${getErrorMsg(errCode)}")
            }
            return result
        }
    }
}
