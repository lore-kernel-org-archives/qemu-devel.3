Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D04CCDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 17:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqyGQ-0007B3-MF; Wed, 18 Sep 2024 13:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sqyGN-0006zO-91
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:14:47 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sqyGJ-0001sA-HH
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:14:46 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2da55ea8163so791a91.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1726679682; x=1727284482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6LEzHTIKfl00G8sbiHdw7NG2hDNTj2rDJZBBWEdaHA=;
 b=KMimPAeZEqQB+zw8o+zHjzkEEJfGrfD21B4zmIoAIB3CD/B9bFOlOWJLGKKVbP43zE
 Nnd5eW/DKzOTkHfh3ut7Mb2umRcy9YwH445svi6GTkGDXO/956m15id/DWOD+bNm65Dk
 jVQPKnN5j60o1S4CwI3++mvO3A7AENj6uoeyM68Dnvn2ZiqkV2U+ABqWC7ELiQ64f009
 hvK0RW/oVcaR80LzRyBqU4n1ZI7V+NXb+wCib94aVE+s/9T7LNgtDVULcy7xGHzd0nNE
 HU/CVqNCFxiA9fkam95Nook9YC1J8EUWQD5b/llFroFiWrhWFbH7Fj7o41E69B4XoKLU
 m7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726679682; x=1727284482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6LEzHTIKfl00G8sbiHdw7NG2hDNTj2rDJZBBWEdaHA=;
 b=QRBJLqk/VKhDF2P5sET3bcd3uvQTZogi1wYNNr2QkYUeMojOVWLROwghAXJUlGv9Wi
 JuT5zVzvHeH2r7wD94NL5VEQPdQOlkW4FMIKBqz6Wjc/9Cscc1gvNctbujxdPNqMhhUA
 Ltb+rf6Atx+eIToxMf6ixHyKPq0FAKhn/kL/xSuwZLHmyRFy4Zd1nyY8/r9nh8RZlYNc
 Iw6OQOv8LCEYQb8V/zPqHwjyTBsDc0n/XVeJJAQovlY/ZIyPUxZ2IZ3of1AFu+65lT6K
 f9VfzwuEEdoqBrMFwZDS18tZdUpC1EEsqPP/dziO9ZRX268Z0JcWSoL+m35E3KEtSsvE
 quXw==
X-Gm-Message-State: AOJu0YzlL9nWtHx59iVolNRqMCJZNulz97IadYf7Igvr6iHUaszYyLwH
 rmG59MvIrHdtmkPXzrCUPqLNvTyivuHGHjm7CIiJlX+9JKDAVDob/xZVCYeOgjgqtbcL78CWezQ
 E2BjcGF/pNtvVi7cUdWZpLw40RGF/Mgm9kYOWK+0Mt3VXCH1vM5qLIWt1n6yA4VYKpUciFC4wBJ
 9dzciub9UkD5Jn8dftkDfcP5hm6et3HxfNBUL5hw==
X-Google-Smtp-Source: AGHT+IHbWv/kdWxiYUUxhaHZ0z8zBwoJRDUTLmBMoemUSwoEcoypjJvaSZp87Y4KmDzbPZfG2n4H4Q==
X-Received: by 2002:a17:90a:2f23:b0:2d8:82a2:b093 with SMTP id
 98e67ed59e1d1-2db9ffcaab5mr26527347a91.13.1726679681322; 
 Wed, 18 Sep 2024 10:14:41 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dd608e2318sm1914577a91.32.2024.09.18.10.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 10:14:40 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 negge@google.com, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 3/7] target/riscv: rvv: Provide a fast path using direct
 access to host ram for unmasked unit-stride load/store
Date: Thu, 19 Sep 2024 01:14:08 +0800
Message-Id: <20240918171412.150107-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918171412.150107-1-max.chou@sifive.com>
References: <20240918171412.150107-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This commit references the sve_ldN_r/sve_stN_r helper functions in ARM
target to optimize the vector unmasked unit-stride load/store
implementation with following optimizations:

* Get the page boundary
* Probing pages/resolving host memory address at the beginning if
  possible
* Provide new interface to direct access host memory
* Switch to the original slow TLB access when cross page element/violate
  page permission/violate pmp/watchpoints in page

