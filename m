Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C93E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQik-0003zD-AU; Wed, 24 Dec 2025 10:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQib-0003gQ-UT
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:24:09 -0500
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQiY-0004kf-5T
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:24:04 -0500
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-b73161849e1so1201779366b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589840; x=1767194640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uu0YsdTBGNvRl7GKd0ROR30NB9/cvkxUZHZEthSPaaE=;
 b=aRVQA5lO4tRjlcnIcpp2wB3I1OiiyCHDMOCHnk31Lhxj0/Dqd0k/okkoJulVkOpvT4
 a9f4+M/zd1UnzJeAn33OVX3f62y88VA0OHOFKXcozEEdSifJH555/3mb+v4ko3gWKqRc
 an7nkMs5BzhfgyQZS0ZHCNL5ej3p6sn+AeCgM7bjkytMMWwNeGJ8/Y9NBC2XWexHDRd8
 QEHtczxfvgsL+iMitFr4ZmclA7VHCzXLn5PGO2PpZMaxmN/Ha5T91LLYUa8fFYTgOb+V
 jP9BWXcc6cnq8kzTgUPXRhgB6F1XOr+prcnNMgAQ/TRir6wBcwfp6xjYjYWWwwDtEXqE
 /3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589840; x=1767194640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uu0YsdTBGNvRl7GKd0ROR30NB9/cvkxUZHZEthSPaaE=;
 b=EFPZ2pAnpixOpr2EmNdHHj5ow4b3M26xXY3R4LiggllLZ1jXkGaxAl54lIt6sGq+m2
 nBdh0DGBWXZyrtHeaMQtdEtQ9O7zqHOetnKwH2uP2RXt0EMMDicmAWNUhktnCwaozj7T
 KiAUyk5khD1TqK7ijLrilCftINT/8pVtR4lrXNHIseGKRgw+j8LRhqIapOf/qkzwX9q2
 JBzb1oVZjv7+jZiKqYJ3GT5pYaSGC8z+cFSUPZNip+vjZ8FR5HI42IIplf2jtZ6yBzY/
 NLUU+Qwn1idbOkq0Uc/vnhi5JwAo13KEqWMCjkbOnuPV08ojcd+nGjhLVW8Aqc6TF+fg
 ZIVQ==
X-Gm-Message-State: AOJu0YwhbbV9dkxFVEhBA5fEozCENzJKWdh2WrkEdlGXDeT9sl14hkZ6
 ouR1VjS4MKsvX8MuO2luhV6GuWAgIxywVA+cp4WWjNTyGKVp9GCOTyjL8D1ybhQyt2OzAg5i04h
 KULfor23sxg==
X-Gm-Gg: AY/fxX5NhXtkXCRvdR9LpEVpJh7acg09OnmrfbC5lyCXFREYzc6RoDDShCzZHNJ4YJp
 N0dZ12oz4s7lyMS4aKxhyu350Jt+kHN62C8R6hUCNWF47uwIapRa+nIluYvMAQ9FeJUjhwESdcY
 Pwy0QARRhxPN+Fvc0eGzvpuAPlbo5YgdqNA3cbUa7KUj57Nsb1Dg1Kp4N2ZO3hC9268G063yAhe
 Dax6hqnrVvNRydfcq2FMT11tMgioGNJc75f1B+f44KyHQWfeBIhgXj6sQQtgDcw+bTQ6Vp9FZg3
 53AbD2XzT52CTaRc17qSsniH20RqsujJu6cY18qooJuPaP6D1oeepPXRgEE9dynw7TROUrhx7Hk
 KH+nSXydqJm2Rb8oepxaiGnIl33f5ZwEg3qdispiAfRcrD/St3PlgmyjOCX4234tDpZkqAwJ7DI
 /Xcc6lySgX4fsBI6xlsshmIrQWZPSNe2UoQweC3MMYwFzcqhXPj+JJrNtwJ7N2SpoezPR2Zws=
X-Google-Smtp-Source: AGHT+IHmm4nwBOHkd3F6FsfRapjTCNpntbl/irJqjIunCfZPrDsEC8zNfzlwVnHy8YMB6CyZSZvj5A==
X-Received: by 2002:a17:907:1c27:b0:b7c:eb19:6a3f with SMTP id
 a640c23a62f3a-b803705e31cmr1828522366b.35.1766589840277; 
 Wed, 24 Dec 2025 07:24:00 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8045a086fasm1596953566b.70.2025.12.24.07.23.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:23:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 11/25] system/memory: Pass device_endian argument as MemOp
 bit
Date: Wed, 24 Dec 2025 16:21:54 +0100
Message-ID: <20251224152210.87880-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x643.google.com
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

Use the MemOp argument to hold both the access size and
its endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/memory_ldst.c.inc        | 86 ++++++++++++---------------------
 system/memory_ldst_endian.c.inc | 26 +++++-----
 2 files changed, 44 insertions(+), 68 deletions(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 39b3930bf50..5c8299e0cdc 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -24,8 +24,7 @@ static inline
 uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                                   hwaddr addr,
                                                   MemTxAttrs attrs,
-                                                  MemTxResult *result,
-                                                  enum device_endian endian)
+                                                  MemTxResult *result)
 {
     const unsigned size = memop_size(mop);
     uint8_t *ptr;
@@ -42,22 +41,15 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val,
-                                        mop | devend_memop(endian), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, mop, attrs);
     } else {
         /* RAM case */
         fuzz_dma_read_cb(addr, size, mr);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
+        if ((mop & MO_BSWAP) == MO_LE) {
             val = ldn_le_p(ptr, size);
-            break;
-        case DEVICE_BIG_ENDIAN:
+        } else {
             val = ldn_be_p(ptr, size);
-            break;
-        default:
-            val = ldn_p(ptr, size);
-            break;
         }
         r = MEMTX_OK;
     }
