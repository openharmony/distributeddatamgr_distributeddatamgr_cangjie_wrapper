# 分布式数据管理仓颉接口

## 简介

分布式数据管理仓颉接口是在 OpenHarmony 上基于分布式数据管理子系统能力之上封装的仓颉API。分布式数据管理子系统支持单设备的各种结构化数据的持久化，以及跨设备之间数据的同步、共享功能。开发者通过分布式数据管理仓颉，能够方便地完成应用程序数据在不同终端设备间的无缝衔接，满足用户跨设备使用数据的一致性体验。当前开发的分布式数据管理仓颉接口仅支持standard设备。

## 系统架构

![分布式数据管理仓颉接口架构图](figures/distributeddatamgr_cangjie_wrapper_architecture.png)

**图 1**  分布式数据管理仓颉接口架构图

如架构图所示：

-   数据共享谓词：提供用于不同实现不同查询方法的数据共享谓词。
-   分布式键值数据库：提供不同设备间数据库的分布式协同能力。
-   用户首选项：提供Key-Value键值型的数据处理能力。
-   关系型数据库：提供了一套完整的对本地数据库进行管理的机制。
-   数据集：提供向数据库插入的数据集合。
-   分布式数据管理FFI接口定义：定义C互操作仓颉接口，用于实现仓颉分布式数据管理能力。
-   数据共享部件：提供数据共享谓词能力，封装C接口提供给仓颉进行互操作。
-   KV数据库部件：提供不同设备间数据库的分布式协同能力 ，封装C接口提供给仓颉进行互操作。
-   首选项部件：提供Key-Value键值型的数据处理能力，封装C接口提供给仓颉进行互操作。
-   关系型数据库部件：提供本地数据库管理机制，封装C接口提供给仓颉进行互操作。

## 目录

仓目录结构如下：

```
foundation/communication/netmanager_cangjie_wrapper
├── figures          # 存放README中的架构图
├── kit              # 仓颉kit化代码
│   └── ArkData
└── ohos             # 仓颉分布式数据管理接口实现
│   └── data
└── test             # 测试代码
```

## 使用说明

如架构图所示，分布式数据管理仓颉接口提供了以下功能，开发者可以根据使用诉求，综合使用一类或多类接口：

-   数据共享谓词。
-   分布式键值数据库。
-   用户首选项。
-   关系型数据库。
-   数据集。

与ArkTS相比，暂不支持以下功能：

-   数据通用类型。
-   DataAbility谓词。
-   数据共享。
-   分布式数据对象。
-   共享用户首选项。
-   共享关系型数据库。
-   标准化数据通路。
-   标准化数据结构。
-   标准化数据定义与描述。
-   智慧数据平台。
-   数据共享扩展能力。
-   端云服务。
-   端云共享Extension。
-   数据共享结果集。

分布式数据管理相关API请参见
1. [ohos.data.data_share_predicates](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-data_share_predicates.md)
2. [ohos.data.distributed_kv_store](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-distributed_kv_store.md)
3. [ohos.data.preferences](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-preferences.md)
4. [ohos.data.relational_store](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-relational_store.md)
5. [ohos.data.values_bucket](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-values_bucket.md)

相关指导请参见[分布式数据管理开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/database)

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[distributeddatamgr\_data_share](https://gitee.com/openharmony/distributeddatamgr_data_share/blob/master/README_zh.md)

[distributeddatamgr\_kv_store](https://gitee.com/openharmony/distributeddatamgr_kv_store/blob/master/README_zh.md)

[distributeddatamgr\_preferences](https://gitee.com/openharmony/distributeddatamgr_preferences/blob/master/README_zh.md)

[distributeddatamgr\_relational_store](https://gitee.com/openharmony/distributeddatamgr_relational_store/blob/master/README_zh.md)
