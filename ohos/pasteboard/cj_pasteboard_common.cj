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

import ohos.labels.APILevel

/**
 * Indicates MIME types of plain text.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.MiscServices.Pasteboard"
]
public const MIMETYPE_TEXT_PLAIN: String = "text/plain"

const MIMETYPE_TEXT_HTML: String = "text/html"

const MIMETYPE_TEXT_WANT: String = "text/want"

const MIMETYPE_TEXT_URI: String = "text/uri"

const MIMETYPE_PIXELMAP: String = "pixelMap"