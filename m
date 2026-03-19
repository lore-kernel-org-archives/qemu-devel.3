Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AAB1091910
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ImA-0001Aw-OU; Thu, 19 Mar 2026 15:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Im8-0000xt-Qj
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:11:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Im6-0008WL-34
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:11:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-485392de558so8570305e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 12:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773947476; x=1774552276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jY+N1T2BsnpBnvDoUycX3u016wRXwuuK2JDg3EykmW8=;
 b=JVbTYtkhfIAfuziS1XRUnweksIBdfNjq8TbQvPTVbveap4GYBWhjuI1w3j02NsQcWC
 BlgqZWBbvs6jkRl/ikmaCDNvklxhThtgj8+mP6TnvvQOo5a8ryIi8Zo8tG5iKQluDG7M
 WUwN4eFjeVbTKlosty28zOZMvIwZJmUMy/WGiNHTUiDN+R32SRNVeRSoyL3Dh6YQiOJi
 LmxeXCf19WjIGXOIYgsbVGpct2GGrUUxpGUJSryP8FpLdC8uZilFny6UYf7JcuBqOlO+
 zdNuiZoCpIKgX6CWklqeaftaYvecKjB+l/4hoRxlTNOLyF+XQmpllwmTC7x+NH84Z7v1
 Yxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773947476; x=1774552276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jY+N1T2BsnpBnvDoUycX3u016wRXwuuK2JDg3EykmW8=;
 b=e0Wu+OQGvgeRZvxElJ4qSfS51XGmN2uv9YnJAKZ3+QOYw6hTTlH9RkuxygJXwBUu4H
 4WJxolqQUZkOUXPDP0xvxK1NZp6ayv0YEg70WwE3X35OkfGgFoThZjIN0HZcqBbg5cvK
 YRMU/6V0gCQSeblnxopd9/wgEjF6pw5BMuv39lkYEKKxKdWyJ1riaktzuUjQPb/G7HMV
 wRJysS1xHXkFv3owAIguIk7L9/o/RWqwO0IabkDfZYzh6dj1dAIGFxusfy3f6IqWE/bT
 Klu3uhb6VI0hcmkD0CbGC9AkUAyA1sls8gsLmiqjiNSCCA6Fz0osJmQe0UAIf9L5L9gK
 S58g==
X-Gm-Message-State: AOJu0YyNLYekre14ed8kWcttq/6CoX3Swey6Avh7JwU70cgZd5QmYdOE
 ggrcjKIw3L/2+6gRNVCj2aWYf7fcHDW8LyBydoLyblLC/gmY2jzOAw77qt/oKFKgVb0osaEFORn
 v5wockso=
X-Gm-Gg: ATEYQzwUH3XttY3FWME7tf1xH5I73/OwRMxV2uBA5LPyq2I/9Yoao3BDYR9MrqF5Tp3
 NNROe3XfZhasufjcaTDqRHpBXhFWo1amKmq5p+nsGUi9ptHY+JemRi4pQBezsZi/v/JZAXR8Vao
 5lGrHzNl9rdElghptHzt5IF/+7RrBLOsF1fhMBofK3XohubuK6iAL8NSK8U6hxaXK6k9C/9Rf4M
 pwNsy4m6RGQk7krNzCGW/cgJUnVCByI3PTuEhOTjZ3RZcsbV6FIui0FmrsobAK0uspe5VOspsRD
 +nTTYIUhtYp5HMvACrEfjJlhGB00OR+goqs9uiaxTMq2WmPYiOJdiLIz10oPQ4/0bERRV2oyONY
 PQvTCXaet40KD3gQRQo4GgBUl9AdehRJNNz3cMSk6322jJz2omF+XSBdANX+gheVM7il0Q5768p
 VwAnosAGKarFWX5UDtofSaE4WncTnAZoEc54lhogkw3N55f15Ua78W80HDeiu2wUjII5j3oNaH
