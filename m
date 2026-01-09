Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC45D26D77
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFiZ-0004s7-9V; Fri, 09 Jan 2026 11:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFi6-0004N9-PL
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:42 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFi4-0007MO-37
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:38 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso27486295e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977494; x=1768582294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N+3aFNkuvJU7k9ASo56JmI7QdR/JRifI4sWY6ldkMUc=;
 b=nWCXSeFFl45gKgqHc7F9T6QOa9/gK2Qb2B6Zw7saAL26iBykh2E1+HakvcZCSiWABv
 kH7FSprmUb5BEArLsK72SGzf8E1WgsBrhMpH0jLy275k1c7yxAcHyNUV0GHYLa0tO+QK
 DwIx1L/foo2uCIFVyGcprIKK08u4Nnjwax2I5AMGDUgU71OMDL9lrfWK+VJBDAmipWLY
 nfRJh2wZdF3bB8/RJSP1xe+tg+vAXgLinf+q7LMg0Jo7LnuAdZthWpFZ5vsKVwmr3cRz
 2xFPJdk+dbF3xmfKXGICRD0YkHPwA4dJANRygsGEwsS8wO9xIqTTRTpHMmGRJew1LBqx
 IbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977494; x=1768582294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N+3aFNkuvJU7k9ASo56JmI7QdR/JRifI4sWY6ldkMUc=;
 b=Kvp1hqbYs2LDqM0GSyXExCXlJ/FJWwiTQcaCMnZOnrfwTuX2iTI+1nSPnikgqofkZw
 b/o+/5yjbq0U18mOQlQC1Q3qac6M2saGNP1fkT8TE/Y6Ce5cXzLDAoAP7nsvaC1eKH/h
 27dh820lPRGpgyenssBB2lwzDT2Khzr8TVg3ZkBLIadmhcVCBgz4dS8TQU4fnQEquyvM
 eRwd2G2GEZZYT0PXuEs76YgRS2Yvcxsg0qpBoGn3I+Zpj0JTSOa24UNLNlQ+OALcMAjg
 0oKY5qXJ4MsxX546FbvvUGAD+QZQ1GmjiQspLLDCNVM0SU1U920PkfKVQ53sTJn5YA1n
 o7Zw==
X-Gm-Message-State: AOJu0YwuOw1AQvAZwpuc+M+zm3Be2T7RbKrREJjTE+qug1ggXUVMuQtt
 N7pLcv+H2u/bNSn6NZub348t8sIU5IyEVn3ZcE2ORFhyFoKGPUWmpflcFc4IJngWxITeVi/DBcy
 WvhJRQpk=
X-Gm-Gg: AY/fxX7FalDEWBVWAn/OAqn7H0ohutcKKsO1HhItf1UcTmK72BHUOGxk5Oek1DQHQrP
 ftwoKxiVE/4jXK74syTqyR9uhjBrrjhgoQ1HJbGhBZzEPZ2e8gJHRVMXWwPLad9J97Zn7RbuRhZ
 sd9vk9K6fwK9hHJv11bLvMS0HuN1wEla42dqbfBPbK5kb6RvsLNBDjTJHjoswNS7d+/Mx//IbsJ
 T8vvknyeFDg5K/O5EmUhmMXjCV9dNLSDPr+R56RwqE2FQrIkDLANrE735i79hyvVER3gkPDQst2
 06mWk9zpKYVd4zboRlICS6WQx/PHIxcTbOVLCjOn/v0UPT58jJy0VR+56fK5vZTbtDtmkaoErL+
 6rwvLhIwG5516qm8ezcq7llztUNvdtgwWdwJJrMOOTMtbw7YWGl6nd1TgrnHRe1WEKWVFo03rv+
 RusY6eE6s7PwvZNFkN0WnihACyR9a0Vj4wK2lJh5wCkIBTQq3YUkL/6aUmVpC1Lle3O+yj8Zg=
