/*
 * Copyright (C) 2012 Igalia S.L.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY APPLE INC. AND ITS CONTRIBUTORS ``AS IS''
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL APPLE INC. OR ITS CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "config.h"
#include "WebCookieManagerProxy.h"

#include "WebCookieManagerMessages.h"
#include "WebProcessPool.h"

namespace WebKit {

void WebCookieManagerProxy::setCookiePersistentStorage(const String& storagePath, uint32_t storageType)
{
    m_cookiePersistentStoragePath = storagePath;
    m_cookiePersistentStorageType = static_cast<SoupCookiePersistentStorageType>(storageType);
    processPool()->sendToNetworkingProcess(Messages::WebCookieManager::SetCookiePersistentStorage(storagePath, storageType));
}

void WebCookieManagerProxy::getCookiePersistentStorage(String& storagePath, uint32_t& storageType) const
{
    storagePath = m_cookiePersistentStoragePath;
    storageType = static_cast<uint32_t>(m_cookiePersistentStorageType);
}

void WebCookieManagerProxy::setLimit(uint64_t limit)
{
    m_cookieStorageLimit = limit;
    processPool()->setInitialCookiesLimit(limit);
    processPool()->sendToNetworkingProcess(Messages::WebCookieManager::SetLimit(m_cookieStorageLimit));
}

}