The original element load/store interface is replaced by the new element
load/store functions with _tlb & _host postfix that means doing the
element load/store through the original softmmu flow and the direct
access host memory flow.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 363 +++++++++++++++++++++--------------
 1 file changed, 224 insertions(+), 139 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 967bb2687ae..c2fcf8b3a00 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -147,34 +147,47 @@ static inline void vext_set_elem_mask(void *v0, int index,
 }
 
 /* elements operations for load and store */
-typedef void vext_ldst_elem_fn(CPURISCVState *env, abi_ptr addr,
-                               uint32_t idx, void *vd, uintptr_t retaddr);
+typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
+                                   uint32_t idx, void *vd, uintptr_t retaddr);
+typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
 
-#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)            \
-static void NAME(CPURISCVState *env, abi_ptr addr,         \
-                 uint32_t idx, void *vd, uintptr_t retaddr)\
-{                                                          \
-    ETYPE *cur = ((ETYPE *)vd + H(idx));                   \
-    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);      \
-}                                                          \
-
-GEN_VEXT_LD_ELEM(lde_b, int8_t,  H1, ldsb)
-GEN_VEXT_LD_ELEM(lde_h, int16_t, H2, ldsw)
-GEN_VEXT_LD_ELEM(lde_w, int32_t, H4, ldl)
-GEN_VEXT_LD_ELEM(lde_d, int64_t, H8, ldq)
-
-#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)            \
-static void NAME(CPURISCVState *env, abi_ptr addr,         \
-                 uint32_t idx, void *vd, uintptr_t retaddr)\
-{                                                          \
-    ETYPE data = *((ETYPE *)vd + H(idx));                  \
-    cpu_##STSUF##_data_ra(env, addr, data, retaddr);       \
+#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)             \
+static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,    \
+                uint32_t idx, void *vd, uintptr_t retaddr)  \
+{                                                           \
+    ETYPE *cur = ((ETYPE *)vd + H(idx));                    \
+    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);       \
+}                                                           \
+                                                            \
+static void NAME##_host(void *vd, uint32_t idx, void *host) \
+{                                                           \
+    ETYPE *cur = ((ETYPE *)vd + H(idx));                    \
+    *cur = (ETYPE)LDSUF##_p(host);                          \
+}
+
+GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
+GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw)
+GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq)
+
+#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)             \
+static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,    \
+                uint32_t idx, void *vd, uintptr_t retaddr)  \
+{                                                           \
+    ETYPE data = *((ETYPE *)vd + H(idx));                   \
+    cpu_##STSUF##_data_ra(env, addr, data, retaddr);        \
+}                                                           \
+                                                            \
+static void NAME##_host(void *vd, uint32_t idx, void *host) \
+{                                                           \
+    ETYPE data = *((ETYPE *)vd + H(idx));                   \
+    STSUF##_p(host, data);                                  \
 }
 
-GEN_VEXT_ST_ELEM(ste_b, int8_t,  H1, stb)
-GEN_VEXT_ST_ELEM(ste_h, int16_t, H2, stw)
-GEN_VEXT_ST_ELEM(ste_w, int32_t, H4, stl)
-GEN_VEXT_ST_ELEM(ste_d, int64_t, H8, stq)
+GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
+GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
+GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
+GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
 
 static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
                                    uint32_t desc, uint32_t nf,
@@ -197,11 +210,10 @@ static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
  * stride: access vector element from strided memory
  */
 static void
-vext_ldst_stride(void *vd, void *v0, target_ulong base,
-                 target_ulong stride, CPURISCVState *env,
-                 uint32_t desc, uint32_t vm,
-                 vext_ldst_elem_fn *ldst_elem,
-                 uint32_t log2_esz, uintptr_t ra)
+vext_ldst_stride(void *vd, void *v0, target_ulong base, target_ulong stride,
+                 CPURISCVState *env, uint32_t desc, uint32_t vm,
+                 vext_ldst_elem_fn_tlb *ldst_elem, uint32_t log2_esz,
+                 uintptr_t ra)
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
@@ -241,10 +253,10 @@ void HELPER(NAME)(void *vd, void * v0, target_ulong base,               \
                      ctzl(sizeof(ETYPE)), GETPC());                     \
 }
 
