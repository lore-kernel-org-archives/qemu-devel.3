Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B36C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYaS-0007RC-Ge; Sun, 18 Jan 2026 14:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZQ-00066g-DF
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:20 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZN-0006kg-IB
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:20 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47ee9817a35so18945085e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768764974; x=1769369774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uu0YsdTBGNvRl7GKd0ROR30NB9/cvkxUZHZEthSPaaE=;
 b=XBzRsqoeHKREtRz50/zK6cgUPNZCYxOwGGffInBb+xTwdTk5Ipda4XyqeyW/JKrhaQ
 XXrY/VDRcnFC/uCCMMulcPYCBZhAIAmyQywYZfnetGiQQ8Su1iFY3gqGOWGXUU7wR/rh
 NYiTTklI0tFQSgMmWZmT52LBKHj3W4hoxODgE3Lc6vS2vfuaP/7euMP+AA7lXxZ5f1m9
 XFlG9vGYVIxoWAf4FMk/DQpRRqBSTG0bScZ0Kxkq56Mzk7+VrhD6KDohxQgMgbn5GyOJ
 +2cr+yBpajfsDxJRFCnaec02S/tFIRYWHKZ+JIIrYA7Yrphww3S7TPaEwyr0+GuTEsKe
 Evaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768764974; x=1769369774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uu0YsdTBGNvRl7GKd0ROR30NB9/cvkxUZHZEthSPaaE=;
 b=oo0oVhX3B9zzs/xXBO8SDBxKuUvr5npV3Vj7+zNVRl9IovaTGBAYEo4/pDPASGlzdf
 7HzrheT4rrLFTYeyifj9obBOo144cEkHm7dIPW0mdITT/4HrnxpfLxaDrC5zYjUF3Jfq
 ZaQOAMZ0OBL28y9W8hB8str8RPUfRNLOzfTuuBIpVH0qBZ7/ugw7Sqo8YSKzjd0Eo7nc
 dIi/L0V/02W09kON2paGy9Hvw1gSIcdeshBcPI9bOlwhn7V4HoAHCDrUF1jrMwII+Aw6
 3H6m1kjG5VcBSIdOddVznyXLuGp6lkmADqkoSxAgxCnRMyYI86nDni6Z13JWgcXow9jZ
 eMug==
X-Gm-Message-State: AOJu0Yx+j+fOmQtHLAxCIpyVlDuOGh4/Eb2zwu/VUP+o1QcEKUmN5NFp
 JV5w6WRZ5pT/6oPACK7iA0fA4SUIz1hHfWWvFfgmxuY8+yPjkCZ343kjqP4+vlZzPfzR1UCaW+s
 1ri2Xz0tPSQ==
X-Gm-Gg: AY/fxX6EBaUhEQxp8MmP/0QJD6yzVCKe1NqBqzt/K/EZ5LY7VJf8S5U84Ki/OZHO3e4
 idDKhrJc90A765e2X2kZN9S4ZEnq3XxaQdRFeiyEn0fCPws0U0x4SWIzdGV74mCPTFs/twBcE+9
 zxJ0aQgqVWsWICrYCV0bZnsGtxDJJjzOMBU7OVYWylo+E9t0YiG57g5Wj/8xgyBYlbTzcAFSluI
 463LTRp46tyJebfvSA1yY+B55SWsFcOB45J0lGcyD6eJr4qN0UaQ42GfQaoU/L0o6EagwhzMMWp
 8v+06pBUw6iG9h0yxfF9ypYF5sqeosPc3PIo0HsJpxGTdhQa5BRwF6gRL379pju0gGgXWZ3sLyE
 6aDca7ZcBeENiu3OwJ2PRs/aKm+ReyyKKtPDJjR26ejM81Yp4T9mZJVfNnras9P+TXExSVtFAQw
 mdv2WyPavrDXFZI4O3SpaHZ5mvw7bCtVfoFqGEDOkrEZz0P7lSvEcg1A4gyqyM
X-Received: by 2002:a05:600c:821a:b0:480:3338:292d with SMTP id
 5b1f17b1804b1-480349dfa72mr10807075e9.31.1768764973903; 
 Sun, 18 Jan 2026 11:36:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm18600150f8f.11.2026.01.18.11.36.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:36:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 09/18] system/memory: Pass device_endian argument as MemOp
 bit
Date: Sun, 18 Jan 2026 20:34:59 +0100
Message-ID: <20260118193509.42923-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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