X-Google-Smtp-Source: AGHT+IHWRwr18qwXcXQ2GbKctrQRtHOdS/3T6FhyYmzelmC24jKVciXGqoN7XiFtQZcShnXBmwNdeQ==
X-Received: by 2002:a05:600c:1991:b0:477:55c9:c3ea with SMTP id
 5b1f17b1804b1-47d84b40aa4mr134058615e9.35.1767977494009; 
 Fri, 09 Jan 2026 08:51:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f695225sm217942455e9.4.2026.01.09.08.51.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:51:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 05/22] system/memory: Split MemoryRegionCache API to
 'memory_cached.h'
Date: Fri,  9 Jan 2026 17:50:41 +0100
Message-ID: <20260109165058.59144-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We have 115 direct inclusions of "system/memory.h", and 91 headers
in include/ use it: hundreds of files have to process it.
However only one single header really uses the MemoryRegionCache
API: "hw/virtio/virtio-access.h". Split it out to a new header,
avoiding processing unused inlined functions hundreds of times.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                       |   1 +
 include/hw/virtio/virtio-access.h |   1 +
 include/system/memory.h           | 185 --------------------------
 include/system/memory_cached.h    | 210 ++++++++++++++++++++++++++++++
 system/physmem.c                  |   1 +
 5 files changed, 213 insertions(+), 185 deletions(-)
 create mode 100644 include/system/memory_cached.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4eb4e34ce75..ad1de7c0478 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3260,6 +3260,7 @@ F: include/exec/memop.h
 F: include/qemu/ldst_unaligned.h
 F: include/system/ram_addr.h
 F: include/system/memory.h
+F: include/system/memory_cached.h
 F: include/system/memory_ldst*
 F: include/system/physmem.h
 F: include/system/ramblock.h
diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 5b5fff5295e..cd17d0c87eb 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -17,6 +17,7 @@
 #define QEMU_VIRTIO_ACCESS_H
 
 #include "exec/hwaddr.h"
+#include "system/memory_cached.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
diff --git a/include/system/memory.h b/include/system/memory.h
index 0e8de527d36..92028dc7a4e 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2862,140 +2862,6 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #include "system/memory_ldst_phys.h.inc"
 #endif
 
