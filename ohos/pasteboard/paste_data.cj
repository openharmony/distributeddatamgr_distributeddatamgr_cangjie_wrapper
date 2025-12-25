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

import ohos.business_exception.{BusinessException, ERR_PARAMETER_ERROR}
import ohos.labels.APILevel
import ohos.ffi.{RetDataI64, RemoteDataLite, releaseFFIData}

foreign {
    func FfiOHOSCreateStringPasteData(mimeType: CString, value: CString): RetDataI64

    func FfiOHOSCreatePixelMapPasteData(mimeType: CString, pixelMapId: Int64): RetDataI64

    func FfiOHOSCreateArrayBufPasteData(mimeType: CString, buffPtr: CPointer<UInt8>, bufferSize: Int64): RetDataI64
}

/**
 * Creates a PasteData object of the specified type.
 * @param { String } mimeType - indicates MIME type of value, its size cannot be greater than 1024 bytes.
 * @param { String } value - indicates the content that is set to PasteData.
 * @returns { PasteData } Returns a new PasteData object which contains mimeType and value.
 * @throws { BusinessException } 12900004 - Replication is prohibited.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.MiscServices.Pasteboard",
    throwexception: true
]
public func createData(mimeType: String, value: String): PasteData {
    if ((mimeType != MIMETYPE_TEXT_HTML) && (mimeType != MIMETYPE_TEXT_PLAIN) && (mimeType != MIMETYPE_TEXT_URI)) {
        throw BusinessException(12900004, "Replication is prohibited.")
    }
    unsafe {
        var id = 0
        try (
            cMimeType = LibC.mallocCString(mimeType).asResource(),
            valueCstr = LibC.mallocCString(value).asResource()
        ) {
            let ret = FfiOHOSCreateStringPasteData(cMimeType.value, valueCstr.value)
            checkRet(ret.code, "[Pasteboard] createData: ")
            id = ret.data
        }
        return PasteData(id)
    }
}

/**
 * Classes for paste data.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.MiscServices.Pasteboard"
]
public class PasteData <: RemoteDataLite {
    init(id: Int64) {
        super(id)
        PASTEBOARD_LOG.info("[PasteData] construct success")
    }

    ~init() {
        releaseFFIData(myDataId)
    }
}