-GEN_VEXT_LD_STRIDE(vlse8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_STRIDE(vlse16_v, int16_t, lde_h)
-GEN_VEXT_LD_STRIDE(vlse32_v, int32_t, lde_w)
-GEN_VEXT_LD_STRIDE(vlse64_v, int64_t, lde_d)
+GEN_VEXT_LD_STRIDE(vlse8_v,  int8_t,  lde_b_tlb)
+GEN_VEXT_LD_STRIDE(vlse16_v, int16_t, lde_h_tlb)
+GEN_VEXT_LD_STRIDE(vlse32_v, int32_t, lde_w_tlb)
+GEN_VEXT_LD_STRIDE(vlse64_v, int64_t, lde_d_tlb)
 
 #define GEN_VEXT_ST_STRIDE(NAME, ETYPE, STORE_FN)                       \
 void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
@@ -256,42 +268,114 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
                      ctzl(sizeof(ETYPE)), GETPC());                     \
 }
 
-GEN_VEXT_ST_STRIDE(vsse8_v,  int8_t,  ste_b)
-GEN_VEXT_ST_STRIDE(vsse16_v, int16_t, ste_h)
-GEN_VEXT_ST_STRIDE(vsse32_v, int32_t, ste_w)
-GEN_VEXT_ST_STRIDE(vsse64_v, int64_t, ste_d)
+GEN_VEXT_ST_STRIDE(vsse8_v,  int8_t,  ste_b_tlb)
+GEN_VEXT_ST_STRIDE(vsse16_v, int16_t, ste_h_tlb)
+GEN_VEXT_ST_STRIDE(vsse32_v, int32_t, ste_w_tlb)
+GEN_VEXT_ST_STRIDE(vsse64_v, int64_t, ste_d_tlb)
 
 /*
  * unit-stride: access elements stored contiguously in memory
  */
 
 /* unmasked unit-stride load and store operation */
+static void
+vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
+                  uint32_t elems, uint32_t nf, uint32_t max_elems,
+                  uint32_t log2_esz, bool is_load, int mmu_index,
+                  vext_ldst_elem_fn_tlb *ldst_tlb,
+                  vext_ldst_elem_fn_host *ldst_host, uintptr_t ra)
+{
+    void *host;
+    int i, k, flags;
+    uint32_t esz = 1 << log2_esz;
+    uint32_t size = (elems * nf) << log2_esz;
+    uint32_t evl = env->vstart + elems;
+    MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
+
+    /* Check page permission/pmp/watchpoint/etc. */
+    flags = probe_access_flags(env, adjust_addr(env, addr), size, access_type,
+                               mmu_index, true, &host, ra);
+
+    if (flags == 0) {
+        for (i = env->vstart; i < evl; ++i) {
+            k = 0;
+            while (k < nf) {
+                ldst_host(vd, i + k * max_elems, host);
+                host += esz;
+                k++;
+            }
+        }
+        env->vstart += elems;
+    } else {
+        /* load bytes from guest memory */
+        for (i = env->vstart; i < evl; env->vstart = ++i) {
+            k = 0;
+            while (k < nf) {
+                ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems, vd,
+                         ra);
+                addr += esz;
+                k++;
+            }
+        }
+    }
+}
+
 static void
 vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
