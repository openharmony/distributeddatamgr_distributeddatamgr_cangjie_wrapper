# distributeddatamgr_distributeddatamgr_cangjie_wrapper

## Introduction

The distributeddatamgr_distributeddatamgr_cangjie_wrapper provides persistence of various structured data and synchronization and sharing functions of data between different devices for developers using the Cangjie language for application development on OpenHarmony. The distributeddatamgr_distributeddatamgr_cangjie_wrapper currently under development only supports standard devices.

## System Architecture

**Figure 1** distributeddatamgr_cangjie_wrapper architecture

![Architecture of the distributeddatamgr_distributeddatamgr_cangjie_wrapper](figures/distributeddatamgr_cangjie_wrapper_architecture_en.png)

As shown in the architecture diagram:

Interface Layer:
- DataShare Predicates: Provides developers with filtering conditions used to query data in databases, including comparison predicate equal conditions, logical predicate AND conditions, range predicate contains conditions, and ascending and descending sorting of result sets.
- Distributed KV Store: Provides developers with distributed collaboration capabilities of databases between different devices, enabling data to be saved to distributed key-value databases, and allowing operations such as adding, deleting, modifying, querying, and end-to-end synchronization of data in distributed key-value databases.
- User Preferences: Provides developers with Key-Value type data processing capabilities, supporting application persistence of lightweight data, and modification and query of such data.
- RDB Store: Provides developers with a complete mechanism based on SQLite components for managing local databases, offering a series of interfaces for adding, deleting, modifying, and querying, and also supporting direct execution of user-input SQL statements.
- Value Bucket: Provides developers with a data collection that can be inserted into databases.

Framework Layer:
- DataShare Predicates Wrapper: Implements data share predicates wrapper based on the underlying data sharing component, providing data share predicates for different query methods.
- Distributed KV Store Wrapper: Implements distributed key-value database wrapper based on the underlying KV database component, providing key-value pair data management capabilities.
- User Preferences Wrapper: Implements preferences wrapper based on the underlying preferences component, providing lightweight Key-Value operations and supporting local applications to store small amounts of data.
- RDB Store Wrapper: Implements relational database wrapper based on the underlying relational database component, providing a database that manages data based on the relational model.
- Value Bucket Wrapper: Implements a data collection that can be inserted into databases.

Dependencies Introduction in Architecture:
- data_share: The DataShare Predicates Wrapper depends on the data_share, which is used to implement filtering conditions for querying data in databases.
- kv_store: The Distributed KV Store Wrapper relies on the kv_store implement distributed collaboration capabilities of databases between different devices.
- preferences: The User Preferences Wrapper depends on the preferences, which is used to implement lightweight local Key-Value type data processing capabilities.
- relational_store: The RDB Store Wrapper relies on the relational_store to implement local relational database management mechanisms.
- ability_cangjie_wrapper: The Distributed KV Store Wrapper, User Preferences Wrapper, and RDB Store Wrapper depend on the application context capability of ability_cangjie_wrapper, which is used for accessing database resources of the current application, among other purposes.
- hiviewdfx_cangjie_wrapper: Framework Layer depends on HiLog capabilities for printing logs at key points.
- cangjie_ark_interop: Framework Layer depends on APILevel class definitions and BusinessException class definitions for API annotation and throwing exceptions to users in error branches.

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

The distributeddatamgr_distributeddatamgr_cangjie_wrapper provides the following functions:

- DataShare Predicates.
- Distributed KV Store.
- User Preferences.
- RDB Store.
- Value Bucket.

For distributed data management related APIs, please refer to:

1. [ohos.data.data_share_predicates](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-data_share_predicates.md)
2. [ohos.data.distributed_kv_store](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-distributed_kv_store.md)
3. [ohos.data.preferences](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-preferences.md)
4. [ohos.data.relational_store](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-relational_store.md)
5. [ohos.data.values_bucket](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ArkData/cj-apis-values_bucket.md)

For related guidance, please refer to [Distributed Data Management Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/database)

## Constraints

Compared to ArkTS API，the following functions are not supported:

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
- Device-Cloud Service.

RDB Store does not currently support the following functions:
  - Transactions.

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[ability_ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[distributeddatamgr\_data_share](https://gitcode.com/openharmony/distributeddatamgr_data_share)

[distributeddatamgr\_kv_store](https://gitcode.com/openharmony/distributeddatamgr_kv_store)

[distributeddatamgr\_preferences](https://gitcode.com/openharmony/distributeddatamgr_preferences)

[distributeddatamgr\_relational_store](https://gitcode.com/openharmony/distributeddatamgr_relational_store)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)
