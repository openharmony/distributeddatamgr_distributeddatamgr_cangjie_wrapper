# distributeddatamgr_cangjie_wrapper

## Introduction

The distributeddatamgr_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the capabilities of the DistributedDataManager Subsystem. The DistributedDataManager subsystem implements persistence of a variety of structured data on a single device and data sync and sharing across devices. It allows application data to be seamlessly processed across devices, ensuring consistent user experience for the same application across devices.The distributeddatamgr cangjie interface currently under development only supports standard devices.

## System Architecture

![Architecture of the distributeddatamgr_cangjie_wrapper](figures/distributeddatamgr_cangjie_wrapper_architecture_en.png)

**Figure 1** Architecture of the distributeddatamgr_cangjie_wrapper

As shown in the architecture diagram:

- DataShare Predicates: Provide data sharing predicates for implementing different query methods.
- Distributed KV Store: Provide distributed collaboration capabilities for databases between different devices.
- User Preferences: Provide Key-Value type data processing capabilities.
- RDB Store: Provide a complete mechanism for managing local databases.
- Value Bucket: Provide a collection of data to be inserted into the database.
- Cangjie distributed data management FFI interface definition: Define C language interoperability Cangjie interfaces, used to implement Cangjie distributed data management capabilities.
- data_share: Provide data sharing predicate capabilities, encapsulating C interfaces for interoperation with Cangjie.
- kv_store: Provide distributed collaboration capabilities for databases between different devices, encapsulating C interfaces for interoperation with Cangjie.
- preferences: Provide Key-Value type data processing capabilities, encapsulating C interfaces for interoperation with Cangjie.
- relational_store: Provide local database management mechanisms, encapsulating C interfaces for interoperation with Cangjie.
- ability_cangjie_wrapper: Responsible for providing UiAbilityContext, which is used to access the current application's database resources.
- hiviewdfx_cangjie_wrapper: Provides logging interfaces for printing logs on critical paths.
- cangjie_ark_interop: Provides Cangjie annotation definitions for API annotation and BusinessException exception class definition for user-facing exceptions.

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
