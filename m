Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A050E66880
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdDd-0006Up-FQ; Fri, 19 Dec 2025 11:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDa-0006MU-Sh
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:40 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDW-0005zJ-O5
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:38 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so15444235e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161232; x=1766766032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qZvbvQLxaIlKx//0rppR03DDoRSMmrW1QNx7mn2Lfk=;
 b=bkKSlrN9ujQNFTS7GaEQzdqozvshY3p1zFir2LZsMQFoiLlMhy3NfDbT2ZJTokBmLD
 IGYggWY9diVvws1XYXn685WhrKVGvdJzXHugxgQDBcPyUoCH1O8mCYHFjW6lai152CwM
 QLBk8/oU3w6JXpGSaTAq5cy18EF395+Ef1crHyOIDamkdffhcHXF3G6XXDKTxZHE2WqR
 HDIV62AyXyfn6eVAzwEXfaUs2YOfFJGCuLQ1HBjtO2b3WU/lrh7e2pJk6DIwBcwebXXq
 oGmWUxqb6QBuxpGkG64VP+4v0Gzshl5ZeESFI95OWb8JSOkNxvdappFYEOAAqnDRE7cY
 KNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161232; x=1766766032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8qZvbvQLxaIlKx//0rppR03DDoRSMmrW1QNx7mn2Lfk=;
 b=NhO3Rk3TslbMWu+IPPkqXS8DweTM9hAFZ0L8fEYK484U2fPSjddptwngY8ue0oyxDf
 aCrwtvLC0s9kiXjwx8OdeINcz2k8z4wcBCihK7xzG9/bJiWsfiZNH0rYBwm6fGbmucxX
 Hl2To9/XoER1Q3YJ8CUhD9jt3+T03cZxDL+BLmC8N4Ftx8VhFLGkNNtoJMTnkBn1uFSx
 GEDcYztzJqW9ALIBYYpYVKoUJWJyeRTvwP2Vp9lPprBFsIDOu3lyUIIaZ1W3bci7wahe
 aY5OKOvITz+jN2jMZ++KK81msCQU3Xra8N3tdeC4zSl1WfS26a9E7HWooOIuovg4UzAf
 hfVg==
X-Gm-Message-State: AOJu0Yyly+AZJ/9XfNzG9wICM8vJInpEUS3vUKXB20h/8qh8rhKcqN4g
 wNzZssikEVBnUVyWnlGK4e4YkdgMf2w6xd0QQv3glKviC1/Wvidu6Ftw05qVtUqxqM4uYXUO2U0
 7ify1x9c=
X-Gm-Gg: AY/fxX5cEIDpPt72oY3ido706ofsA+0uUpMmOcyBWEAVPmGl4OpGBcB/0yU24lCMcFI
 /O4I2pus13fa0e3GQ21G69uuS3cCIyV0x0Pmt9xf+lhG432UPwHc+JVjr26ofadmJ07ME+2D0cI
 Se+Vy9Y5WATQ9R+c4mNplgbVWgcG6dnlNGSmqmDFOQF61mtXieuINveIlA/QiPCzgS8YCr7g6nq
 iaPD6f2i41IPK6bSx/gSvDOPHH3ywNxdZLLSDdBTsUdSSz3+ZSRIXYGW513hzewNmBlPcEG0oLm
 wCe2xI9nc6PQkxDIqOsCg3p4VPN9LD+5i4xx5aXS+YOzaKo2ifVN4AjJ7Cv4j9JoWXm8bnRxYtK
 esUWnjYEnOdx24YMLt0RCLXB5vNcps2qS5JJ9Ji8VRgvxzhQlkSs3GiFnI4NhL3sVphd/+xrZkg
 wn+PSDBR12mFQ9Mu/b6iaGWPHtCEALYooSFZZ52vKH8qQFz5Zto4mfDhuHr0+u
X-Google-Smtp-Source: AGHT+IHl7YobvVrpKK1f1Oz9vr4sQvNGcg2bv3m//f6wdMvzYv1xmpCmo8Q7w+9M5NMrhAXYKYbFzw==
X-Received: by 2002:a05:600c:4f52:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-47d1958a5d5mr37698805e9.22.1766161232291; 
 Fri, 19 Dec 2025 08:20:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea22650sm5684542f8f.11.2025.12.19.08.20.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:20:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 05/24] system/memory: Split MemoryRegionCache API to
 'memory_cached.h'
Date: Fri, 19 Dec 2025 17:19:32 +0100
Message-ID: <20251219161953.72724-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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
 include/system/memory_cached.h    | 207 ++++++++++++++++++++++++++++++
 system/physmem.c                  |   1 +
 5 files changed, 210 insertions(+), 185 deletions(-)
 create mode 100644 include/system/memory_cached.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521bc..c299b84d418 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3255,6 +3255,7 @@ S: Supported
 F: include/system/ioport.h
 F: include/exec/memop.h
 F: include/system/memory.h
+F: include/system/memory_cached.h
 F: include/system/physmem.h
 F: include/system/ram_addr.h
 F: include/system/ramblock.h
diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 07aae69042a..3ea3acfe05a 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -17,6 +17,7 @@
 #define QEMU_VIRTIO_ACCESS_H
 
 #include "exec/hwaddr.h"
+#include "system/memory_cached.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
diff --git a/include/system/memory.h b/include/system/memory.h
index e69171de05a..90f375df5df 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2855,140 +2855,6 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #define ARG1_DECL    AddressSpace *as
 #include "exec/memory_ldst_phys.h.inc"
 
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
-#include "exec/memory_ldst.h.inc"
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
-#include "exec/memory_ldst_cached.h.inc"
-
-#define ENDIANNESS   _le
-#include "exec/memory_ldst_cached.h.inc"
-
-#define ENDIANNESS   _be
-#include "exec/memory_ldst_cached.h.inc"
-
-#define SUFFIX       _cached
-#define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
-#include "exec/memory_ldst_phys.h.inc"
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
@@ -3116,14 +2982,6 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
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
 
@@ -3201,49 +3059,6 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
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
index 00000000000..1a07774b6ad
--- /dev/null
+++ b/include/system/memory_cached.h
@@ -0,0 +1,207 @@
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
+#include "exec/memory_ldst.h.inc"
+
+/* Inline fast path for direct RAM access.  */
+static inline uint8_t address_space_ldub_cached(MemoryRegionCache *cache,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    assert(addr < cache->len);
+    if (likely(cache->ptr)) {
+        return ldub_p(cache->ptr + addr);
+    } else {
+        return address_space_ldub_cached_slow(cache, addr, attrs, result);
+    }
+}
+
+static inline void address_space_stb_cached(MemoryRegionCache *cache,
+    hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result)
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
+#include "exec/memory_ldst_cached.h.inc"
+
+#define ENDIANNESS   _le
+#include "exec/memory_ldst_cached.h.inc"
+
+#define ENDIANNESS   _be
+#include "exec/memory_ldst_cached.h.inc"
+
+#define SUFFIX       _cached
+#define ARG1         cache
+#define ARG1_DECL    MemoryRegionCache *cache
+#include "exec/memory_ldst_phys.h.inc"
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
index 9fe84679cac..fb69cdb57d9 100644
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