-             vext_ldst_elem_fn *ldst_elem, uint32_t log2_esz, uint32_t evl,
-             uintptr_t ra)
+             vext_ldst_elem_fn_tlb *ldst_tlb,
+             vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
+             uint32_t evl, uintptr_t ra, bool is_load)
 {
-    uint32_t i, k;
+    uint32_t k;
+    target_ulong page_split, elems, addr;
     uint32_t nf = vext_nf(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
+    uint32_t msize = nf * esz;
+    int mmu_index = riscv_env_mmu_index(env, false);
 
     if (env->vstart >= evl) {
         env->vstart = 0;
         return;
     }
 
-    /* load bytes from guest memory */
-    for (i = env->vstart; i < evl; env->vstart = ++i) {
-        k = 0;
-        while (k < nf) {
-            target_ulong addr = base + ((i * nf + k) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
-            k++;
+    /* Calculate the page range of first page */
+    addr = base + ((env->vstart * nf) << log2_esz);
+    page_split = -(addr | TARGET_PAGE_MASK);
+    /* Get number of elements */
+    elems = page_split / msize;
+    if (unlikely(env->vstart + elems >= evl)) {
+        elems = evl - env->vstart;
+    }
+
+    /* Load/store elements in the first page */
+    if (likely(elems)) {
+        vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, log2_esz,
+                          is_load, mmu_index, ldst_tlb, ldst_host, ra);
+    }
+
+    /* Load/store elements in the second page */
+    if (unlikely(env->vstart < evl)) {
+        /* Cross page element */
+        if (unlikely(page_split % msize)) {
+            for (k = 0; k < nf; k++) {
+                addr = base + ((env->vstart * nf + k) << log2_esz);
+                ldst_tlb(env, adjust_addr(env, addr),
+                        env->vstart + k * max_elems, vd, ra);
+            }
+            env->vstart++;
         }
+
+        addr = base + ((env->vstart * nf) << log2_esz);
+        /* Get number of elements of second page */
+        elems = evl - env->vstart;
+
+        /* Load/store elements in the second page */
+        vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, log2_esz,
+                          is_load, mmu_index, ldst_tlb, ldst_host, ra);
     }
-    env->vstart = 0;
 
+    env->vstart = 0;
     vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
 }
 
@@ -300,47 +384,47 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
  * stride, stride = NF * sizeof (ETYPE)
  */
 
-#define GEN_VEXT_LD_US(NAME, ETYPE, LOAD_FN)                            \
-void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,         \
-                         CPURISCVState *env, uint32_t desc)             \
-{                                                                       \
-    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));             \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, false, LOAD_FN,   \
-                     ctzl(sizeof(ETYPE)), GETPC());                     \
-}                                                                       \
-                                                                        \
-void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
-                  CPURISCVState *env, uint32_t desc)                    \
-{                                                                       \
-    vext_ldst_us(vd, base, env, desc, LOAD_FN,                          \
-                 ctzl(sizeof(ETYPE)), env->vl, GETPC());                \
+#define GEN_VEXT_LD_US(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)      \
+void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,     \
+                         CPURISCVState *env, uint32_t desc)         \
+{                                                                   \
+    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));         \
+    vext_ldst_stride(vd, v0, base, stride, env, desc, false,        \
+                     LOAD_FN_TLB, ctzl(sizeof(ETYPE)), GETPC());    \
+}                                                                   \
+                                                                    \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,            \
+                  CPURISCVState *env, uint32_t desc)                \
+{                                                                   \
+    vext_ldst_us(vd, base, env, desc, LOAD_FN_TLB, LOAD_FN_HOST,    \
+                 ctzl(sizeof(ETYPE)), env->vl, GETPC(), true);      \
 }
 
-GEN_VEXT_LD_US(vle8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_US(vle16_v, int16_t, lde_h)
-GEN_VEXT_LD_US(vle32_v, int32_t, lde_w)
-GEN_VEXT_LD_US(vle64_v, int64_t, lde_d)
+GEN_VEXT_LD_US(vle8_v,  int8_t,  lde_b_tlb, lde_b_host)
+GEN_VEXT_LD_US(vle16_v, int16_t, lde_h_tlb, lde_h_host)
+GEN_VEXT_LD_US(vle32_v, int32_t, lde_w_tlb, lde_w_host)
+GEN_VEXT_LD_US(vle64_v, int64_t, lde_d_tlb, lde_d_host)
 
-#define GEN_VEXT_ST_US(NAME, ETYPE, STORE_FN)                            \
+#define GEN_VEXT_ST_US(NAME, ETYPE, STORE_FN_TLB, STORE_FN_HOST)         \
 void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,          \
                          CPURISCVState *env, uint32_t desc)              \
 {                                                                        \
     uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));              \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, false, STORE_FN,   \
