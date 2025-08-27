# distributeddatamgr_cangjie_wrapper

## Introduction

The distributeddatamgr_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the capabilities of the DistributedDataManager Subsystem. The **DistributedDataManager** subsystem implements persistence of a variety of structured data on a single device and data sync and sharing across devices. It allows application data to be seamlessly processed across devices, ensuring consistent user experience for the same application across devices.

The following figure shows the architecture of the **DistributedDataManager** subsystem.

**Figure 1** Architecture

![](figures/distributeddatamgr_cangjie_wrapper_architecture_en.png)

## Directory Structure

Level 1 and 2 directories of the **DistributedDataManager** subsystem:

```
foundation/distributeddatamgr/distributeddatamgr_cangjie_wrapper
├── ohos             # Cangjie DistributedDataManager code
├── kit              # Cangjie kit code
├── figures          # architecture pictures
```

## Constraints

The distributeddatamgr cangjie interface currently under development only supports standard devices.

## Usage

The distributeddatamgr_cangjie_wrapper provides the following capabilities:

-   DataShare Predicates.
-   Distributed KV Store.
-   User Preferences.
-   RDB Store.
-   Value Bucket.

Compared to ArkTS, the following features are currently not supported:

-   Common Data Types.
-   DataAbility Predicates.
-   DataShare.
-   Distributed Data Object.
-   Shared User Preferences.
-   Shared RDB Store.
-   Unified Data Channel.
-   Uniform Data Structs.
-   Uniform Data Definition and Description.
-   ArkData Intelligence Platform.
-   DataShare ExtensionAbility.
-   Device-Cloud Service.
-   Device-Cloud Sharing Extension.
-   DataShare Result Set.

For distributeddatamgr APIs, please refer to
1. [ohos.data.data_share_predicates](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-data_share_predicates.md)。
2. [ohos.data.distributed_kv_store](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-distributed_kv_store.md)。
3. [ohos.data.preferences](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-preferences.md)。
4. [ohos.data.relational_store](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-relational_store.md)。
5. [ohos.data.values_bucket](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-values_bucket.md)。

For relevation guidance, please refer to [Database Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/database)。

## Component Description

### KV Store

The distributed KV store provides distributed collaboration of KV stores across devices. By calling the APIs of **distributedKVStore**, applications can save data to distributed KV stores and perform operations, such as adding, deleting, modifying, querying, and synchronizing data in distributed KV stores.

The **distributedKVStore** module provides the following functions:

- KVManager: provides a **KVManager** instance for obtaining KV store information.
- KVStoreResultSet: provides APIs for accessing the result obtained from a KV store.
- Query: provides APIs for setting predicates for data query.
- SingleKVStore: provides APIs for querying and syncing data in single KV stores, which manage data without distinguishing devices.
- DeviceKVStore: provides APIs for querying and syncing data in device KV stores, which inherit from SingleKVStore and manage data by device.

### Preferences

The **Preferences** module allows quick access to data in KV pairs and storage of a small amount of data for local applications. The data is stored in local files in KV pairs and loaded in memory, which allows for faster access and higher processing efficiency. **Preferences** provides non-relational data storage and is not suitable for storing a large amount of data.

1.  The **Preferences** module provides APIs for **preferences** operations.
2.  You can use **getPreferences()** to load the data of a file to a **Preferences** instance. Each file has only one **Preferences** instance. The system stores the instance data in memory through a static container until the application removes the instance from the memory or deletes the file.
3.  After obtaining a **Preferences** instance, the application can call **Preferences** APIs to read data from or write data to the **Preferences** instance, and call **flush()** to save the instance data to a file.

### RDB Store

The RDB store manages data based on relational models. The OpenHarmony RDB store provides a complete mechanism for managing a local database based on the underlying SQLite.

With the SQLite as the persistence engine, the RDB store supports all SQLite features, including transactions, indexes, views, triggers, foreign keys, parameterized queries, prepared SQL statements, and more.

### UDMF

The UDMF provides standard data channels for many-to-many data sharing across applications and provides standard APIs for data access. It also provides standard definitions for data types, such as text and image, to streamline data interaction between different applications and minimize the workload of data type adaptation.

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[distributeddatamgr\_data_share](https://gitee.com/openharmony/distributeddatamgr_data_share)

[distributeddatamgr\_kv_store](https://gitee.com/openharmony/distributeddatamgr_kv_store)

[distributeddatamgr\_preferences](https://gitee.com/openharmony/distributeddatamgr_preferences)

[distributeddatamgr\_relational_store](https://gitee.com/openharmony/distributeddatamgr_relational_store)
