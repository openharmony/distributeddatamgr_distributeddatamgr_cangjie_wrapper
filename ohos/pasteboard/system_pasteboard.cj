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

package ohos.pasteboard

import std.collection.HashMap
import ohos.labels.APILevel
import ohos.ffi.{getOrCreate, RetDataI64, RemoteDataLite, releaseFFIData}

foreign {
    func FfiOHOSGetSystemPasteboard(): RetDataI64

    func FfiOHOSSystemPasteboardSetData(id: Int64, pasteDataId: Int64): Int32
}

/**
 * get SystemPasteboard
 * @returns { SystemPasteboard } Returns the system clipboard object
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.MiscServices.Pasteboard"
]
public func getSystemPasteboard(): SystemPasteboard {
    unsafe {
        let ret = FfiOHOSGetSystemPasteboard()
        checkRet(ret.code, "System Pasteboard ")
        return getOrCreate(SystemPasteboard.INSTANCE_MAP, ret.data, {id: Int64 => SystemPasteboard(id)})
    }
}

/**
 * Classes for system pasteboard.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.MiscServices.Pasteboard"
]
public class SystemPasteboard <: RemoteDataLite {
    static let INSTANCE_MAP = HashMap<Int64, SystemPasteboard>()

    init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Writes PasteData to the system pasteboard.
     * @param { PasteData } data - PasteData will be written to the clipboard.
     * @throws { BusinessException } 27787277 - Another copy or paste operation is in progress.
     * @throws { BusinessException } 27787278 - Replication is prohibited.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.MiscServices.Pasteboard",
        throwexception: true,
        workerthread: true
    ]
    public func setData(data: PasteData): Unit {
        unsafe {
            let ret = FfiOHOSSystemPasteboardSetData(getID(), data.getID())
            checkRet(ret, "[SystemPasteboard] setData: ")
        }
    }
}