-                     ctzl(sizeof(ETYPE)), GETPC());                      \
+    vext_ldst_stride(vd, v0, base, stride, env, desc, false,             \
+                     STORE_FN_TLB, ctzl(sizeof(ETYPE)), GETPC());        \
 }                                                                        \
                                                                          \
 void HELPER(NAME)(void *vd, void *v0, target_ulong base,                 \
                   CPURISCVState *env, uint32_t desc)                     \
 {                                                                        \
-    vext_ldst_us(vd, base, env, desc, STORE_FN,                          \
-                 ctzl(sizeof(ETYPE)), env->vl, GETPC());                 \
+    vext_ldst_us(vd, base, env, desc, STORE_FN_TLB, STORE_FN_HOST,       \
+                 ctzl(sizeof(ETYPE)), env->vl, GETPC(), false);          \
 }
 
-GEN_VEXT_ST_US(vse8_v,  int8_t,  ste_b)
-GEN_VEXT_ST_US(vse16_v, int16_t, ste_h)
-GEN_VEXT_ST_US(vse32_v, int32_t, ste_w)
-GEN_VEXT_ST_US(vse64_v, int64_t, ste_d)
+GEN_VEXT_ST_US(vse8_v,  int8_t,  ste_b_tlb, ste_b_host)
+GEN_VEXT_ST_US(vse16_v, int16_t, ste_h_tlb, ste_h_host)
+GEN_VEXT_ST_US(vse32_v, int32_t, ste_w_tlb, ste_w_host)
+GEN_VEXT_ST_US(vse64_v, int64_t, ste_d_tlb, ste_d_host)
 
 /*
  * unit stride mask load and store, EEW = 1
@@ -350,8 +434,8 @@ void HELPER(vlm_v)(void *vd, void *v0, target_ulong base,
 {
     /* evl = ceil(vl/8) */
     uint8_t evl = (env->vl + 7) >> 3;
