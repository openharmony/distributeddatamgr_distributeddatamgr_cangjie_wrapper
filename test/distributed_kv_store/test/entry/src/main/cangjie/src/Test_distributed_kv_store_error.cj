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

package ohos_app_cangjie_entry

internal import kit.PerformanceAnalysisKit.*
internal import ohos.base.*
internal import std.collection.*
import std.unittest.testmacro.*

import ArkData.*
import ohos.data.distributed_kv_store.Entry as KVEntry

import ohos.data.distributed_kv_store.*
import std.runtime.*
import std.sync.*
import std.time.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import ohos.hilog.Hilog
import ohos.callback_invoke.*
import ohos.business_exception.*

@Test
class Test_distributed_kv_store_error {

    let bundleName = "com.example.myapplication"
    var _kvManager: ?KVManager = None
    prop kvManager: KVManager {
        get() {
            match (_kvManager) {
                case Some(kvManager) => kvManager
                case None =>
                    let kvManager = DistributedKVStore.createKVManager(KVManagerConfig(getAbilityContext(), bundleName))
                    _kvManager = kvManager
                    kvManager
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_startTransaction_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        kvManager.deleteKVStore(bundleName, kvstoreName)
        try {
            kvStore.startTransaction()
        } catch (e: BusinessException) {
            Hilog.info(0, "test", "startTransaction_error : ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_rollback_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        var strkey = "keyback"
        var strvalue = "keyback"
        kvStore.startTransaction()
        kvStore.put(strkey, KVValueType.StringValue(strvalue))
        kvManager.deleteKVStore(bundleName, kvstoreName)
        try {
            kvStore.rollback()
        } catch (e: BusinessException) {
            Hilog.info(0, "test", "rollback_error : ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_commit_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        var strkey = "keyback"
        var strvalue = "keyback"
        kvStore.startTransaction()
        kvStore.put(strkey, KVValueType.StringValue(strvalue))
        kvManager.deleteKVStore(bundleName, kvstoreName)
        try {
            kvStore.commit()
        } catch (e: BusinessException) {
            Hilog.info(0, "test", "test_commit_error: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getKVStoreId_error() {
        let kvstoreName = "myStoreId"

        let opt = KVOptions(KVSecurityLevel.S1,)
        try {
            let singleKVStore = kvManager.getKVStore<SingleKVStore>("", opt)
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 401)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_closeKVStore_error() {
        let kvstoreName = "myStoreId"
        try {
            kvManager.closeKVStore("", "12345")
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 401)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_deleteKVStore_error() {
        let kvstoreName = "myStoreId"
        try {
            kvManager.deleteKVStore("error", kvstoreName)
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 15100004)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getAllKVStoreId_error() {
        let kvstoreName = "myStoreId"
        try {
            var list = kvManager.getAllKVStoreId("error")
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 202)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_singleKVStore_put_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        try {
            kvStore.put("", KVValueType.StringValue(""))
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 401)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_singleKVStore_delete_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        try {
            kvStore.delete("")
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 401)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_singleKVStore_putBatch_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        let entries = Array<KVEntry>(11, { i =>
            if (i < 10) {
                return KVEntry("batch_test_string_key${i}", KVValueType.StringValue("batch_test_string_value${i}"))
            }
            return KVEntry("", KVValueType.StringValue(""))
        })

        try {
            kvStore.putBatch(entries)
            kvManager.deleteKVStore(bundleName, kvstoreName)
            @Expect(false)
        } catch (e: BusinessException) {
            kvManager.deleteKVStore(bundleName, kvstoreName)
            @Expect(e.code, 401)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_singleKVStore_deleteBatch_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        let keys = Array<String>(11, { i =>
            if (i < 10) {
                return "batch_test_string_key${i}"
            }
            return ""
        })

        try {
            kvStore.deleteBatch(keys)
            kvManager.deleteKVStore(bundleName, kvstoreName)
            @Expect(false)
        } catch (e: BusinessException) {
            kvManager.deleteKVStore(bundleName, kvstoreName)
            @Expect(e.code, 401)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_singleKVStore_backup_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        try {
            kvStore.backup("")
            kvManager.deleteKVStore(bundleName, kvstoreName)
            @Expect(false)
        } catch (e: BusinessException) {
            kvManager.deleteKVStore(bundleName, kvstoreName)
            @Expect(e.code, 401)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_singleKVStore_restore_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        try {
            kvStore.restore("hhh")
            kvStore.restore("hhh")
            kvManager.deleteKVStore(bundleName, kvstoreName)
            @Expect(false)
        } catch (e: BusinessException) {
            kvManager.deleteKVStore(bundleName, kvstoreName)
            @Expect(e.code, 401)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_singleKVStore_enableSync_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        kvManager.deleteKVStore(bundleName, kvstoreName)
        sleepFor(1.second)
        try {
            kvStore.enableSync(true)
        } catch (e: BusinessException) {
            Hilog.info(0, "test", "test_singleKVStore_enableSync_error: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_singleKVStore_setSyncParam_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        kvManager.deleteKVStore(bundleName, kvstoreName)
        sleepFor(1.second)
        try {
            kvStore.setSyncParam(1000)
        } catch (e: BusinessException) {
            Hilog.info(0, "test", "setSyncParam error message : ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_DeviceKVStore_getEntries_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<DeviceKVStore>("myStoreId", opt)
        kvStore.put("myKey", KVValueType.StringValue("myValue"))
        kvManager.closeKVStore(bundleName, kvstoreName)
        try {
            let value = kvStore.getEntries("myKey")
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 15100005)
        }
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_DeviceKVStore_getResultSet_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<DeviceKVStore>("myStoreId", opt)
        kvStore.put("myKey", KVValueType.StringValue("myValue"))
        kvManager.closeKVStore(bundleName, kvstoreName)
        sleepFor(1.second)
        try {
            let value = kvStore.getResultSet("myKey")
        } catch (e: BusinessException) {
            @Expect(true)
        }
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_DeviceKVStore_getResultSetByQuery() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<DeviceKVStore>("myStoreId", opt)
        sleepFor(1.second)
        try {
            let value = kvStore.getResultSet(Query())
        } catch (e: BusinessException) {
            @Expect(true)
        }
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_DeviceKVStore_getResultSize_query_error() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<DeviceKVStore>("myStoreId", opt)
        kvManager.closeKVStore(bundleName, kvstoreName)
        kvManager.deleteKVStore(bundleName, kvstoreName)

        try {
            kvStore.getResultSize(Query())
            @Expect(true)
        } catch (e: BusinessException) {
            Hilog.info(0, "test", "test_DeviceKVStore_getResultSize_query_error: ${e.message}")
        }
    }

}
