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

import ohos.app.ability.ui_ability.{UIAbilityContext, getStageContext}
import ohos.ffi.{RemoteDataLite, releaseFFIData, SUCCESS_CODE}
import ohos.hilog.HilogChannel
import ohos.labels.APILevel
import std.collection.ArrayList
import std.sync.Mutex
import ohos.callback_invoke.CallbackObject
import ohos.business_exception.BusinessException

let KV_STORE_LOG = HilogChannel(0, 0xD001650, "CJ-DistributedKVStore")

type StageContext = CPointer<Unit>

/**
 * Provider interfaces to create a {@link KVManager} instance.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
]
public class DistributedKVStore {
    /**
     * Creates a {@link KVManager} instance based on the configuration information.
     * <p>You must pass {@link KVManagerConfig} to provide configuration information
     * to create a {@link KVManager} instance.
     *
     * @param { KVManagerConfig } config - Indicates the configuration information, including the bundle name and context.
     * @returns { KVManager } Returns the KVManager instance.
     * @throws { BusinessException } 401 - The context type is not supported. Only support UIAbilityContext.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public static func createKVManager(config: KVManagerConfig): KVManager {
        unsafe {
            let stageContext =  match(config.context) {
                case ctx: UIAbilityContext => getStageContext(ctx)
                case _ => throw BusinessException(401, "Parameter error.")
            }
            if (stageContext.isNull()) {
                throw BusinessException(401, "Parameter error.")
            }
            let cBoudleName = LibC.mallocCString(config.bundleName)
            let codeId = FfiOHOSDistributedKVStoreCreateKVManager(cBoudleName, stageContext)
            LibC.free(cBoudleName)
            return KVManager(codeId)
        }
    }
}

/**
 * Provides interfaces to manage a SingleKVStore database, including obtaining, closing, and deleting the
 * SingleKVStore.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
]
public class KVManager <: RemoteDataLite {
    private let callbackList = ArrayList<(CallbackObject, Int64)>()
    private let onOffMutex = Mutex()
    init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /*
     * @throws { BusinessException } 15100003 - Database corrupted.
     */
    static func getKVStoreId(id: Int64 ,storeId: String, options: KVOptions, kVStoreType: KVStoreType): Int64 {
        unsafe {
            var codeId = 0
            try (
                cStoreId = LibC.mallocCString(storeId).asResource(),
                cOptions = COptions(options, kVStoreType).asResource()
            ) {
                var errCode: Int32 = 0
                codeId = FfiOHOSDistributedKVStoreGetKVStore(id, cStoreId.value, cOptions.value, inout errCode)
                if (errCode != SUCCESS_CODE) {
                    KV_STORE_LOG.info("Failed to getKVStore. code: ${errCode}")
                    throw BusinessException(getErrorCode(errCode),
                        "KVManager getKVStore failed: ${getErrorMsg(errCode)}")
                }
            }
            return codeId
        }
    }

    /**
     * Creates and obtains a KVStore database by specifying {@code KVOptions} and {@code storeId}.
     *
     * @param { String } storeId - Identifies the KVStore, which must be unique for the same application.
     * @param { Options } options - Indicates the configuration information, including createIfMissing, encrypt, backup, autoSync, kvStoreType, schema, and dataGroupId.
     * @returns { T } Returns the created KVStore instance.
     * @throws { BusinessException } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameters types;
     * <br>3.Parameter verification failed.
     * @throws { BusinessException } 15100002 - Open existed database with changed options.
     * @throws { BusinessException } 15100003 - Database corrupted.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public func getKVStore<T>(storeId: String, options: KVOptions): T where T <: SingleKVStore {
        let KVStore = match (T.getKVStore(getID(), storeId, options) as T) {
            case Some(v) => v
            case _ => throw BusinessException(15100002, "Open existed database with changed options.")
        }
        return KVStore
    }

    /**
     * Closes the KVStore database.
     * <p>Warning: This method is not thread-safe. If you call this method to stop a KVStore database that is running,
     * your thread may crash.
     * <p>The KVStore database to close must be an object created by using the {@code getKVStore} method. Before using
     * this method, release the resources created for the database, for example, {@code KVStoreResultSet} for KVStore,
     * otherwise closing the database will fail.
     *
     * @param { String } appId - Indicates the bundle name of the app that invokes the KVStore.
     * @param { String } storeId - Identifies the KVStore, which must be unique for the same application.
     * @throws { BusinessException } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Parameter verification failed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public func closeKVStore(appId: String, storeId: String): Unit {
        unsafe {
            try (
                cAppId = LibC.mallocCString(appId).asResource(),
                cStoreId = LibC.mallocCString(storeId).asResource()
            ) {
                let errCode = FfiOHOSDistributedKVStoreCloseKVStore(getID(), cAppId.value, cStoreId.value)
                if (errCode != SUCCESS_CODE) {
                    KV_STORE_LOG.info("Failed to closeKVStore. code: ${errCode}")
                    throw BusinessException(getErrorCode(errCode),
                        "KVManager closeKVStore failed: ${getErrorMsg(errCode)}")
                }
            }
        }
    }

    /**
     * Deletes the KVStore database identified by storeId.
     * <p>Before using this method, close all KVStore instances in use that are identified by the same storeId.
     * <p>You can use this method to delete a KVStore database not in use. After the database is deleted, all its data
     * will be lost.
     *
     * @param { String } appId - Identifies the application that the database belong to, and cannot exceed 256
     * characters.
     * @param { String } storeId - Identifies the KVStore database to delete. The storeId can consist of only letters,
     * digits, and underscores (_), and cannot exceed 128 characters.
     * @throws { BusinessException } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Parameter verification failed.
     * @throws { BusinessException } 15100004 - Not found.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public func deleteKVStore(appId: String, storeId: String): Unit {
        unsafe {
            try (
                cAppId = LibC.mallocCString(appId).asResource(),
                cStoreId = LibC.mallocCString(storeId).asResource()
            ) {
                let errCode = FfiOHOSDistributedKVStoreDeleteKVStore(getID(), cAppId.value, cStoreId.value)
                if (errCode != SUCCESS_CODE) {
                    KV_STORE_LOG.info("Failed to deleteKVStore. code: ${errCode}")
                    throw BusinessException(getErrorCode(errCode),
                        "KVManager deleteKVStore failed: ${getErrorMsg(errCode)}")
                }
            }
        }
    }

    /**
     * Obtains the storeId of all KVStore databases that are created by using the {@code getKVStore} method and not
     * deleted by calling the {@code deleteKVStore} method.
     *
     * @param { String } appId - Identifies the application that obtains the databases, and cannot exceed 256
     * characters.
     * @returns { Array<String> } Array<String> - the storeId of all created KVStore databases.
     * @throws { BusinessException } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Parameter verification failed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public func getAllKVStoreId(appId: String): Array<String> {
        unsafe {
            let cAppId = LibC.mallocCString(appId)
            var errCode: Int32 = 0
            let cArrString = FfiOHOSDistributedKVStoreGetAllKVStoreId(getID(), cAppId, inout errCode)
            LibC.free(cAppId)
            if (errCode != SUCCESS_CODE) {
                KV_STORE_LOG.info("Failed to getAllKVStoreId. code: ${errCode}")
                throw BusinessException(getErrorCode(errCode),
                    "KVManager getAllKVStoreId failed: ${getErrorMsg(errCode)}")
            }
            let ptr = cArrString.head
            let size = cArrString.size
            if (ptr.isNull()) {
                return Array<String>()
            }
            let result = Array<String>(size, {i => ptr.read(i).toString()})
            cArrString.free()
            return result
        }
    }
}