@@ -73,37 +65,33 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
 
 /* warning: addr must be aligned */
 static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_32, addr,
-                                                    attrs, result, endian);
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_32, addr,
+                                                    attrs, result);
 }
 
 /* warning: addr must be aligned */
 static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_64, addr,
-                                                    attrs, result, endian);
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_64, addr,
+                                                    attrs, result);
 }
 
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL, hwaddr addr,
                                          MemTxAttrs attrs, MemTxResult *result)
 {
     return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_8, addr,
-                                                    attrs, result,
-                                                    DEVICE_NATIVE_ENDIAN);
+                                                    attrs, result);
 }
 
 /* warning: addr must be aligned */
 static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_16, addr,
-                                                    attrs, result, endian);
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_16, addr,
+                                                    attrs, result);
 }
 
 /* warning: addr must be aligned */
@@ -111,8 +99,7 @@ static inline
 void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                               hwaddr addr, uint64_t val,
                                               MemTxAttrs attrs,
-                                              MemTxResult *result,
-                                              enum device_endian endian)
+                                              MemTxResult *result)
 {
     const unsigned size = memop_size(mop);
     uint8_t *ptr;
@@ -126,21 +113,14 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < size || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val,
-                                         mop | devend_memop(endian), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, mop, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
+        if ((mop & MO_BSWAP) == MO_LE) {
             stn_le_p(ptr, size, val);
-            break;
-        case DEVICE_BIG_ENDIAN:
+        } else {
             stn_be_p(ptr, size, val);
-            break;
-        default:
-            stn_p(ptr, size, val);
-            break;
         }
         invalidate_and_set_dirty(mr, addr1, size);
         r = MEMTX_OK;
@@ -156,48 +136,44 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
 
 /* warning: addr must be aligned */
 static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs,
-    MemTxResult *result, enum device_endian endian)
+    MemOp mop, hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
 {
-    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_32, addr, val,
-                                             attrs, result, endian);
+    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_32, addr, val,
+                                             attrs, result);
 }
 
 void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                      MemTxAttrs attrs, MemTxResult *result)
 {
     glue(address_space_stm_internal, SUFFIX)(ARG1, MO_8, addr, val,
-                                             attrs, result,
-                                             DEVICE_NATIVE_ENDIAN);
+                                             attrs, result);
 }
 
 /* warning: addr must be aligned */
 static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint16_t val, MemTxAttrs attrs,
-    MemTxResult *result, enum device_endian endian)
+    MemOp mop, hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
 {
-    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_16, addr, val,
-                                             attrs, result, endian);
+    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_16, addr, val,
+                                             attrs, result);
 }
 
 static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs,
-    MemTxResult *result, enum device_endian endian)
+    MemOp mop, hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
 {
-    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_64, addr, val,
-                                             attrs, result, endian);
+    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_64, addr, val,
+                                             attrs, result);
 }
 
 #define ENDIANNESS
-#define DEVICE_ENDIANNESS       DEVICE_NATIVE_ENDIAN
+#define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
 #include "memory_ldst_endian.c.inc"
 
 #define ENDIANNESS              _le
-#define DEVICE_ENDIANNESS       DEVICE_LITTLE_ENDIAN
+#define MO_ENDIAN               MO_LE
 #include "memory_ldst_endian.c.inc"
 
 #define ENDIANNESS              _be
-#define DEVICE_ENDIANNESS       DEVICE_BIG_ENDIAN
+#define MO_ENDIAN               MO_BE
 #include "memory_ldst_endian.c.inc"
 
 #undef ARG1_DECL
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index 791d041b15d..9cf36017135 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -22,43 +22,43 @@
 uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(uw)(ARG1, addr, attrs, result,
-                                         DEVICE_ENDIANNESS);
+    return ADDRESS_SPACE_LD_INTERNAL(uw)(ARG1, MO_ENDIAN,
+                                        addr, attrs, result);
 }
 
 uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, addr, attrs, result,
-                                        DEVICE_ENDIANNESS);
+    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, MO_ENDIAN,
+                                        addr, attrs, result);
 }
 
 uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, addr, attrs, result,
-                                        DEVICE_ENDIANNESS);
+    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, MO_ENDIAN,
+                                        addr, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(w)(ARG1, addr, val, attrs, result,
-                                 DEVICE_ENDIANNESS);
+    ADDRESS_SPACE_ST_INTERNAL(w)(ARG1, MO_ENDIAN,
+                                 addr, val, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, addr, val, attrs, result,
-                                 DEVICE_ENDIANNESS);
+    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, MO_ENDIAN,
+                                 addr, val, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, addr, val, attrs, result,
-                                 DEVICE_ENDIANNESS);
+    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, MO_ENDIAN,
+                                 addr, val, attrs, result);
 }
 
 #undef ADDRESS_SPACE_LD
@@ -67,4 +67,4 @@ void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
 #undef ADDRESS_SPACE_ST_INTERNAL
 
 #undef ENDIANNESS
-#undef DEVICE_ENDIANNESS
+#undef MO_ENDIAN
-- 
2.52.0