X-Received: by 2002:a05:600c:3b10:b0:485:3f72:3230 with SMTP id
 5b1f17b1804b1-486fedcc4d3mr4055415e9.15.1773947476010; 
 Thu, 19 Mar 2026 12:11:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64715539sm672366f8f.33.2026.03.19.12.11.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 12:11:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 8/8] system/memory: Constify various
 MemoryRegionCache arguments
Date: Thu, 19 Mar 2026 20:10:17 +0100
Message-ID: <20260319191017.12636-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319191017.12636-1-philmd@linaro.org>
References: <20260319191017.12636-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mark the MemoryRegionCache structure const when it is only
accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory_cached.h          | 18 +++++++++---------
 include/system/memory_ldst_cached.h.inc | 15 +++++++++------
 system/physmem.c                        | 10 +++++-----
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
index 760ecb38c19..09d46821bec 100644
--- a/include/system/memory_cached.h
+++ b/include/system/memory_cached.h
@@ -51,12 +51,12 @@ struct MemoryRegionCache {
 
 #define SUFFIX       _cached_slow
 #define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
+#define ARG1_DECL    const MemoryRegionCache *cache
 #include "system/memory_ldst.h.inc"
 
 /* Inline fast path for direct RAM access.  */
 static inline
-uint8_t address_space_ldub_cached(MemoryRegionCache *cache, hwaddr addr,
+uint8_t address_space_ldub_cached(const MemoryRegionCache *cache, hwaddr addr,
                                   MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len);
@@ -68,7 +68,7 @@ uint8_t address_space_ldub_cached(MemoryRegionCache *cache, hwaddr addr,
 }
 
 static inline
-void address_space_stb_cached(MemoryRegionCache *cache,
+void address_space_stb_cached(const MemoryRegionCache *cache,
                               hwaddr addr, uint8_t val,
                               MemTxAttrs attrs, MemTxResult *result)
 {
@@ -93,7 +93,7 @@ void address_space_stb_cached(MemoryRegionCache *cache,
 
 #define SUFFIX       _cached
 #define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
+#define ARG1_DECL    const MemoryRegionCache *cache
 #include "system/memory_ldst_phys.h.inc"
 
 /**
@@ -145,7 +145,7 @@ static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
  * address that was passed to @address_space_cache_init.
  * @access_len: The number of bytes that were written starting at @addr.
  */
-void address_space_cache_invalidate(MemoryRegionCache *cache,
+void address_space_cache_invalidate(const MemoryRegionCache *cache,
                                     hwaddr addr,
                                     hwaddr access_len);
 
@@ -160,9 +160,9 @@ void address_space_cache_destroy(MemoryRegionCache *cache);
  * Internal functions, part of the implementation of address_space_read_cached
  * and address_space_write_cached.
  */
-MemTxResult address_space_read_cached_slow(MemoryRegionCache *cache,
+MemTxResult address_space_read_cached_slow(const MemoryRegionCache *cache,
                                            hwaddr addr, void *buf, hwaddr len);
-MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
+MemTxResult address_space_write_cached_slow(const MemoryRegionCache *cache,
                                             hwaddr addr, const void *buf,
                                             hwaddr len);
 
@@ -175,7 +175,7 @@ MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
  * @len: length of the data transferred
  */
 static inline MemTxResult
-address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
+address_space_read_cached(const MemoryRegionCache *cache, hwaddr addr,
                           void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
@@ -197,7 +197,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
  * @len: length of the data transferred
  */
 static inline MemTxResult
-address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
+address_space_write_cached(const MemoryRegionCache *cache, hwaddr addr,
                            const void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
diff --git a/include/system/memory_ldst_cached.h.inc b/include/system/memory_ldst_cached.h.inc
index d7834f852c4..b4c696bff1f 100644
--- a/include/system/memory_ldst_cached.h.inc
+++ b/include/system/memory_ldst_cached.h.inc
@@ -24,7 +24,8 @@
 #define LD_P(size) \
     glue(glue(ld, size), glue(ENDIANNESS, _p))
 
-static inline uint16_t ADDRESS_SPACE_LD_CACHED(uw)(MemoryRegionCache *cache,
+static inline
+uint16_t ADDRESS_SPACE_LD_CACHED(uw)(const MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 2 <= cache->len - addr);
@@ -36,7 +37,8 @@ static inline uint16_t ADDRESS_SPACE_LD_CACHED(uw)(MemoryRegionCache *cache,
     }
 }
 
-static inline uint32_t ADDRESS_SPACE_LD_CACHED(l)(MemoryRegionCache *cache,
+static inline
+uint32_t ADDRESS_SPACE_LD_CACHED(l)(const MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 4 <= cache->len - addr);
@@ -48,7 +50,8 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(l)(MemoryRegionCache *cache,
     }
 }
 
-static inline uint64_t ADDRESS_SPACE_LD_CACHED(q)(MemoryRegionCache *cache,
+static inline
+uint64_t ADDRESS_SPACE_LD_CACHED(q)(const MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 8 <= cache->len - addr);
@@ -71,7 +74,7 @@ static inline uint64_t ADDRESS_SPACE_LD_CACHED(q)(MemoryRegionCache *cache,
 #define ST_P(size) \
     glue(glue(st, size), glue(ENDIANNESS, _p))
 
-static inline void ADDRESS_SPACE_ST_CACHED(w)(MemoryRegionCache *cache,
+static inline void ADDRESS_SPACE_ST_CACHED(w)(const MemoryRegionCache *cache,
     hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 2 <= cache->len - addr);
@@ -82,7 +85,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(w)(MemoryRegionCache *cache,
     }
 }
 
-static inline void ADDRESS_SPACE_ST_CACHED(l)(MemoryRegionCache *cache,
+static inline void ADDRESS_SPACE_ST_CACHED(l)(const MemoryRegionCache *cache,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 4 <= cache->len - addr);
@@ -93,7 +96,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(l)(MemoryRegionCache *cache,
     }
 }
 
-static inline void ADDRESS_SPACE_ST_CACHED(q)(MemoryRegionCache *cache,
+static inline void ADDRESS_SPACE_ST_CACHED(q)(const MemoryRegionCache *cache,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 8 <= cache->len - addr);
diff --git a/system/physmem.c b/system/physmem.c
index 8327b7c3de1..5f1be89649e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3886,7 +3886,7 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
     return l;
 }
 
-void address_space_cache_invalidate(MemoryRegionCache *cache,
+void address_space_cache_invalidate(const MemoryRegionCache *cache,
                                     hwaddr addr,
                                     hwaddr access_len)
 {
@@ -3917,7 +3917,7 @@ void address_space_cache_destroy(MemoryRegionCache *cache)
  * address_space_cache_init.
  */
 static inline MemoryRegion *address_space_translate_cached(
-    MemoryRegionCache *cache, hwaddr addr, hwaddr *xlat,
+    const MemoryRegionCache *cache, hwaddr addr, hwaddr *xlat,
     hwaddr *plen, bool is_write, MemTxAttrs attrs)
 {
     MemoryRegionSection section;
@@ -3998,7 +3998,7 @@ static MemTxResult address_space_read_continue_cached(MemTxAttrs attrs,
  * out of line function when the target is an MMIO or IOMMU region.
  */
 MemTxResult
-address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
+address_space_read_cached_slow(const MemoryRegionCache *cache, hwaddr addr,
                                    void *buf, hwaddr len)
 {
     hwaddr mr_addr, l;
@@ -4015,7 +4015,7 @@ address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
  * out of line function when the target is an MMIO or IOMMU region.
  */
 MemTxResult
-address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
+address_space_write_cached_slow(const MemoryRegionCache *cache, hwaddr addr,
                                     const void *buf, hwaddr len)
 {
     hwaddr mr_addr, l;
@@ -4028,7 +4028,7 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
                                                buf, len, mr_addr, l, mr);
 }
 
-#define ARG1_DECL                MemoryRegionCache *cache
+#define ARG1_DECL                const MemoryRegionCache *cache
 #define ARG1                     cache
 #define SUFFIX                   _cached_slow
 #define TRANSLATE(...)           address_space_translate_cached(cache, __VA_ARGS__)
-- 
2.53.0


