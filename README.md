# distributeddatamgr_distributeddatamgr_cangjie_wrapper

## Introduction

The distributeddatamgr_distributeddatamgr_cangjie_wrapper is a capability provided on OpenHarmony for developers using the Cangjie programming language to develop applications. It enables the persistence of various structured data, as well as the synchronization and sharing of data across devices. By leveraging the Cangjie-encapsulated distributed data management, developers can easily achieve seamless connection of application data across different terminal devices, satisfying users' need for a consistent experience when using data across devices.The distributeddatamgr_distributeddatamgr_cangjie_wrapper currently under development only supports standard devices.

## System Architecture

**Figure 1** distributeddatamgr_cangjie_wrapper architecture

![Architecture of the distributeddatamgr_distributeddatamgr_cangjie_wrapper](figures/distributeddatamgr_cangjie_wrapper_architecture_en.png)

As shown in the architecture diagram:

Interface Layer:
- DataShare Predicates: Provides developers with data sharing predicates for implementing different query methods.
- Distributed KV Store: Offers developers the capability to manage key-value pair data.
- User Preferences: Supplies developers with lightweight Key-Value operations, supporting local applications in storing small amounts of data.
- RDB Store: Provides developers with a complete mechanism for managing local databases based on the SQLite component.
- Value Bucket: Gives developers data collections that can be inserted into the database.

Framework Layer:
- DataShare Predicates Wrapper: Based on the underlying data_share, it implements predicates—filter conditions used for querying data in the database. Predicates can be used to update, delete, and query data.
- Distributed KV Store Wrapper: Built on the underlying kv_store, it enables distributed collaboration capabilities for databases across different devices. It allows data to be stored in the distributed key-value database and supports operations such as adding, deleting, modifying, querying, and end-to-end synchronization of data in the distributed key-value database.
- User Preferences Wrapper: Relying on the underlying preferences, it realizes Key-Value data processing capabilities, supporting persistent storage of lightweight data as well as modification and query of such data.
- RDB Store Wrapper: Based on the underlying relational_store, it implements a database that manages data using a relational model. It provides a series of interfaces for adding, deleting, modifying, and querying data, and also allows direct execution of user-input SQL statements to meet the needs of complex scenarios.
- Value Bucket Wrapper: Implements data collections that Cangjie applications can insert into the database.

Dependencies Introduction in Architecture:
- data_share: The DataShare Predicates Wrapper depends on the data_share, which is used to implement the filter conditions for querying data in the database.
- kv_store: The Distributed KV Store Wrapper relies on the kv_store to achieve distributed collaboration capabilities for databases across different devices.
- preferences: The User Preferences Wrapper depends on the preferences, which is used to implement lightweight local Key-Value data processing capabilities.
- relational_store: The RDB Store Wrapper relies on the relational_store to implement the local relational database management mechanism.
- ability_cangjie_wrapper: The Distributed KV Store Wrapper, User Preferences Wrapper, and RDB Store Wrapper depend on the application context capability of ability_cangjie_wrapper, which is used for accessing database resources of the current application, among other purposes.
- hiviewdfx_cangjie_wrapper: Depends on HiLog capabilities for printing logs at key points.
- cangjie_ark_interop: Depends on APILevel class definitions and BusinessException class definitions for API annotation and throwing exceptions to users in error branches.

## Directory Structure

The directory structure is as follows:

```
foundation/communication/netmanager_cangjie_wrapper
├── figures          # architecture pictures
├── kit              # Cangjie kit code
│   └── ArkData      # ArkData module implementation
└── ohos             # Cangjie distributed data management interface implementation
│   └── data
│       ├── data_share_predicates     # Data share predicates module
│       ├── distributed_kv_store      # Distributed key-value database module
│       ├── preferences               # User preferences module
│       ├── relational_store          # Relational database module
│       └── values_bucket             # Value bucket module
└── test             # Cangjie distributed data management test cases
    ├── data_share_predicates # Data share predicates test cases
    ├── distributed_kv_store  # Distributed key-value database test cases
    ├── preferences           # User preferences test cases
    └── relational_store      # Relational database test cases
```

## Usage

As shown in the architecture diagram, the distributed data management Cangjie API provides the following functions. Developers can comprehensively use one or more types of interfaces according to their needs:

- DataShare Predicates.
- Distributed KV Store.
- User Preferences.
- RDB Store.
- Value Bucket.

Compared to ArkTS API, the following functions are not supported:

- Common Data Types.
- DataAbility Predicates.
- DataShare.
- Distributed Data Object.
- Shared User Preferences.
- Shared RDB Store.
- Unified Data Channel.
- Uniform Data Structs.
- Uniform Data Definition and Description.
- ArkData Intelligence Platform.
- DataShare ExtensionAbility.
- Device-Cloud Service.
- Device-Cloud Sharing Extension.
- DataShare Result Set.

For distributed data management related APIs, please refer to:

1. [ohos.data.data_share_predicates](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-data_share_predicates.md)
2. [ohos.data.distributed_kv_store](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-distributed_kv_store.md)
3. [ohos.data.preferences](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-preferences.md)
4. [ohos.data.relational_store](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-relational_store.md)
5. [ohos.data.values_bucket](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-values_bucket.md)

For related guidance, please refer to [Distributed Data Management Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/database)

## Constraints

Compared to ArkTS API, the following functions are not supported:

- Common Data Types.
- DataAbility Predicates.
- DataShare.
- Distributed Data Object.
- Shared User Preferences.
- Shared RDB Store.
- Unified Data Channel.
- Uniform Data Structs.
- Uniform Data Definition and Description.
- ArkData Intelligence Platform.
- DataShare ExtensionAbility.
- Device-Cloud Service.
- Device-Cloud Sharing Extension.
- DataShare Result Set.
- Pasteboard.

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[ability_ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[distributeddatamgr_data_share](https://gitee.com/openharmony/distributeddatamgr_data_share)

[distributeddatamgr_kv_store](https://gitee.com/openharmony/distributeddatamgr_kv_store)

[distributeddatamgr_preferences](https://gitee.com/openharmony/distributeddatamgr_preferences)

[distributeddatamgr_relational_store](https://gitee.com/openharmony/distributeddatamgr_relational_store)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)