-struct MemoryRegionCache {
-    uint8_t *ptr;
-    hwaddr xlat;
-    hwaddr len;
-    FlatView *fv;
-    MemoryRegionSection mrs;
-    bool is_write;
-};
-
-/* address_space_ld*_cached: load from a cached #MemoryRegion
- * address_space_st*_cached: store into a cached #MemoryRegion
- *
- * These functions perform a load or store of the byte, word,
- * longword or quad to the specified address.  The address is
- * a physical address in the AddressSpace, but it must lie within
- * a #MemoryRegion that was mapped with address_space_cache_init.
- *
- * The _le suffixed functions treat the data as little endian;
- * _be indicates big endian; no suffix indicates "same endianness
- * as guest CPU".
- *
- * The "guest CPU endianness" accessors are deprecated for use outside
- * target-* code; devices should be CPU-agnostic and use either the LE
- * or the BE accessors.
- *
- * @cache: previously initialized #MemoryRegionCache to be accessed
- * @addr: address within the address space
- * @val: data value, for stores
- * @attrs: memory transaction attributes
- * @result: location to write the success/failure of the transaction;
- *   if NULL, this information is discarded
- */
-
-#define SUFFIX       _cached_slow
-#define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
-#include "system/memory_ldst.h.inc"
-
-/* Inline fast path for direct RAM access.  */
-static inline uint8_t address_space_ldub_cached(MemoryRegionCache *cache,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    assert(addr < cache->len);
-    if (likely(cache->ptr)) {
-        return ldub_p(cache->ptr + addr);
-    } else {
-        return address_space_ldub_cached_slow(cache, addr, attrs, result);
-    }
-}
-
-static inline void address_space_stb_cached(MemoryRegionCache *cache,
-    hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    assert(addr < cache->len);
-    if (likely(cache->ptr)) {
-        stb_p(cache->ptr + addr, val);
-    } else {
-        address_space_stb_cached_slow(cache, addr, val, attrs, result);
-    }
-}
-
-#define ENDIANNESS
-#include "system/memory_ldst_cached.h.inc"
-
-#define ENDIANNESS   _le
-#include "system/memory_ldst_cached.h.inc"
-
-#define ENDIANNESS   _be
-#include "system/memory_ldst_cached.h.inc"
-
-#define SUFFIX       _cached
-#define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
-#include "system/memory_ldst_phys.h.inc"
-
-/* address_space_cache_init: prepare for repeated access to a physical
- * memory region
- *
- * @cache: #MemoryRegionCache to be filled
- * @as: #AddressSpace to be accessed
- * @addr: address within that address space
- * @len: length of buffer
- * @is_write: indicates the transfer direction
- *
- * Will only work with RAM, and may map a subset of the requested range by
- * returning a value that is less than @len.  On failure, return a negative
- * errno value.
- *
- * Because it only works with RAM, this function can be used for
- * read-modify-write operations.  In this case, is_write should be %true.
- *
- * Note that addresses passed to the address_space_*_cached functions
- * are relative to @addr.
- */
-int64_t address_space_cache_init(MemoryRegionCache *cache,
-                                 AddressSpace *as,
-                                 hwaddr addr,
-                                 hwaddr len,
-                                 bool is_write);
-
-/**
- * address_space_cache_init_empty: Initialize empty #MemoryRegionCache
- *
- * @cache: The #MemoryRegionCache to operate on.
- *
- * Initializes #MemoryRegionCache structure without memory region attached.
- * Cache initialized this way can only be safely destroyed, but not used.
- */
-static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
-{
-    cache->mrs.mr = NULL;
-    /* There is no real need to initialize fv, but it makes Coverity happy. */
-    cache->fv = NULL;
-}
-
-/**
- * address_space_cache_invalidate: complete a write to a #MemoryRegionCache
- *
- * @cache: The #MemoryRegionCache to operate on.
- * @addr: The first physical address that was written, relative to the
- * address that was passed to @address_space_cache_init.
- * @access_len: The number of bytes that were written starting at @addr.
- */
-void address_space_cache_invalidate(MemoryRegionCache *cache,
-                                    hwaddr addr,
-                                    hwaddr access_len);
-
-/**
- * address_space_cache_destroy: free a #MemoryRegionCache
- *
- * @cache: The #MemoryRegionCache whose memory should be released.
- */
-void address_space_cache_destroy(MemoryRegionCache *cache);
-
 void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len);
 
 /* address_space_get_iotlb_entry: translate an address into an IOTLB
@@ -3123,14 +2989,6 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemoryRegion *mr);
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 
-/* Internal functions, part of the implementation of address_space_read_cached
- * and address_space_write_cached.  */
-MemTxResult address_space_read_cached_slow(MemoryRegionCache *cache,
-                                           hwaddr addr, void *buf, hwaddr len);
-MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
-                                            hwaddr addr, const void *buf,
-                                            hwaddr len);
-
 int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
 bool prepare_mmio_access(MemoryRegion *mr);
 
@@ -3208,49 +3066,6 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
     return result;
 }
 
