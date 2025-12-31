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

package ohos.data.values_bucket

import ohos.labels.APILevel

@!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.DataShare.Core"]
public enum VBValueType {
    @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.DataShare.Core"] Integer(Int64)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.DataShare.Core"] Double(Float64)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.DataShare.Core"] StringValue(String)
    | @!APILevel[since: "22", syscap: "SystemCapability.DistributedDataManager.DataShare.Core"] Boolean(Bool)
    | ...
}