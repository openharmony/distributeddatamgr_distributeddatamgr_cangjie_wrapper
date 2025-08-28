# 分布式数据管理仓颉接口

## 简介

**内容介绍**

分布式数据管理仓颉接口是在 OpenHarmony 上基于分布式数据管理子系统能力之上封装的仓颉API。分布式数据管理子系统支持单设备的各种结构化数据的持久化，以及跨设备之间数据的同步、共享功能。开发者通过分布式数据管理仓颉，能够方便地完成应用程序数据在不同终端设备间的无缝衔接，满足用户跨设备使用数据的一致性体验。


**分布式数据管理仓颉接口架构**

**图 1**  分布式数据管理仓颉接口架构图

![](figures/distributeddatamgr_cangjie_wrapper_architecture.png)

## 目录

分布式数据管理仓颉接口目录描述

```
foundation/distributeddatamgr/distributeddatamgr_cangjie_wrapper
├── ohos             # 仓颉分布式数据管理接口实现
├── kit              # 仓颉kit化代码
├── figures          # 存放readme中的架构图
```

## 约束

当前开发的分布式数据管理仓颉接口仅支持standard设备。

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
1. [ohos.data.data_share_predicates](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-data_share_predicates.md)。
2. [ohos.data.distributed_kv_store](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-distributed_kv_store.md)。
3. [ohos.data.preferences](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-preferences.md)。
4. [ohos.data.relational_store](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-relational_store.md)。
5. [ohos.data.values_bucket](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-values_bucket.md)。

相关指导请参见[分布式数据管理开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/database)。

## 组件说明

### Key-Value数据库

**分布式键值数据库(kv Store)** 为应用程序提供不同设备间数据库的分布式协同能力。通过调用分布式键值数据库各个接口，应用程序可将数据保存到分布式键值数据库中，并可对分布式键值数据库中的数据进行增加、删除、修改、查询、同步等操作。

该模块提供以下分布式键值数据库相关的常用功能：

- KVManager：分布式键值数据库管理实例，用于获取数据库的相关信息。
- KVStoreResultSet：提供获取数据库结果集的相关方法，包括查询和移动数据读取位置等。
- Query：使用谓词表示数据库查询，提供创建Query实例、查询数据库中的数据和添加谓词的方法。
- SingleKVStore：单版本分布式键值数据库，不对数据所属设备进行区分，提供查询数据和同步数据的方法。
- DeviceKVStore：设备协同数据库，继承自SingleKVStore，以设备维度对数据进行区分，提供查询数据和同步数据的方法。

### 首选项

**首选项（Preferences）** 主要提供轻量级Key-Value操作，支持本地应用存储少量数据，数据存储在本地文件中，同时也加载在内存中，所以访问速度更快，效率更高。首选项提供非关系型数据存储，不宜存储大量数据，经常用于操作键值对形式数据的场景。

1.  本模块提供首选项的操作类，应用通过这些操作类完成首选项操作。
2.  借助getPreferences，可以将指定文件的内容加载到Preferences实例，每个文件最多有一个Preferences实例，系统会通过静态容器将该实例存储在内存中，直到主动从内存中移除该实例或者删除该文件。
3.  获取Preferences实例后，可以借助Preferences类的函数，从Preferences实例中读取数据或者将数据写入Preferences实例，通过flush将Preferences实例持久化。

### 关系型数据库

**关系型数据库（Relational Database，RDB）** 是一种基于关系模型来管理数据的数据库。OpenHarmony关系型数据库基于SQLite组件提供了一套完整的对本地数据库进行管理的机制。

OpenHarmony关系型数据库底层使用SQLite作为持久化存储引擎，支持SQLite具有的所有数据库特性，包括但不限于事务、索引、视图、触发器、外键、参数化查询和预编译SQL语句。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[distributeddatamgr\_data_share](https://gitee.com/openharmony/distributeddatamgr_data_share/blob/master/README_zh.md)

[distributeddatamgr\_kv_store](https://gitee.com/openharmony/distributeddatamgr_kv_store/blob/master/README_zh.md)

[distributeddatamgr\_preferences](https://gitee.com/openharmony/distributeddatamgr_preferences/blob/master/README_zh.md)

[distributeddatamgr\_relational_store](https://gitee.com/openharmony/distributeddatamgr_relational_store/blob/master/README_zh.md)