-    vext_ldst_us(vd, base, env, desc, lde_b,
-                 0, evl, GETPC());
+    vext_ldst_us(vd, base, env, desc, lde_b_tlb, lde_b_host,
+                 0, evl, GETPC(), true);
 }
 
 void HELPER(vsm_v)(void *vd, void *v0, target_ulong base,
@@ -359,8 +443,8 @@ void HELPER(vsm_v)(void *vd, void *v0, target_ulong base,
 {
     /* evl = ceil(vl/8) */
     uint8_t evl = (env->vl + 7) >> 3;
-    vext_ldst_us(vd, base, env, desc, ste_b,
-                 0, evl, GETPC());
+    vext_ldst_us(vd, base, env, desc, ste_b_tlb, ste_b_host,
+                 0, evl, GETPC(), false);
 }
 
 /*
@@ -385,7 +469,7 @@ static inline void
 vext_ldst_index(void *vd, void *v0, target_ulong base,
                 void *vs2, CPURISCVState *env, uint32_t desc,
                 vext_get_index_addr get_index_addr,
-                vext_ldst_elem_fn *ldst_elem,
+                vext_ldst_elem_fn_tlb *ldst_elem,
                 uint32_t log2_esz, uintptr_t ra)
 {
     uint32_t i, k;
@@ -426,22 +510,22 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                   \
                     LOAD_FN, ctzl(sizeof(ETYPE)), GETPC());                \
 }
 
-GEN_VEXT_LD_INDEX(vlxei8_8_v,   int8_t,  idx_b, lde_b)
-GEN_VEXT_LD_INDEX(vlxei8_16_v,  int16_t, idx_b, lde_h)
-GEN_VEXT_LD_INDEX(vlxei8_32_v,  int32_t, idx_b, lde_w)
-GEN_VEXT_LD_INDEX(vlxei8_64_v,  int64_t, idx_b, lde_d)
-GEN_VEXT_LD_INDEX(vlxei16_8_v,  int8_t,  idx_h, lde_b)
-GEN_VEXT_LD_INDEX(vlxei16_16_v, int16_t, idx_h, lde_h)
-GEN_VEXT_LD_INDEX(vlxei16_32_v, int32_t, idx_h, lde_w)
-GEN_VEXT_LD_INDEX(vlxei16_64_v, int64_t, idx_h, lde_d)
-GEN_VEXT_LD_INDEX(vlxei32_8_v,  int8_t,  idx_w, lde_b)
-GEN_VEXT_LD_INDEX(vlxei32_16_v, int16_t, idx_w, lde_h)
-GEN_VEXT_LD_INDEX(vlxei32_32_v, int32_t, idx_w, lde_w)
-GEN_VEXT_LD_INDEX(vlxei32_64_v, int64_t, idx_w, lde_d)
-GEN_VEXT_LD_INDEX(vlxei64_8_v,  int8_t,  idx_d, lde_b)
-GEN_VEXT_LD_INDEX(vlxei64_16_v, int16_t, idx_d, lde_h)
-GEN_VEXT_LD_INDEX(vlxei64_32_v, int32_t, idx_d, lde_w)
-GEN_VEXT_LD_INDEX(vlxei64_64_v, int64_t, idx_d, lde_d)
+GEN_VEXT_LD_INDEX(vlxei8_8_v,   int8_t,  idx_b, lde_b_tlb)
+GEN_VEXT_LD_INDEX(vlxei8_16_v,  int16_t, idx_b, lde_h_tlb)
+GEN_VEXT_LD_INDEX(vlxei8_32_v,  int32_t, idx_b, lde_w_tlb)
+GEN_VEXT_LD_INDEX(vlxei8_64_v,  int64_t, idx_b, lde_d_tlb)
+GEN_VEXT_LD_INDEX(vlxei16_8_v,  int8_t,  idx_h, lde_b_tlb)
+GEN_VEXT_LD_INDEX(vlxei16_16_v, int16_t, idx_h, lde_h_tlb)
+GEN_VEXT_LD_INDEX(vlxei16_32_v, int32_t, idx_h, lde_w_tlb)
+GEN_VEXT_LD_INDEX(vlxei16_64_v, int64_t, idx_h, lde_d_tlb)
+GEN_VEXT_LD_INDEX(vlxei32_8_v,  int8_t,  idx_w, lde_b_tlb)
+GEN_VEXT_LD_INDEX(vlxei32_16_v, int16_t, idx_w, lde_h_tlb)
+GEN_VEXT_LD_INDEX(vlxei32_32_v, int32_t, idx_w, lde_w_tlb)
+GEN_VEXT_LD_INDEX(vlxei32_64_v, int64_t, idx_w, lde_d_tlb)
+GEN_VEXT_LD_INDEX(vlxei64_8_v,  int8_t,  idx_d, lde_b_tlb)
+GEN_VEXT_LD_INDEX(vlxei64_16_v, int16_t, idx_d, lde_h_tlb)
+GEN_VEXT_LD_INDEX(vlxei64_32_v, int32_t, idx_d, lde_w_tlb)
+GEN_VEXT_LD_INDEX(vlxei64_64_v, int64_t, idx_d, lde_d_tlb)
 
 #define GEN_VEXT_ST_INDEX(NAME, ETYPE, INDEX_FN, STORE_FN)       \
 void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
@@ -452,22 +536,22 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
                     GETPC());                                    \
 }
 
-GEN_VEXT_ST_INDEX(vsxei8_8_v,   int8_t,  idx_b, ste_b)
-GEN_VEXT_ST_INDEX(vsxei8_16_v,  int16_t, idx_b, ste_h)
-GEN_VEXT_ST_INDEX(vsxei8_32_v,  int32_t, idx_b, ste_w)
-GEN_VEXT_ST_INDEX(vsxei8_64_v,  int64_t, idx_b, ste_d)
-GEN_VEXT_ST_INDEX(vsxei16_8_v,  int8_t,  idx_h, ste_b)
-GEN_VEXT_ST_INDEX(vsxei16_16_v, int16_t, idx_h, ste_h)
-GEN_VEXT_ST_INDEX(vsxei16_32_v, int32_t, idx_h, ste_w)
-GEN_VEXT_ST_INDEX(vsxei16_64_v, int64_t, idx_h, ste_d)
-GEN_VEXT_ST_INDEX(vsxei32_8_v,  int8_t,  idx_w, ste_b)
-GEN_VEXT_ST_INDEX(vsxei32_16_v, int16_t, idx_w, ste_h)
-GEN_VEXT_ST_INDEX(vsxei32_32_v, int32_t, idx_w, ste_w)
-GEN_VEXT_ST_INDEX(vsxei32_64_v, int64_t, idx_w, ste_d)
-GEN_VEXT_ST_INDEX(vsxei64_8_v,  int8_t,  idx_d, ste_b)
-GEN_VEXT_ST_INDEX(vsxei64_16_v, int16_t, idx_d, ste_h)
-GEN_VEXT_ST_INDEX(vsxei64_32_v, int32_t, idx_d, ste_w)
-GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d)
+GEN_VEXT_ST_INDEX(vsxei8_8_v,   int8_t,  idx_b, ste_b_tlb)
+GEN_VEXT_ST_INDEX(vsxei8_16_v,  int16_t, idx_b, ste_h_tlb)
+GEN_VEXT_ST_INDEX(vsxei8_32_v,  int32_t, idx_b, ste_w_tlb)
+GEN_VEXT_ST_INDEX(vsxei8_64_v,  int64_t, idx_b, ste_d_tlb)
+GEN_VEXT_ST_INDEX(vsxei16_8_v,  int8_t,  idx_h, ste_b_tlb)
+GEN_VEXT_ST_INDEX(vsxei16_16_v, int16_t, idx_h, ste_h_tlb)
+GEN_VEXT_ST_INDEX(vsxei16_32_v, int32_t, idx_h, ste_w_tlb)
+GEN_VEXT_ST_INDEX(vsxei16_64_v, int64_t, idx_h, ste_d_tlb)
+GEN_VEXT_ST_INDEX(vsxei32_8_v,  int8_t,  idx_w, ste_b_tlb)
+GEN_VEXT_ST_INDEX(vsxei32_16_v, int16_t, idx_w, ste_h_tlb)
+GEN_VEXT_ST_INDEX(vsxei32_32_v, int32_t, idx_w, ste_w_tlb)
+GEN_VEXT_ST_INDEX(vsxei32_64_v, int64_t, idx_w, ste_d_tlb)
+GEN_VEXT_ST_INDEX(vsxei64_8_v,  int8_t,  idx_d, ste_b_tlb)
+GEN_VEXT_ST_INDEX(vsxei64_16_v, int16_t, idx_d, ste_h_tlb)
+GEN_VEXT_ST_INDEX(vsxei64_32_v, int32_t, idx_d, ste_w_tlb)
+GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d_tlb)
 
 /*
  * unit-stride fault-only-fisrt load instructions
@@ -475,7 +559,7 @@ GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d)
 static inline void
 vext_ldff(void *vd, void *v0, target_ulong base,
           CPURISCVState *env, uint32_t desc,
-          vext_ldst_elem_fn *ldst_elem,
+          vext_ldst_elem_fn_tlb *ldst_elem,
           uint32_t log2_esz, uintptr_t ra)
 {
     uint32_t i, k, vl = 0;
@@ -561,10 +645,10 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,  \
               ctzl(sizeof(ETYPE)), GETPC());              \
 }
 
-GEN_VEXT_LDFF(vle8ff_v,  int8_t,  lde_b)
-GEN_VEXT_LDFF(vle16ff_v, int16_t, lde_h)
-GEN_VEXT_LDFF(vle32ff_v, int32_t, lde_w)
-GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d)
+GEN_VEXT_LDFF(vle8ff_v,  int8_t,  lde_b_tlb)
+GEN_VEXT_LDFF(vle16ff_v, int16_t, lde_h_tlb)
+GEN_VEXT_LDFF(vle32ff_v, int32_t, lde_w_tlb)
+GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb)
 
 #define DO_SWAP(N, M) (M)
 #define DO_AND(N, M)  (N & M)
@@ -581,7 +665,8 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d)
  */
 static void
 vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
-                vext_ldst_elem_fn *ldst_elem, uint32_t log2_esz, uintptr_t ra)
+                vext_ldst_elem_fn_tlb *ldst_elem, uint32_t log2_esz,
+                uintptr_t ra)
 {
     uint32_t i, k, off, pos;
     uint32_t nf = vext_nf(desc);
@@ -625,22 +710,22 @@ void HELPER(NAME)(void *vd, target_ulong base,       \
                     ctzl(sizeof(ETYPE)), GETPC());   \
 }
 
