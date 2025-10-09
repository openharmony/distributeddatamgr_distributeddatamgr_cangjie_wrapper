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

import ohos.app.ability.BaseContext
import ohos.labels.*
import ohos.business_exception.getUniversalErrorMsg

import std.collection.*

/**
 * KVStore constants
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
]
public class Constants {
    /**
     * Max key length is 1024.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public static let MAX_KEY_LENGTH: Int32 = 1024

    /**
     * Max value length is 4194303.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public static let MAX_VALUE_LENGTH: Int32 = 4194303

    /**
     * Max device coordinate key length is 896.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public static let MAX_KEY_LENGTH_DEVICE: Int32 = 896

    /**
     * Max store id length is 128.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public static let MAX_STORE_ID_LENGTH: Int32 = 128

    /**
     * Max query length is 512000.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public static let MAX_QUERY_LENGTH: Int32 = 512000

    /**
     * Max batch operation size is 128.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public static let MAX_BATCH_SIZE: Int32 = 128

    protected init() {}
}

/**
 * Indicates the {@code KVValueType}.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
]
public enum KVValueType {
    /**
     * Indicates that the value type is string.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    StringValue(String)
    |
    /**
     * Indicates that the value type is int.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    Integer(Int32)
    |
    /**
     * Indicates that the value type is float.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    Float(Float32)
    |
    /**
     * Indicates that the value type is byte array.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    ByteArray(Array<Byte>)
    |
    /**
     * Indicates that the value type is boolean.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    Boolean(Bool)
    |
    /**
     * Indicates that the value type is double.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    Double(Float64)
    | ...
}

/**
 * Provides configuration information to create a {@link KVManager} instance,
 * which includes the caller's package name and ability or hap context.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
]
public class KVManagerConfig {
    /**
     * Indicates the ability or hap context
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public var context: BaseContext

    /**
     * Indicates the bundleName
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public var bundleName: String

    /**
     * KVManagerConfig constructor.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public init(context: BaseContext, bundleName: String) {
        this.context = context
        this.bundleName = bundleName
    }
}

enum KVStoreType {
    | DeviceCollaboration
    | SingleVersion

    func getValue(): Int32 {
        match (this) {
            case DeviceCollaboration => 0
            case SingleVersion => 1
        }
    }
}

/**
 * Describes the KVStore security level.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
]
public enum KVSecurityLevel {
    /**
     * S1: means the db is in the low security level
     * There are some low impact when the data is leaked.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    S1
    |
    /**
     * S2: means the db is in the middle security level
     * There are some major impact when the data is leaked.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    S2
    |
    /**
     * S3: means the db is in the high security level
     * There are some severity impact when the data is leaked.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    S3
    |
    /**
     * S4: means the db is in the critical security level
     * There are some critical impact when the data is leaked.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    S4
    | ...

    static func parse(securityLevel: Int32): KVSecurityLevel {
        match (securityLevel) {
            case 2 => S1
            case 3 => S2
            case 5 => S3
            case 6 => S4
            case _ => throw IllegalArgumentException("The type is not supported yet.")
        }
    }

    func getValue(): Int32 {
        match (this) {
            case S1 => 2
            case S2 => 3
            case S3 => 5
            case S4 => 6
            case _ => throw IllegalArgumentException("The type is not supported yet.")
        }
    }
}


/**
 * Represents a node of a {@link Schema} instance.
 * <p>With a {@link Schema} instance, you can define the value fields which stored in the database.
 * <p>A FieldNode of the {@link Schema} instance is either a leaf or a non-leaf node.
 * <p>The leaf node must have a value; the non-leaf node must have a child {@code FieldNode}.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
]
public class FieldNode {
    /**
     * Indicates the nullable of database field.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
    ]
    public var nullable: Bool

    /**
     * Indicates the default value of field node.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
    ]
    public var default: String

    /**
     * Indicates the type of value.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
    ]
    public var nodeType: Int32

    /**
     * FieldNode constructor.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
    ]
    public init(name: String, nullable: Bool, default: String, nodeType: Int32) {
        this.nullable = nullable
        this.default = default
        this.nodeType = nodeType
    }
}

/**
 * Represents the database schema.
 * You can set the schema object in options when create or open the database.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
]
public class Schema {
    /**
     * Indicates the root json object.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
    ]
    public var root: FieldNode

    /**
     * Indicates the string array of json.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
    ]
    public var indexes: Array<String>

    /**
     * Indicates the mode of schema.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
    ]
    public var mode: Int32

    /**
     * Indicates the skip size of schema.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
    ]
    public var skip: Int32

    /**
     * Schema constructor.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
    ]
    public init(root: FieldNode, indexes: Array<String>, mode: Int32, skip: Int32) {
        this.root = root
        this.indexes = indexes
        this.mode = mode
        this.skip = skip
    }
}

/**
 * Provides configuration options to create a {@code SingleKVStore} or {@code DeviceKVStore}.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
]
public class KVOptions {

    /**
     * Indicates whether to create a database when the database file does not exist
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public var createIfMissing: Bool

    /**
     * Indicates whether database files to be encrypted
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public var encrypt: Bool

    /**
     * Indicates whether to back up database files
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public var backup: Bool

    /**
     * Indicates whether database files are automatically synchronized
     */
    @!APILevel[
        22,
        permission: "ohos.permission.DISTRIBUTED_DATASYNC",
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public var autoSync: Bool

    /**
     * Indicates the database security level
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public var securityLevel: KVSecurityLevel

    /**
     * Indicates the database schema
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.DistributedKVStore"
    ]
    public var schema: ?Schema

    /**
     * KVOptions constructor.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public init(securityLevel: KVSecurityLevel, createIfMissing!: Bool = true, encrypt!: Bool = false,
        backup!: Bool = true, autoSync!: Bool = false, schema!: ?Schema = None) {
        this.createIfMissing = createIfMissing
        this.encrypt = encrypt
        this.backup = backup
        this.autoSync = autoSync
        this.securityLevel = securityLevel
        this.schema = schema
    }
}

/**
 * Provides key-value pairs stored in the distributedKVStore.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
]
public class Entry {
    /**
     * Indicates the key.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public var key: String

    /**
     * Indicates the value.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public var value: KVValueType

    /**
     * Entry constructor.
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.DistributedDataManager.KVStore.Core"
    ]
    public init(key: String, value: KVValueType) {
        this.key = key
        this.value = value
    }
}

let ERROR_CODE_MAP = HashMap<Int32, String>(
    [
        (15100001, "Over max limits."),
        (15100002, "Open existed database with changed options."),
        (15100003, "Database corrupted."),
        (15100004, "Not found."),
        (15100005, "Database or result set already closed.")
    ]
)

func getErrorCode(code: Int32): Int32 {
    if (code == -1) {
        15100003
    } else {
        code
    }
}

func getErrorMsg(code: Int32): String {
    let errCode = getErrorCode(code)
    if (let Some(v) <- getUniversalErrorMsg(errCode)) {
        return v
    } else if (ERROR_CODE_MAP.contains(errCode)) {
        return ERROR_CODE_MAP[errCode]
    } else {
        return "Unknown error code ${errCode}"
    }
}
