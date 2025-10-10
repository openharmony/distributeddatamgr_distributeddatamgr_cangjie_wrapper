# 分布式数据管理仓颉封装（beta特性）

## 简介

分布式数据管理仓颉封装是在OpenHarmony上面向开发者使用仓颉语言进行应用开发时提供的各种结构化数据持久化，以及跨设备之间数据的同步、共享功能。当前开发的分布式数据管理仓颉封装仅支持standard设备。

## 系统架构

**图 1**  分布式数据管理仓颉封装架构图

![分布式数据管理仓颉封装架构图](figures/distributeddatamgr_cangjie_wrapper_architecture.png)

如架构图所示：

接口层：

- 数据共享谓词：面向开发者提供数据查询筛选能力，支持构建复杂的查询条件。
  - 比较谓词：支持等于条件。
  - 逻辑谓词：支持与条件。
  - 范围谓词：支持包含条件。
  - 排序功能：支持结果集的递增和递减排序。
  - 其他功能：支持分页查询。

当开发者需要在不关注具体数据库类型的情况下检索数据时，数据共享谓词可作为通用的查询条件使用，例如[相册中图片和视频的检索](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/media/medialibrary/cj-photoAccessHelper-systemAlbum-guidelines.md)。

- 分布式键值数据库：面向开发者提供跨设备的分布式数据协同能力，支持在多个设备间实现数据的无缝同步与共享。
  - 数据库管理：支持数据库的创建、关闭、删除、获取所有已创建数据库的标识id。
  - 数据库操作：支持数据库的备份和恢复操作。
  - 数据操作：支持数据记录的增、删、改、查。
  - 事务支持：支持事务的启用、提交、回滚。
  - 数据订阅：支持订阅以及取消订阅指定类型的数据变更。
  - 同步功能：支持数据库的端到端同步。

- 用户首选项：面向开发者提供轻量级的Key-Value键值型数据处理能力，专门用于应用配置信息和用户偏好的持久化存储。
  - 数据库管理：支持数据库的获取、删除以及从缓存中移除。
  - 数据库操作：支持清空所有数据、获取所有数据以及数据持久化。
  - 数据操作：支持数据的写入、查找和删除。
  - 数据订阅：支持基于Key值或者Value值订阅以及取消订阅数据变更，持久化文件发生变更后回调触发。

- 关系型数据库：面向开发者提供一套基于SQLite组件的完整本地数据库管理机制，支持标准的关系型数据模型。
  - 数据库管理：支持数据库的创建、删除。
  - 数据库操作：支持数据库的备份和恢复操作。
  - 数据操作：提供数据记录的增、删、改、查。
  - SQL执行：支持直接执行用户自定义的SQL语句，当前仅支持通过SQL语句实现表的创建以及删除操作。

- 数据集：面向开发者提供标准化的数据字段类型枚举类，包括整型、浮点型、字符串型、布尔型。

框架层：

- 数据共享谓词封装：基于底层数据共享部件实现数据共享谓词封装，提供用于不同查询方法的数据共享谓词。
- 分布式键值数据库封装：基于底层KV数据库部件实现分布式键值数据库封装，提供键值对数据管理能力。
- 用户首选项封装：基于底层首选项部件实现用户首选项封装，提供轻量级Key-Value操作，支持本地应用存储少量数据。
- 关系型数据库封装：基于底层关系型数据库部件实现关系型数据库封装，提供一种基于关系模型来管理数据的数据库。
- 数据集封装：实现了标准化的数据字段类型枚举类。

架构图中依赖部件引入说明：

- 数据共享部件：数据共享谓词封装依赖数据共享部件，用于实现查询数据库中数据所使用的筛选条件。
- KV数据库部件：分布式键值数据库封装依赖KV数据库部件，用于实现不同设备间数据库的分布式协同能力。
- 首选项部件：用户首选项封装依赖首选项部件，用于实现轻量级的本地Key-Value键值型数据处理能力。
- 关系型数据库部件：关系型数据库封装依赖关系型数据库部件，用于实现本地关系型数据库管理机制。
- ability_cangjie_wrapper：分布式键值数据库封装、用户首选项封装以及关系型数据库封装依赖ability_cangjie_wrapper的应用上下文能力，用于访问当前应用的数据库资源等。
- hiviewdfx_cangjie_wrapper：框架层依赖hiviewdfx_cangjie_wrapper提供的HiLog日志能力，用于在关键路径打印日志。
- cangjie_ark_interop：框架层依赖cangjie_ark_interop提供的仓颉注解类定义和BusinessException异常类定义，用于对API进行标注，及在错误分支向用户抛出异常。

## 目录

仓目录结构如下：

```
foundation/communication/netmanager_cangjie_wrapper
├── figures          # 存放README中的架构图
├── kit              # 仓颉kit化代码
│   └── ArkData      # ArkData模块实现
└── ohos             # 仓颉分布式数据管理接口实现
│   └── data
│       ├── data_share_predicates     # 数据共享谓词模块
│       ├── distributed_kv_store      # 分布式键值数据库模块
│       ├── preferences               # 用户首选项模块
│       ├── relational_store          # 关系型数据库模块
│       └── values_bucket             # 数据集模块
└── test             # 测试用例
    ├── data_share_predicates # 数据共享谓词测试用例
    ├── distributed_kv_store  # 分布式键值数据库测试用例
    ├── preferences           # 用户首选项测试用例
    └── relational_store      # 关系型数据库测试用例
```

## 使用说明

分布式数据管理仓颉封装提供了以下功能：

- 数据共享谓词。
- 分布式键值数据库。
- 用户首选项。
- 关系型数据库。
- 数据集。

分布式数据管理相关接口请参见

1. [数据共享谓词API文档](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-data_share_predicates.md)
2. [分布式键值数据库API文档](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-distributed_kv_store.md)
3. [用户首选项API文档](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-preferences.md)
4. [关系型数据库API文档](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-relational_store.md)
5. [数据集API文档](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ArkData/cj-apis-values_bucket.md)

相关开发指导请参见[分布式数据管理开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/database)

## 约束

与ArkTS提供的API能力相比，暂不支持以下功能：

- 数据共享。
- 数据通用类型。
- DataAbility谓词。
- 分布式数据对象。
- 共享用户首选项。
- 共享关系型数据库。
- 标准化数据通路。
- 标准化数据结构。
- 标准化数据定义与描述。
- 智慧数据平台。
- 端云服务。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[ability_ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[distributeddatamgr\_data_share](https://gitcode.com/openharmony/distributeddatamgr_data_share)

[distributeddatamgr\_kv_store](https://gitcode.com/openharmony/distributeddatamgr_kv_store)

[distributeddatamgr\_preferences](https://gitcode.com/openharmony/distributeddatamgr_preferences)

[distributeddatamgr\_relational_store](https://gitcode.com/openharmony/distributeddatamgr_relational_store)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)