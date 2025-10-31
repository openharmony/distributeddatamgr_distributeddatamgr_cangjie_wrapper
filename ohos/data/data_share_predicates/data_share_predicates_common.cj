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

package ohos.data.data_share_predicates

import ohos.hilog.HilogChannel
import ohos.business_exception.{BusinessException, getUniversalErrorMsg}

let LOG = HilogChannel(0, 0xD001651, "CJ-dataSharePredicates")

func getErrorMsg(code: Int32): String {
    if (let Some(v) <- getUniversalErrorMsg(code)) {
        return v
    } else {
        return "Unknown error code: ${code}"
    }
}

func throwIfNotSuccess(code: Int32): Unit {
    if (code != 0) {
        if (code == -1) {
            throw BusinessException(16000050, "Internal error.")
        }
        throw BusinessException(code, getErrorMsg(code))
    }
}
