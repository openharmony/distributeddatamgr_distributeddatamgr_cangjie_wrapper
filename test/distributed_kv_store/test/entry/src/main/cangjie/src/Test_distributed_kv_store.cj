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

internal import PerformanceAnalysisKit.*
internal import ohos.base.*
internal import std.collection.*
import std.unittest.testmacro.*

import ArkData.*
import ohos.data.distributed_kv_store.Entry as KVEntry
import ohos.data.distributed_kv_store.Options as KVOptions
import ohos.data.distributed_kv_store.SecurityLevel as KVSecurityLevel
import ohos.data.distributed_kv_store.ValueType as KVValueType

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
class Test_distributed_kv_store {

    override func afterAll(): Unit {
        gc()
        sleepFor(Duration.second)
    }

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
    func test_context() {
        @Expect(Constants.MAX_KEY_LENGTH, 1024)
        @Expect(Constants.MAX_VALUE_LENGTH, 4194303)
        @Expect(Constants.MAX_KEY_LENGTH_DEVICE, 896)
        @Expect(Constants.MAX_STORE_ID_LENGTH, 128)
        @Expect(Constants.MAX_QUERY_LENGTH, 512000)
        @Expect(Constants.MAX_BATCH_SIZE, 128)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_creatKVManager() {
        let kvstore = DistributedKVStore()
        let kvstoreName = "com.example.myapplication"
        let kvManager = DistributedKVStore.createKVManager(KVManagerConfig(getAbilityContext(), kvstoreName))
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getSingleKVStore_deleteKVStore() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>("myStoreId", opt)
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getDeviceKVStore_deleteKVStore() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<DeviceKVStore>("myStoreId", opt)
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_closeKVStore() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<DeviceKVStore>("myStoreId", opt)
        kvStore.put("myKey", KVValueType.StringValue("myValue"))
        kvManager.closeKVStore(bundleName, kvstoreName)
        try {
            let value = kvStore.get("myKey")
            throw Exception()
        } catch (e: BusinessException) {
            @Expect(true)
        }
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_getAllKVStoreId() {
        var list = kvManager.getAllKVStoreId(bundleName)
        Hilog.info(0, "test", "list size is ${list.size}")
        let kvstoreName01 = "myStoreId01"
        let kvstoreName02 = "myStoreId02"
        let kvstoreName03 = "myStoreId03"
        let opt = KVOptions(KVSecurityLevel.S4,)
        var singleKVStore = kvManager.getKVStore<SingleKVStore>(kvstoreName01, opt)
        var singleKVStore01 = kvManager.getKVStore<SingleKVStore>(kvstoreName02, opt)
        var singleKVStore02 = kvManager.getKVStore<SingleKVStore>(kvstoreName03, opt)
        list = kvManager.getAllKVStoreId(bundleName)
        if (list.size != 3 || !list.contains(kvstoreName01) || !list.contains(kvstoreName02) ||
            !list.contains(kvstoreName03)) {
            Hilog.info(0, "test", "list size is ${list.size}")
            for (i in list) {
                Hilog.info(0, "test", "name is : ${i}")
            }
            throw Exception()
        }
        kvManager.deleteKVStore(bundleName, kvstoreName01)
        kvManager.deleteKVStore(bundleName, kvstoreName02)
        kvManager.deleteKVStore(bundleName, kvstoreName03)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_put_get() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        var strkey = "keyback"
        var strvalue = "keyback"
        kvStore.put(strkey, KVValueType.StringValue(strvalue))
        var valuestr = kvStore.get(strkey)
        match (valuestr) {
            case StringValue(v) =>
                if (v != strvalue) {
                    throw Exception()
                }
            case _ => throw Exception()
        }
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_putBatch() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        let entries = Array<KVEntry>(10, { i =>
            return KVEntry("batch_test_string_key${i}", KVValueType.StringValue("batch_test_string_value${i}"))
        })

        kvStore.putBatch(entries)
        for (i in 0..10) {
            var valuestr = kvStore.get("batch_test_string_key${i}")
            match (valuestr) {
                case StringValue(v) =>
                    if (v != "batch_test_string_value${i}") {
                        throw Exception()
                    }
                case _ => throw Exception()
            }
        }
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_delete() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        var strkey = "keyback"
        var strvalue = "keyback"
        kvStore.put(strkey, KVValueType.StringValue(strvalue))
        kvStore.delete(strkey)
        try {
            var valuestr = kvStore.get(strkey)
            throw Exception()
        } catch (_) {
            @Expect(true)
        }
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_backup_restore() {
        let kvstoreName = "myStoreId"
        let fileName = "backfile"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        var strkey = "keyback"
        var strvalue = "keyback"
        kvStore.put(strkey, KVValueType.StringValue(strvalue))
        kvStore.backup(fileName)
        kvStore.delete(strkey)
        try {
            var valuestr = kvStore.get(strkey)
            throw Exception()
        } catch (_) {
            @Expect(true)
        }
        kvStore.restore(fileName)
        match (kvStore.get(strkey)) {
            case StringValue(v) =>
                if (v != strvalue) {
                    throw Exception()
                }
            case _ => throw Exception()
        }
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_startTransaction() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        var strkey = "keyback"
        var strvalue = "keyback"
        kvStore.startTransaction()
        kvStore.put(strkey, KVValueType.StringValue(strvalue))
        kvStore.rollback()
        try {
            var valuestr = kvStore.get(strkey)
            throw Exception()
        } catch (_) {
            @Expect(true)
        }
        kvStore.startTransaction()
        kvStore.put(strkey, KVValueType.StringValue(strvalue))
        kvStore.commit()
        match (kvStore.get(strkey)) {
            case StringValue(v) =>
                if (v != strvalue) {
                    throw Exception()
                }
            case _ => throw Exception()
        }
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_common_S1S2S3() {
        let kvstoreName = "myStoreId"
        let opt0 = KVOptions(KVSecurityLevel.S1,)
        let opt1 = KVOptions(KVSecurityLevel.S2,)
        let opt2 = KVOptions(KVSecurityLevel.S3,)
        let kvStore0 = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt0)
        let kvStore1 = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt1)
        let kvStore2 = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt2)
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_singleKVStore_deleteBatch() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        let entries = Array<KVEntry>(10, { i =>
            return KVEntry("batch_test_string_key${i}", KVValueType.StringValue("batch_test_string_value${i}"))
        })
        let keys = Array<String>(10, { i =>
            return "batch_test_string_key${i}"
        })

        kvStore.putBatch(entries)
        kvStore.deleteBatch(keys)
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_singleKVStore_enableSync() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        kvStore.enableSync(true)
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_singleKVStore_setSyncParam() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<SingleKVStore>(kvstoreName, opt)
        kvStore.setSyncParam(1000)
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_DeviceKVStore_getEntries() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<DeviceKVStore>("myStoreId", opt)
        kvStore.put("myKey", KVValueType.StringValue("myValue"))
        Hilog.error(0, "test", "11111111111111111111")
        let value = kvStore.getEntries("myKey")
        Hilog.error(0, "test", "22222222222222222222")
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_Valuetype() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<DeviceKVStore>("myStoreId", opt)
        kvStore.put("myKey01", KVValueType.StringValue("myValue"))
        kvStore.put("myKey02", KVValueType.Integer(123))
        kvStore.put("myKey03", KVValueType.Float(123.45))
        kvStore.put("myKey04", KVValueType.Boolean(true))
        kvStore.put("myKey05", KVValueType.Double(123.45))
        kvStore.put("myKey06", KVValueType.ByteArray([1, 2, 3]))
        var key1 = kvStore.get("myKey01")
        var key2 = kvStore.get("myKey02")
        var key3 = kvStore.get("myKey03")
        var key4 = kvStore.get("myKey04")
        var key5 = kvStore.get("myKey05")
        var key6 = kvStore.get("myKey06")
        kvManager.closeKVStore(bundleName, kvstoreName)
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_DeviceKVStore_getEntries_query() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<DeviceKVStore>("myStoreId", opt)
        kvStore.getEntries(Query())
        kvManager.closeKVStore(bundleName, kvstoreName)
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_DeviceKVStore_getResultSize_query() {
        let kvstoreName = "myStoreId"
        let opt = KVOptions(KVSecurityLevel.S4,)
        let kvStore = kvManager.getKVStore<DeviceKVStore>("myStoreId", opt)
        try {
            kvStore.getResultSize(Query())
        } catch (e: BusinessException) {
            @Expect(e.code, 15100004)
        }
        kvManager.closeKVStore(bundleName, kvstoreName)
        kvManager.deleteKVStore(bundleName, kvstoreName)
    }

}
