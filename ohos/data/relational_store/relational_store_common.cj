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

package ohos.data.relational_store

import ohos.ffi.*
import ohos.hilog.*
import ohos.labels.*
import std.collection.*
import ohos.business_exception.{ BusinessException, UNIVERSAL_ERROR_MAP, getUniversalErrorMsg}

const UINT64_MAX: UInt64 = 0xffff_ffff_ffff_ffff
let RELATIONAL_STORE_LOG = HilogChannel(0, 0xD001650, "CJ-Relational_Store")

/**
 * Indicates several assets in one column
 */
public type Assets = Array<Asset>

/**
 * Values in buckets are stored in key-value pairs
 */
public type ValuesBucket = Map<String, RelationalStoreValueType>

/**
 * Specifies the cryptographic parameters used when opening an encrypted database.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public class CryptoParam {
    /**
     * Specifies the key used when opening an encrypted database.
     * When finished passing the key to the database, its content should be set to all-zero.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var encryptionKey: Array<UInt8>

    /**
     * Specifies the number of KDF iterations used when opening an encrypted database.
     * Default number is 10000.
     * When the number is set to 0, use default iteration number and encryption algorithm.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var iterationCount: Int32

    /**
     * Specifies the encryption algorithm when opening an encrypted database.
     * Default encryption algorithm is AES_256_GCM.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var encryptionAlgo: EncryptionAlgo

    /**
     * Specifies the HMAC algorithm when opening an encrypted database.
     * Default HMAC algorithm is SHA256.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var hmacAlgo: HmacAlgo

    /**
     * Specifies the KDF algorithm when opening an encrypted database.
     * Default KDF SHA algorithm is the same as HMAC algorithm.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var kdfAlgo: ?KdfAlgo

    /**
     * Specifies the page size used when opening an encrypted database.
     * Default crypto page size is 1024.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var cryptoPageSize: UInt32

    /**
     * CryptoParam constructor.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public init(encryptionKey: Array<UInt8>, iterationCount!: Int32 = 10000,
        encryptionAlgo!: EncryptionAlgo = EncryptionAlgo.Aes256Gcm,
        hmacAlgo!: HmacAlgo = HmacAlgo.Sha256, kdfAlgo!: ?KdfAlgo = None,
        cryptoPageSize!: UInt32 = 1024) {
        this.encryptionKey = encryptionKey
        this.iterationCount = iterationCount
        this.encryptionAlgo = encryptionAlgo
        this.hmacAlgo = hmacAlgo
        this.kdfAlgo = kdfAlgo
        this.cryptoPageSize = cryptoPageSize
    }
}

/**
 * Enumerates the supported KDF algorithm when opening a database.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum KdfAlgo {
    /**
     * KDF_SHA1: PBKDF2_HMAC_SHA1 algorithm.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    KdfSha1
    |
    /**
     * PBKDF2_HMAC_SHA256 algorithm.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    KdfSha256
    |
    /**
     * PBKDF2_HMAC_SHA512 algorithm.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    KdfSha512
    | ...
}

/**
 * Enumerates the supported HMAC algorithm when opening a database.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum HmacAlgo {
    /**
     * HMAC_SHA1 algorithm.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    Sha1
    |
    /**
     * HMAC_SHA256 algorithm.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    Sha256
    |
    /**
     * HMAC_SHA512 algorithm.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    Sha512
    | ...
}

/**
 * Enumerates the supported encryption algorithm when opening a database.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum EncryptionAlgo {
    /**
     * Database is encrypted using AES_256_GCM.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    Aes256Gcm
    |
    /**
     * Database is encrypted using AES_256_CBC.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    Aes256Cbc
    | ...
}

/**
 * Enumerates the supported tokenizer when opening a database.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum Tokenizer {
    /**
     * not use tokenizer.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    NoneTokenizer
    |
    /**
     * native icu tokenizer.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    IcuTokenizer
    |
    /**
     * self-developed enhance tokenizer.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    CustomTokenizer
    | ...

    func getValue(): Int32 {
        match (this) {
            case NoneTokenizer => 0
            case IcuTokenizer => 1
            case CustomTokenizer => 2
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Describes the {@code RdbStore} type.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum RelationalStoreSecurityLevel {
    /**
     * S1: means the db is low level security
     * There are some low impact, when the data is leaked.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    S1
    |
    /**
     * S2: means the db is middle level security
     * There are some major impact, when the data is leaked.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    S2
    |
    /**
     * S3: means the db is high level security
     * There are some severity impact, when the data is leaked.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    S3
    |
    /**
     * S4: means the db is critical level security
     * There are some critical impact, when the data is leaked.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    S4
    | ...

    func getValue(): Int32 {
        match (this) {
            case S1 => 1
            case S2 => 2
            case S3 => 3
            case S4 => 4
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Describes the change type.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum ChangeType {
    /**
     * Means the change type is data change.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    DataChange
    |
    /**
     * Means the change type is asset change.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    AssetChange
    | ...

    func getValue(): Int32 {
        match (this) {
            case DataChange => 0
            case AssetChange => 1
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }

    static func parse(val: Int32): ChangeType {
        match (val) {
            case 0 => DataChange
            case 1 => AssetChange
            case _ => throw IllegalArgumentException("Unknown value.")
        }
    }
}

/**
 * Manages relational database configurations.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public class StoreConfig {
    /**
     * The database name.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var name: String

    /**
     * Specifies the security level of the database.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var securityLevel: RelationalStoreSecurityLevel

    /**
     * Specifies whether the database is encrypted.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var encrypt: Bool

    /**
     * The data group id of application.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var dataGroupId: String

    /**
     * Specifies the directory relative to the database directory obtained from context.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var customDir: String

    /**
     * Specifies the root directory relative to the database
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var rootDir: String

    /**
     * Specifies whether to clean up dirty data that is synchronized to
     * the local but deleted in the cloud.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    public var autoCleanDirtyData: Bool

    /**
     * Specifies whether database allows rebuild.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var allowRebuild: Bool

    /**
     * Specifies whether the database opened is read-only.
     * If isReadOnly is true, other configuration items will become invalid.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var isReadOnly: Bool

    /**
     * Indicates the names of the shared library containing fts etc.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var pluginLibs: Array<String>

    /**
     * Specifies the cryptographic parameters used when opening an encrypted database.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var cryptoParam: CryptoParam

    /**
     * Specifies whether the vector type is supported.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var vector: Bool

    /**
     * Specifies the tokenizer type when using fts capability.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var tokenizer: Tokenizer

    /**
     * Specifies whether the database need persistence.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var persist: Bool

    /**
     * Specifies whether the database enable the capabilities for semantic indexing processing.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var enableSemanticIndex: Bool

    /**
     * StoreConfig constructor.
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public init(securityLevel: RelationalStoreSecurityLevel, name!: String = "",
        encrypt!: Bool = false, dataGroupId!: String = "",
        customDir!: String = "", rootDir!: String = "",
        autoCleanDirtyData!: Bool = true, allowRebuild!: Bool = false,
        isReadOnly!: Bool = false, pluginLibs!: Array<String> = Array<String>(),
        cryptoParam!: CryptoParam = CryptoParam(), vector!: Bool = false,
        tokenizer!: Tokenizer = Tokenizer.NoneTokenizer, persist!: Bool = true,
        enableSemanticIndex!: Bool = false) {
        this.name = name
        this.securityLevel = securityLevel
        this.encrypt = encrypt
        this.dataGroupId = dataGroupId
        this.customDir = customDir
        this.rootDir = rootDir
        this.autoCleanDirtyData = autoCleanDirtyData
        this.allowRebuild = allowRebuild
        this.isReadOnly = isReadOnly
        this.pluginLibs = pluginLibs
        this.cryptoParam = cryptoParam
        this.vector = vector
        this.tokenizer = tokenizer
        this.persist = persist
        this.enableSemanticIndex = enableSemanticIndex
    }
}

/**
 * Describes the status of asset
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum AssetStatus {
    /**
     * ASSET_NORMAL: means the status of asset is normal.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    AssetNormal
    |
    /**
     * ASSET_INSERT: means the asset needs to be inserted.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    AssetInsert
    |
    /**
     * ASSET_UPDATE: means the asset needs to be updated.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    AssetUpdate
    |
    /**
     * ASSET_DELETE: means the asset needs to be deleted.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    AssetDelete
    |
    /**
     * ASSET_ABNORMAL: means the status of asset is abnormal.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    AssetAbnormal
    |
    /**
     * ASSET_DOWNLOADING: means the status of asset is downloading.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    AssetDownloading
    | ...

    func getValue(): Int32 {
        match (this) {
            case AssetNormal => 1
            case AssetInsert => 2
            case AssetUpdate => 3
            case AssetDelete => 4
            case AssetAbnormal => 5
            case AssetDownloading => 6
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }

    static func parse(val: Int32): AssetStatus {
        match (val) {
            case 1 => AssetNormal
            case 2 => AssetInsert
            case 3 => AssetUpdate
            case 4 => AssetDelete
            case 5 => AssetAbnormal
            case 6 => AssetDownloading
            case _ => throw IllegalArgumentException("Unknown value")
        }
    }
}

/**
 * Enumerates the field.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
]
public enum Field {
    /**
     * Cursor field.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    CursorField
    |
    /**
     * Origin field. For details, see {@link Origin}.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    OriginField
    |
    /**
     * Deleted flag field.
     * Indicates whether data has deleted in cloud.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    DeletedFlagField
    |
    /**
     * Owner field.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    OwnerField
    |
    /**
     * Privilege field.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    PrivilegeField
    |
    /**
     * Sharing resource field.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    SharingResourceField
    | ...

    func getValue(): String {
        match (this) {
            case CursorField => "#_cursor"
            case OriginField => "#_origin"
            case DeletedFlagField => "#_deleted_flag"
            case OwnerField => "#_cloud_owner"
            case PrivilegeField => "#_cloud_privilege"
            case SharingResourceField => "#_sharing_resource_field"
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Describes the conflict resolutions to insert data into the table.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum ConflictResolution {
    /**
     * Implements no action when conflict occurs.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    OnConflictNone
    |
    /**
     * Implements rollback operation when conflict occurs.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    OnConflictRollback
    |
    /**
     * Implements abort operation when conflict occurs.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    OnConflictAbort
    |
    /**
     * Implements fail operation when conflict occurs.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    OnConflictFail
    |
    /**
     * Implements ignore operation when conflict occurs.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    OnConflictIgnore
    |
    /**
     * Implements replace operation operator when conflict occurs.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    OnConflictReplace
    | ...

    func getValue(): Int32 {
        match (this) {
            case OnConflictNone => 0
            case OnConflictRollback => 1
            case OnConflictAbort => 2
            case OnConflictFail => 3
            case OnConflictIgnore => 4
            case OnConflictReplace => 5
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Records information of the asset.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public class Asset {
    /**
     * The name of asset.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var name: String

    /**
     * The uri of asset.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var uri: String

    /**
     * The path of asset.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var path: String

    /**
     * The create time of asset.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var createTime: String

    /**
     * The modify time of asset.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var modifyTime: String

    /**
     * The size of asset.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var size: String

    /**
     * The status of asset.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public var status: AssetStatus

    /**
     * Asset constructor.
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    public init(name: String, uri: String, path: String, createTime: String, modifyTime: String, size: String,
        status!: AssetStatus = AssetStatus.AssetNormal) {
        this.name = name
        this.uri = uri
        this.path = path
        this.createTime = createTime
        this.modifyTime = modifyTime
        this.size = size
        this.status = status
    }
}

/**
 * Indicates possible value types.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum RelationalStoreValueType {
    /**
     * Indicates null.
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    Null
    |
    /**
     * Indicates Int64.
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    Integer(Int64)
    |
    /**
     * Indicates Float64.
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    Double(Float64)
    |
    /**
     * Indicates String.
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    StringValue(String)
    |
    /**
     * Indicates Bool.
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    Boolean(Bool)
    |
    /**
     * Indicates Array<UInt8>.
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    Uint8Array(Array<UInt8>)
    |
    /**
     * Indicates Asset.
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    AssetEnum(Asset)
    |
    /**
     * Indicates Array<Asset>.
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    AssetsEnum(Array<Asset>)
    | ...
}

enum DataPosition {
    | StringArray(Array<String>)
    | Int64Array(Array<Int64>)
    | Float64Array(Array<Float64>)
}

/**
 * Describes the distribution type of the tables.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum DistributedType {
    /**
     * Indicates the table is distributed among the devices.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    DistributedDevice
    |
    /**
     * Indicates the table is distributed between the cloud and the devices.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    DistributedCloud
    | ...

    func getValue(): Int32 {
        match (this) {
            case DistributedDevice => 0
            case DistributedCloud => 1
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Indicates the database synchronization mode.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum SyncMode {
    /**
     * Indicates the data is pushed to remote device from local device.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    SyncModePush
    |
    /**
     * Indicates the data is pulled from remote device to local device.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    SyncModePull
    |
    /**
     * Indicates the data is pulled from remote device to local device.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    SyncModeTimeFirst
    | 
    /**
     * Indicates force push the native data to the cloud.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    SyncModeNativeFirst
    |
    /**
     * Indicates the data is pulled from cloud to local device.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    SyncModeCloudFirst
    | ...

    func getValue(): Int32 {
        match (this) {
            case SyncModePush => 0
            case SyncModePull => 1
            case SyncModeTimeFirst => 4
            case SyncModeNativeFirst => 5
            case SyncModeCloudFirst => 6
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * The cloud sync progress.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum Progress {
    /**
     * ISYNC_BEGIN: means the sync process begin.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    SyncBegin
    |
    /**
     * SYNC_BEGIN: means the sync process is in progress.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    SyncInProgress
    |
    /**
     * SYNC_BEGIN: means the sync process is finished.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    SyncFinish
    | ...

    func getValue(): Int32 {
        match (this) {
            case SyncBegin => 0
            case SyncInProgress => 1
            case SyncFinish => 2
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }

    static func parse(val: Int32): Progress {
        match (val) {
            case 0 => SyncBegin
            case 1 => SyncInProgress
            case 2 => SyncFinish
            case _ => throw IllegalArgumentException("Unknown value")
        }
    }
}

/**
 * Describes the subscription type.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
]
public enum SubscribeType {
    /**
     * Subscription to remote data changes.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.RelationalStore.Core"
    ]
    SubscribeTypeRemote
    |
    /**
     * Subscription to cloud data changes.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    SubscribeTypeCloud
    |
    /**
     * Subscription to cloud data changes details.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    SubscribeTypeCloudDetails
    | ...

    func getValue(): Int32 {
        match (this) {
            case SubscribeTypeRemote => 0
            case SubscribeTypeCloud => 1
            case SubscribeTypeCloudDetails => 2
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Describes the data origin sources.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
]
public enum Origin {
    /**
     * Indicates the data source is local.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    Local
    |
    /**
     * Indicates the data source is cloud.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    Cloud
    |
    /**
     * Indicates the data source is remote.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.CloudSync.Client"
    ]
    Remote
    | ...

    func getValue(): Int32 {
        match (this) {
            case Local => 0
            case Cloud => 1
            case Remote => 2
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

const E_INNER_ERROR: Int32 = 14800000
const E_BASE: Int32 = 27394048
const E_NOT_SELECT: Int32 = (E_BASE + 7)
const E_COLUMN_OUT_RANGE: Int32 = (E_BASE + 8)
const E_INVALID_FILE_PATH: Int32 = (E_BASE + 11)
const E_ROW_OUT_RANGE: Int32 = (E_BASE + 13)
const E_NO_ROW_IN_QUERY: Int32 = (E_BASE + 18)
const E_ALREADY_CLOSED: Int32 = (E_BASE + 30)
const E_DATABASE_BUSY: Int32 = (E_BASE + 34)
const E_WAL_SIZE_OVER_LIMIT: Int32 = (E_BASE + 47)
const E_GET_DATAOBSMGRCLIENT_FAIL: Int32 = (E_BASE + 50)
const E_TYPE_MISMATCH: Int32 = (E_BASE + 51)
const E_SQLITE_FULL: Int32 = (E_BASE + 52)
const E_ATTACHED_DATABASE_EXIST: Int32 = (E_BASE + 54)
const E_SQLITE_ERROR: Int32 = (E_BASE + 55)
const E_SQLITE_CORRUPT: Int32 = (E_BASE + 56)
const E_SQLITE_ABORT: Int32 = (E_BASE + 58)
const E_SQLITE_PERM: Int32 = (E_BASE + 59)
const E_SQLITE_BUSY: Int32 = (E_BASE + 60)
const E_SQLITE_LOCKED: Int32 = (E_BASE + 61)
const E_SQLITE_NOMEM: Int32 = (E_BASE + 62)
const E_SQLITE_READONLY: Int32 = (E_BASE + 63)
const E_SQLITE_IOERR: Int32 = (E_BASE + 64)
const E_SQLITE_CANTOPEN: Int32 = (E_BASE + 65)
const E_SQLITE_TOOBIG: Int32 = (E_BASE + 66)
const E_SQLITE_CONSTRAINT: Int32 = (E_BASE + 67)
const E_SQLITE_MISMATCH: Int32 = (E_BASE + 68)
const E_SQLITE_MISUSE: Int32 = (E_BASE + 69)
const E_CONFIG_INVALID_CHANGE: Int32 = (E_BASE + 70)
const MEMORY_ERROR: Int32 = -1
let ERROR_CODE_MAP = HashMap<Int32, (Int32, String)>(
    [
        (14801001, (14801001, "Only supported in stage mode.")),
        (14801002, (14801002, "The data group id is invalid.")),
        (E_NOT_SELECT, (14800019, "The SQL must be a query statement.")),
        (E_COLUMN_OUT_RANGE, (14800013, "Column out of bounds.")),
        (E_INVALID_FILE_PATH, (14800010, "Invalid database path.")),
        (E_ROW_OUT_RANGE, (14800012, "Row out of bounds.")),
        (E_NO_ROW_IN_QUERY, (14800012, "No data meets the condition.")),
        (E_ALREADY_CLOSED, (14800014, "Already closed.")),
        (E_DATABASE_BUSY, (14800015, "The database does not respond.")),
        (E_WAL_SIZE_OVER_LIMIT, (14800047, "The WAL file size over default limit.")),
        (E_GET_DATAOBSMGRCLIENT_FAIL, (14801050, "Failed to get DataObsMgrClient.")),
        (E_TYPE_MISMATCH, (14800051, "The type of the distributed table does not match.")),
        (E_SQLITE_FULL, (14800029, "SQLite: The database is full.")),
        (E_ATTACHED_DATABASE_EXIST, (14800016, "The database is already attached.")),
        (E_SQLITE_ERROR, (14800021, "SQLite: Generic error.")),
        (E_SQLITE_CORRUPT, (14800011, "Database corrupted.")),
        (E_SQLITE_ABORT, (14800022, "SQLite: Callback routine requested an abort.")),
        (E_SQLITE_PERM, (14800023, "SQLite: Access permission denied.")),
        (E_SQLITE_BUSY, (14800024, "SQLite: The database file is locked.")),
        (E_SQLITE_LOCKED, (14800025, "SQLite: A table in the database is locked.")),
        (E_SQLITE_NOMEM, (14800026, "SQLite: The database is out of memory.")),
        (E_SQLITE_READONLY, (14800027, "SQLite: Attempt to write a readonly database.")),
        (E_SQLITE_IOERR, (14800028, "SQLite: Some kind of disk I/O error occurred.")),
        (E_SQLITE_CANTOPEN, (14800030, "SQLite: Unable to open the database file.")),
        (E_SQLITE_TOOBIG, (14800031, "SQLite: TEXT or BLOB exceeds size limit.")),
        (E_SQLITE_CONSTRAINT, (14800032, "SQLite: Abort due to constraint violation.")),
        (E_SQLITE_MISMATCH, (14800033, "SQLite: Data type mismatch.")),
        (E_SQLITE_MISUSE, (14800034, "SQLite: Library used incorrectly.")),
        (E_CONFIG_INVALID_CHANGE, (14800017, "Config changed.")),
        (MEMORY_ERROR, (E_INNER_ERROR, "Instance invalid."))
    ]
)

func getErrorMsg(code: Int32): String {
    if (let Some(v) <- getUniversalErrorMsg(code)) {
        return v
    } else if (ERROR_CODE_MAP.contains(code)) {
        return ERROR_CODE_MAP[code][1]
    } else {
        return "Inner error. Inner code is ${code % E_INNER_ERROR}"
    }
}

func getErrorCode(code: Int32): Int32 {
    if (UNIVERSAL_ERROR_MAP.contains(code)) {
        return code
    } else if (ERROR_CODE_MAP.contains(code)) {
        return ERROR_CODE_MAP[code][0]
    } else {
        return E_INNER_ERROR
    }
}

func freeCStringArray(columnsArray: CPointer<CString>, i: Int64): Unit {
    if (columnsArray.isNull()) {
        return
    }
    for (j in 0..i) {
        unsafe { LibC.free(columnsArray.read(j)) }
    }
}

func freeValuesArray(valuesArray: CPointer<RetValueType>, i: Int64): Unit {
    if (valuesArray.isNull()) {
        return
    }
    for (j in 0..i) {
        unsafe { valuesArray.read(j).free() }
    }
}

func freeValuesBucketArray(arr: CPointer<CValuesBucket>, i: Int64): Unit {
    if (arr.isNull()) {
        return
    }
    for (j in 0..i) {
        unsafe { arr.read(j).free() }
    }
}

func createFieldValue(field: String, value: String, funcName: String): (CString, CString) {
    let cfield = mallocCString(field)
    let cvalue = mallocCString(value)
    if (let Some(cFieldStr) <- cfield && let Some(cValueStr) <- cvalue) {
        return (cFieldStr, cValueStr)
    }
    if (let Some(cFieldStr) <- cfield) {
        unsafe { LibC.free(cFieldStr) }
    }
    if (let Some(cValueStr) <- cvalue) {
        unsafe { LibC.free(cValueStr) }
    }
    RELATIONAL_STORE_LOG.error("RdbPredicates ${funcName} failed: ${getErrorMsg(MEMORY_ERROR)}")
    throw BusinessException(getErrorCode(MEMORY_ERROR), "RdbPredicates ${funcName} failed: ${getErrorMsg(MEMORY_ERROR)}")
}

func paramError(needed: String, mustbe: String): String {
    return "Parameter error. The " + needed + " must be " + mustbe + "."
}

func throwIfNotSuccess(code: Int32, className: String, funcName: String): Unit {
    if (code != SUCCESS_CODE) {
        throw BusinessException(getErrorCode(code), "${className} ${funcName} failed: ${getErrorMsg(code)}")
    }
}

func throwIfNotSuccess(code: Int32, funcName: String): Unit {
    if (code != SUCCESS_CODE) {
        throw BusinessException(getErrorCode(code), "${funcName} failed: ${getErrorMsg(code)}")
    }
}

func throwIfOOM(isOOM: Bool, funcName: String): Unit {
    if (isOOM) {
        throw BusinessException(getErrorCode(MEMORY_ERROR), "${funcName} failed: ${getErrorMsg(MEMORY_ERROR)}")
    }
}

func throwIfOOM(isOOM: Bool, className: String, funcName: String): Unit {
    if (isOOM) {
        throw BusinessException(getErrorCode(MEMORY_ERROR),
            "${className} ${funcName} failed: ${getErrorMsg(MEMORY_ERROR)}")
    }
}

func throwIfOOM(isOOM: Bool, className: String, funcName: String, handler: () -> Unit): Unit {
    if (isOOM) {
        handler()
        throw BusinessException(getErrorCode(MEMORY_ERROR),
            "${className} ${funcName} failed: ${getErrorMsg(MEMORY_ERROR)}")
    }
}
