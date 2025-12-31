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

package ohos.data.relational_store

import ohos.app.ability.ui_ability.UIAbilityContext
import ohos.callback_invoke.Callback0Argument
import ohos.labels.*
import std.collection.*

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public class RdbPredicates {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public init(name: String) {
        super()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func inAllDevices(): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func equalTo(field: String, value: RelationalStoreValueType): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func notEqualTo(field: String, value: RelationalStoreValueType): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func beginWrap(): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func endWrap(): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func or(): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func and(): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func contains(field: String, value: String): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func beginsWith(field: String, value: String): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func endsWith(field: String, value: String): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func isNull(field: String): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func isNotNull(field: String): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func like(field: String, value: String): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func glob(field: String, value: String): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func between(field: String, low: RelationalStoreValueType, high: RelationalStoreValueType): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func notBetween(field: String, low: RelationalStoreValueType, high: RelationalStoreValueType): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func greaterThan(field: String, value: RelationalStoreValueType): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func lessThan(field: String, value: RelationalStoreValueType): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func greaterThanOrEqualTo(field: String, value: RelationalStoreValueType): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func lessThanOrEqualTo(field: String, value: RelationalStoreValueType): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func orderByAsc(field: String): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func orderByDesc(field: String): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func distinct(): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func limitAs(value: Int32): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func offsetAs(rowOffset: Int32): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func groupBy(fields: Array<String>): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func inValues(field: String, value: Array<RelationalStoreValueType>): RdbPredicates {
        return RdbPredicates(String())
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public func notInValues(field: String, value: Array<RelationalStoreValueType>): RdbPredicates {
        return RdbPredicates(String())
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public class RdbStore {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true, workerthread: true]
    public func insert(table: String, values: ValuesBucket,
        conflict!: ConflictResolution = ConflictResolution.OnConflictNone): Int64 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true, workerthread: true]
    public func batchInsert(table: String, values: Array<ValuesBucket>): Int64 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true, workerthread: true]
    public func update(values: ValuesBucket, predicates: RdbPredicates,
        conflict!: ConflictResolution = ConflictResolution.OnConflictNone): Int64 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true, workerthread: true]
    public func delete(predicates: RdbPredicates): Int64 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true, workerthread: true]
    public func query(predicates: RdbPredicates, columns!: Array<String> = []): ResultSet {
        return ResultSet()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true, workerthread: true]
    public func querySql(sql: String, bindArgs!: Array<RelationalStoreValueType> = []): ResultSet {
        return ResultSet()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true, workerthread: true]
    public func executeSql(sql: String, bindArgs!: Array<RelationalStoreValueType> = []): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func beginTransaction(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func commit(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func rollBack(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true, workerthread: true]
    public func backup(destName: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true, workerthread: true]
    public func restore(srcName: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func on(event: String, interProcess: Bool, observer: Callback0Argument): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func off(event: String, interProcess: Bool, observer!: ?Callback0Argument = None): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func emit(event: String): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true, workerthread: true]
public func getRdbStore(context: UIAbilityContext, config: StoreConfig): RdbStore {
    return RdbStore()
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true, workerthread: true]
public func deleteRdbStore(context: UIAbilityContext, name: String): Unit {
    return ()
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true, workerthread: true]
public func deleteRdbStore(context: UIAbilityContext, config: StoreConfig): Unit {
    return ()
}

public type Assets = Array<Asset>

public type ValuesBucket = Map<String, RelationalStoreValueType>

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public class CryptoParam {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var encryptionKey: Array<UInt8>

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var iterationCount: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var encryptionAlgo: EncryptionAlgo

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var hmacAlgo: HmacAlgo

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var kdfAlgo: ?KdfAlgo

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var cryptoPageSize: UInt32

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public init(encryptionKey: Array<UInt8>, iterationCount!: Int32 = 10000,
        encryptionAlgo!: EncryptionAlgo = EncryptionAlgo.Aes256Gcm, hmacAlgo!: HmacAlgo = HmacAlgo.Sha256,
        kdfAlgo!: ?KdfAlgo = None, cryptoPageSize!: UInt32 = 1024) {
        super()
        this.encryptionKey = Array()
        this.iterationCount = 0
        this.encryptionAlgo = EncryptionAlgo.Aes256Gcm
        this.hmacAlgo = HmacAlgo.Sha1
        this.kdfAlgo = None
        this.cryptoPageSize = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum KdfAlgo {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    KdfSha1
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    KdfSha256
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    KdfSha512
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum HmacAlgo {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    Sha1
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    Sha256
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    Sha512
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum EncryptionAlgo {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    Aes256Gcm
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    Aes256Cbc
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum Tokenizer {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    NoneTokenizer
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    IcuTokenizer
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    CustomTokenizer
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum RelationalStoreSecurityLevel {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    S1
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    S2
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    S3
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    S4
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum ChangeType {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    DataChange
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    AssetChange
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public class StoreConfig {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var name: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var securityLevel: RelationalStoreSecurityLevel

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var encrypt: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var dataGroupId: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var customDir: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var rootDir: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    public var autoCleanDirtyData: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var allowRebuild: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var vector: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var isReadOnly: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var pluginLibs: Array<String>

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var cryptoParam: CryptoParam

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var tokenizer: Tokenizer

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var persist: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var enableSemanticIndex: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public init(securityLevel: RelationalStoreSecurityLevel, name!: String = "", encrypt!: Bool = false,
        dataGroupId!: String = "", customDir!: String = "", rootDir!: String = "", autoCleanDirtyData!: Bool = true,
        allowRebuild!: Bool = false, isReadOnly!: Bool = false, pluginLibs!: Array<String> = Array<String>(),
        cryptoParam!: CryptoParam = CryptoParam([]), vector!: Bool = false,
        tokenizer!: Tokenizer = Tokenizer.NoneTokenizer, persist!: Bool = true, enableSemanticIndex!: Bool = false) {
        super()
        this.name = String()
        this.securityLevel = RelationalStoreSecurityLevel.S1
        this.encrypt = true
        this.dataGroupId = String()
        this.customDir = String()
        this.rootDir = String()
        this.autoCleanDirtyData = true
        this.allowRebuild = true
        this.vector = true
        this.isReadOnly = true
        this.pluginLibs = Array()
        this.cryptoParam = CryptoParam(
            Array(),
            iterationCount: 0,
            encryptionAlgo: EncryptionAlgo.Aes256Gcm,
            hmacAlgo: HmacAlgo.Sha1,
            kdfAlgo: None,
            cryptoPageSize: 0
        )
        this.tokenizer = Tokenizer.NoneTokenizer
        this.persist = true
        this.enableSemanticIndex = true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum AssetStatus {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    AssetNormal
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    AssetInsert
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    AssetUpdate
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    AssetDelete
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    AssetAbnormal
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    AssetDownloading
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
public enum Field {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    CursorField
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    OriginField
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    DeletedFlagField
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    OwnerField
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    PrivilegeField
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    SharingResourceField
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum ConflictResolution {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    OnConflictNone
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    OnConflictRollback
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    OnConflictAbort
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    OnConflictFail
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    OnConflictIgnore
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    OnConflictReplace
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public class Asset {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var name: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var uri: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var path: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var createTime: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var modifyTime: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var size: String

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public var status: AssetStatus

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public init(name: String, uri: String, path: String, createTime: String, modifyTime: String, size: String,
        status!: AssetStatus = AssetStatus.AssetNormal) {
        super()
        this.name = String()
        this.uri = String()
        this.path = String()
        this.createTime = String()
        this.modifyTime = String()
        this.size = String()
        this.status = AssetStatus.AssetNormal
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum RelationalStoreValueType {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    Null
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"] Integer(Int64)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"] Double(Float64)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"] StringValue(
        String)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"] Boolean(Bool)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"] Uint8Array(
        Array<UInt8>)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"] AssetEnum(Asset)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"] AssetsEnum(
        Array<Asset>)
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum DistributedType {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    DistributedDevice
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    DistributedCloud
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum SyncMode {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    SyncModePush
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    SyncModePull
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    SyncModeTimeFirst
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    SyncModeNativeFirst
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    SyncModeCloudFirst
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum Progress {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    SyncBegin
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    SyncInProgress
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    SyncFinish
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public enum SubscribeType {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    SubscribeTypeRemote
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    SubscribeTypeCloud
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    SubscribeTypeCloudDetails
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
public enum Origin {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    Local
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    Cloud
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"]
    Remote
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
public class ResultSet {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public prop columnNames: Array<String> {
        
        get() {
            return Array()
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public prop columnCount: Int32 {
        
        get() {
            return 0
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public prop rowCount: Int32 {
        
        get() {
            return 0
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public prop rowIndex: Int32 {
        
        get() {
            return 0
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public prop isAtFirstRow: Bool {
        
        get() {
            return true
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public prop isAtLastRow: Bool {
        
        get() {
            return true
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public prop isEnded: Bool {
        
        get() {
            return true
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public prop isStarted: Bool {
        
        get() {
            return true
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"]
    public prop isClosed: Bool {
        
        get() {
            return true
        }
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func getColumnIndex(columnName: String): Int32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func getColumnName(columnIndex: Int32): String {
        return String()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func goTo(offset: Int32): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func goToRow(position: Int32): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func goToFirstRow(): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func goToLastRow(): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func goToNextRow(): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func goToPreviousRow(): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func getBlob(columnIndex: Int32): Array<UInt8> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func getString(columnIndex: Int32): String {
        return String()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func getLong(columnIndex: Int32): Int64 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func getDouble(columnIndex: Int32): Float64 {
        return 0.0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func getAsset(columnIndex: Int32): Asset {
        return Asset(
            String(),
            String(),
            String(),
            String(),
            String(),
            String(),
            status: AssetStatus.AssetNormal
        )
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func getAssets(columnIndex: Int32): Assets {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func getRow(): ValuesBucket {
        return HashMap<String, RelationalStoreValueType>()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func isColumnNull(columnIndex: Int32): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core", throwexception: true]
    public func close(): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}