-GEN_VEXT_LD_WHOLE(vl1re8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_WHOLE(vl1re16_v, int16_t, lde_h)
-GEN_VEXT_LD_WHOLE(vl1re32_v, int32_t, lde_w)
-GEN_VEXT_LD_WHOLE(vl1re64_v, int64_t, lde_d)
-GEN_VEXT_LD_WHOLE(vl2re8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_WHOLE(vl2re16_v, int16_t, lde_h)
-GEN_VEXT_LD_WHOLE(vl2re32_v, int32_t, lde_w)
-GEN_VEXT_LD_WHOLE(vl2re64_v, int64_t, lde_d)
-GEN_VEXT_LD_WHOLE(vl4re8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_WHOLE(vl4re16_v, int16_t, lde_h)
-GEN_VEXT_LD_WHOLE(vl4re32_v, int32_t, lde_w)
-GEN_VEXT_LD_WHOLE(vl4re64_v, int64_t, lde_d)
-GEN_VEXT_LD_WHOLE(vl8re8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_WHOLE(vl8re16_v, int16_t, lde_h)
-GEN_VEXT_LD_WHOLE(vl8re32_v, int32_t, lde_w)
-GEN_VEXT_LD_WHOLE(vl8re64_v, int64_t, lde_d)
+GEN_VEXT_LD_WHOLE(vl1re8_v,  int8_t,  lde_b_tlb)
+GEN_VEXT_LD_WHOLE(vl1re16_v, int16_t, lde_h_tlb)
+GEN_VEXT_LD_WHOLE(vl1re32_v, int32_t, lde_w_tlb)
+GEN_VEXT_LD_WHOLE(vl1re64_v, int64_t, lde_d_tlb)
+GEN_VEXT_LD_WHOLE(vl2re8_v,  int8_t,  lde_b_tlb)
+GEN_VEXT_LD_WHOLE(vl2re16_v, int16_t, lde_h_tlb)
+GEN_VEXT_LD_WHOLE(vl2re32_v, int32_t, lde_w_tlb)
+GEN_VEXT_LD_WHOLE(vl2re64_v, int64_t, lde_d_tlb)
+GEN_VEXT_LD_WHOLE(vl4re8_v,  int8_t,  lde_b_tlb)
+GEN_VEXT_LD_WHOLE(vl4re16_v, int16_t, lde_h_tlb)
+GEN_VEXT_LD_WHOLE(vl4re32_v, int32_t, lde_w_tlb)
+GEN_VEXT_LD_WHOLE(vl4re64_v, int64_t, lde_d_tlb)
+GEN_VEXT_LD_WHOLE(vl8re8_v,  int8_t,  lde_b_tlb)
+GEN_VEXT_LD_WHOLE(vl8re16_v, int16_t, lde_h_tlb)
+GEN_VEXT_LD_WHOLE(vl8re32_v, int32_t, lde_w_tlb)
+GEN_VEXT_LD_WHOLE(vl8re64_v, int64_t, lde_d_tlb)
 
 #define GEN_VEXT_ST_WHOLE(NAME, ETYPE, STORE_FN)     \
 void HELPER(NAME)(void *vd, target_ulong base,       \
@@ -650,10 +735,10 @@ void HELPER(NAME)(void *vd, target_ulong base,       \
                     ctzl(sizeof(ETYPE)), GETPC());   \
 }
 
-GEN_VEXT_ST_WHOLE(vs1r_v, int8_t, ste_b)
-GEN_VEXT_ST_WHOLE(vs2r_v, int8_t, ste_b)
-GEN_VEXT_ST_WHOLE(vs4r_v, int8_t, ste_b)
-GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b)
+GEN_VEXT_ST_WHOLE(vs1r_v, int8_t, ste_b_tlb)
+GEN_VEXT_ST_WHOLE(vs2r_v, int8_t, ste_b_tlb)
+GEN_VEXT_ST_WHOLE(vs4r_v, int8_t, ste_b_tlb)
+GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b_tlb)
 
 /*
  * Vector Integer Arithmetic Instructions
-- 
2.34.1