-/**
- * address_space_read_cached: read from a cached RAM region
- *
- * @cache: Cached region to be addressed
- * @addr: address relative to the base of the RAM region
- * @buf: buffer with the data transferred
- * @len: length of the data transferred
- */
-static inline MemTxResult
-address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
-                          void *buf, hwaddr len)
-{
-    assert(addr < cache->len && len <= cache->len - addr);
-    fuzz_dma_read_cb(cache->xlat + addr, len, cache->mrs.mr);
-    if (likely(cache->ptr)) {
-        memcpy(buf, cache->ptr + addr, len);
-        return MEMTX_OK;
-    } else {
-        return address_space_read_cached_slow(cache, addr, buf, len);
-    }
-}
-
-/**
- * address_space_write_cached: write to a cached RAM region
- *
- * @cache: Cached region to be addressed
- * @addr: address relative to the base of the RAM region
- * @buf: buffer with the data transferred
- * @len: length of the data transferred
- */
-static inline MemTxResult
-address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
-                           const void *buf, hwaddr len)
-{
-    assert(addr < cache->len && len <= cache->len - addr);
-    if (likely(cache->ptr)) {
-        memcpy(cache->ptr + addr, buf, len);
-        return MEMTX_OK;
-    } else {
-        return address_space_write_cached_slow(cache, addr, buf, len);
-    }
-}
-
 /**
  * address_space_set: Fill address space with a constant byte.
  *
diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
new file mode 100644
index 00000000000..e0ed54bd1eb
--- /dev/null
+++ b/include/system/memory_cached.h
@@ -0,0 +1,210 @@
+/*
+ * Physical memory management API
+ *
+ * Copyright 2011 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
+ *  Avi Kivity <avi@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef SYSTEM_MEMORY_CACHED_H
+#define SYSTEM_MEMORY_CACHED_H
+
+#include "exec/hwaddr.h"
+#include "system/memory.h"
+
+struct MemoryRegionCache {
+    uint8_t *ptr;
+    hwaddr xlat;
+    hwaddr len;
+    FlatView *fv;
+    MemoryRegionSection mrs;
+    bool is_write;
+};
+
+/**
+ * address_space_ld*_cached: load from a cached #MemoryRegion
+ * address_space_st*_cached: store into a cached #MemoryRegion
+ *
+ * These functions perform a load or store of the byte, word,
+ * longword or quad to the specified address.  The address is
+ * a physical address in the AddressSpace, but it must lie within
+ * a #MemoryRegion that was mapped with address_space_cache_init.
+ *
+ * The _le suffixed functions treat the data as little endian;
+ * _be indicates big endian; no suffix indicates "same endianness
+ * as guest CPU".
+ *
+ * The "guest CPU endianness" accessors are deprecated for use outside
+ * target-* code; devices should be CPU-agnostic and use either the LE
+ * or the BE accessors.
+ *
+ * @cache: previously initialized #MemoryRegionCache to be accessed
+ * @addr: address within the address space
+ * @val: data value, for stores
+ * @attrs: memory transaction attributes
+ * @result: location to write the success/failure of the transaction;
+ *          if NULL, this information is discarded
+ */
+
+#define SUFFIX       _cached_slow
+#define ARG1         cache
+#define ARG1_DECL    MemoryRegionCache *cache
+#include "system/memory_ldst.h.inc"
+
+/* Inline fast path for direct RAM access.  */
+static inline
+uint8_t address_space_ldub_cached(MemoryRegionCache *cache, hwaddr addr,
+                                  MemTxAttrs attrs, MemTxResult *result)
+{
+    assert(addr < cache->len);
+    if (likely(cache->ptr)) {
+        return ldub_p(cache->ptr + addr);
+    } else {
+        return address_space_ldub_cached_slow(cache, addr, attrs, result);
+    }
+}
+
+static inline
+void address_space_stb_cached(MemoryRegionCache *cache,
+                              hwaddr addr, uint8_t val,
+                              MemTxAttrs attrs, MemTxResult *result)
+{
+    assert(addr < cache->len);
+    if (likely(cache->ptr)) {
+        stb_p(cache->ptr + addr, val);
+    } else {
+        address_space_stb_cached_slow(cache, addr, val, attrs, result);
+    }
+}
+
+#define ENDIANNESS
+#include "system/memory_ldst_cached.h.inc"
+
+#define ENDIANNESS   _le
+#include "system/memory_ldst_cached.h.inc"
+
+#define ENDIANNESS   _be
+#include "system/memory_ldst_cached.h.inc"
+
+#define SUFFIX       _cached
+#define ARG1         cache
+#define ARG1_DECL    MemoryRegionCache *cache
+#include "system/memory_ldst_phys.h.inc"
+
+/**
+ * address_space_cache_init: prepare for repeated access to a physical
+ *                           memory region
+ *
+ * @cache: #MemoryRegionCache to be filled
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @len: length of buffer
+ * @is_write: indicates the transfer direction
+ *
+ * Will only work with RAM, and may map a subset of the requested range by
+ * returning a value that is less than @len.  On failure, return a negative
+ * errno value.
+ *
+ * Because it only works with RAM, this function can be used for
+ * read-modify-write operations.  In this case, is_write should be %true.
+ *
+ * Note that addresses passed to the address_space_*_cached functions
+ * are relative to @addr.
+ */
+int64_t address_space_cache_init(MemoryRegionCache *cache,
+                                 AddressSpace *as,
+                                 hwaddr addr,
+                                 hwaddr len,
+                                 bool is_write);
+
+/**
+ * address_space_cache_init_empty: Initialize empty #MemoryRegionCache
+ *
+ * @cache: The #MemoryRegionCache to operate on.
+ *
+ * Initializes #MemoryRegionCache structure without memory region attached.
+ * Cache initialized this way can only be safely destroyed, but not used.
+ */
+static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
+{
+    cache->mrs.mr = NULL;
+    /* There is no real need to initialize fv, but it makes Coverity happy. */
+    cache->fv = NULL;
+}
+
+/**
+ * address_space_cache_invalidate: complete a write to a #MemoryRegionCache
+ *
+ * @cache: The #MemoryRegionCache to operate on.
+ * @addr: The first physical address that was written, relative to the
+ * address that was passed to @address_space_cache_init.
+ * @access_len: The number of bytes that were written starting at @addr.
+ */
+void address_space_cache_invalidate(MemoryRegionCache *cache,
+                                    hwaddr addr,
+                                    hwaddr access_len);
+
+/**
+ * address_space_cache_destroy: free a #MemoryRegionCache
+ *
+ * @cache: The #MemoryRegionCache whose memory should be released.
+ */
+void address_space_cache_destroy(MemoryRegionCache *cache);
+
+/*
+ * Internal functions, part of the implementation of address_space_read_cached
+ * and address_space_write_cached.
+ */
+MemTxResult address_space_read_cached_slow(MemoryRegionCache *cache,
+                                           hwaddr addr, void *buf, hwaddr len);
+MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
+                                            hwaddr addr, const void *buf,
+                                            hwaddr len);
+
+/**
+ * address_space_read_cached: read from a cached RAM region
+ *
+ * @cache: Cached region to be addressed
+ * @addr: address relative to the base of the RAM region
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ */
+static inline MemTxResult
+address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
+                          void *buf, hwaddr len)
+{
+    assert(addr < cache->len && len <= cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, len, cache->mrs.mr);
+    if (likely(cache->ptr)) {
+        memcpy(buf, cache->ptr + addr, len);
+        return MEMTX_OK;
+    } else {
+        return address_space_read_cached_slow(cache, addr, buf, len);
+    }
+}
+
+/**
+ * address_space_write_cached: write to a cached RAM region
+ *
+ * @cache: Cached region to be addressed
+ * @addr: address relative to the base of the RAM region
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ */
+static inline MemTxResult
+address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
+                           const void *buf, hwaddr len)
+{
+    assert(addr < cache->len && len <= cache->len - addr);
+    if (likely(cache->ptr)) {
+        memcpy(cache->ptr + addr, buf, len);
+        return MEMTX_OK;
+    } else {
+        return address_space_write_cached_slow(cache, addr, buf, len);
+    }
+}
+
+#endif
diff --git a/system/physmem.c b/system/physmem.c
index 0e8a2fb621d..c7ddf8a9cf8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -53,6 +53,7 @@
 #include "qemu/memalign.h"
 #include "qemu/memfd.h"
 #include "system/memory.h"
+#include "system/memory_cached.h"
 #include "system/ioport.h"
 #include "system/dma.h"
 #include "system/hostmem.h"
-- 
2.52.0


