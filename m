Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88563C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4sw-0000Sr-BG; Wed, 17 Jul 2024 09:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sU4su-0000Mr-RN
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:39:56 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sU4sr-0007SF-U6
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:39:56 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fbfb8e5e0cso48541275ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721223592; x=1721828392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWJCUGOB3yGRYzMSOqJt//vIQjqu868mkDHHMDRR26Y=;
 b=j0rixpThQNcgAEOd3qHYaKTaMppFvkiRg1i2qR/cEBzHREhwZ2DvmxKMZQeFQq0XcE
 H85oA81+Bphcw40d9Q/sqlgGiANzq0lM1DzChLMgKX4yAbDKiD2Nyvgpbg/1Fw8IChCd
 MqrBMi1yDhRoX8XnsnE/A7F1DvXrTPSfaAnRp0NCqs1pyPVMbAGYgRMPG4Dk/VNXpHlv
 wPfhW0E9PHrYqRGaFgN7IZgcob43WoujQuNjJ8yUwfVOEhOH2KmwnuJovguvI1tlU5m1
 QKOKDU/Y0QcFdoREqFb1iL40r3douCWz/hjcC4NNjiDeUwBUcYYQ/UI984RnumVJFb3x
 VfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721223592; x=1721828392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWJCUGOB3yGRYzMSOqJt//vIQjqu868mkDHHMDRR26Y=;
 b=gVItRw226onymlcZxBD9u5dL36ZSzJO/kgY/+n9OGcV20ufcDwPYCZvU5zKc3HNVh3
 RThusTVKX/2L6Yah5LOFrsHhu27C0WWt4Vgq+Pvs7kOkCqyz0qQNhEuGZju2Wx0w3GKf
 zuRAP2LfYTougTg431OqInbiVsfCXlUCOd0w7FapVYXnDwPboY1QZKPrwockMLDXI0RG
 8oK/6kTHzlhiPn9D8MrH+pyeedAAx7HSideRMWf5NnGL+HKDRfbociUaXLPpEv4f+G98
 kjc+45qOc4mbXgQFMStUblOZ08HTAFCssZkC3ft1xYTTazt4mrTYeN/bWQ2FV1NDbolS
 MGZg==
X-Gm-Message-State: AOJu0YxpKDaoNXLvkHioo60sOG8KzAkhag2yeIgIVzSza///Xac9OCcY
 36pfgr1HFgX91xssHq1drvl2c5T1fCI3mXepxuLZrbt1SL294HrGGe+b6OOIzw677bm2od9ADaZ
 jYyOKlzKO+aIvfUFy7J1kjBKrNsALFek53LKW87ewEzobbEd/oRuSjWEfpBvoNoqLc4Lzxkh+1p
 CKbvAvAZf3VBV6wx22/KuWEctAEVI1Eow7o2O+cw==
X-Google-Smtp-Source: AGHT+IHpatpH5R1Icul3xDqPaJDIAep+jodvKmSRn1CWTf/oPi4uCD2kBh8p252U7OxEV/Q3y9ZXoQ==
X-Received: by 2002:a17:902:d2c6:b0:1fb:8e98:4468 with SMTP id
 d9443c01a7336-1fc4e6b6e3emr12186685ad.50.1721223591224; 
 Wed, 17 Jul 2024 06:39:51 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc5aa6esm74903495ad.299.2024.07.17.06.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 06:39:50 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v5 2/5] target/riscv: rvv: Provide a fast path using
 direct access to host ram for unmasked unit-stride load/store
Date: Wed, 17 Jul 2024 21:39:33 +0800
Message-Id: <20240717133936.713642-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717133936.713642-1-max.chou@sifive.com>
References: <20240717133936.713642-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x636.google.com
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
 target/riscv/vector_helper.c | 361 +++++++++++++++++++++--------------
 1 file changed, 220 insertions(+), 141 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 4d72eb74d3a..23396a1b750 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -146,34 +146,47 @@ static inline void vext_set_elem_mask(void *v0, int index,
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
+#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)                         \
+static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,                \
+                       uint32_t byte_off, void *vd, uintptr_t retaddr)  \
+{                                                                       \
+    ETYPE *cur = vd + byte_off;                                         \
+    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);                   \
+}                                                                       \
+                                                                        \
+static void NAME##_host(void *vd, uint32_t byte_off, void *host)        \
+{                                                                       \
+    ETYPE val = LDSUF##_p(host);                                        \
+    *(ETYPE *)(vd + byte_off) = val;                                    \
+}
+
+GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
+GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw)
+GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq)
+
+#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                         \
+static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,                \
+                       uint32_t byte_off, void *vd, uintptr_t retaddr)  \
+{                                                                       \
+    ETYPE data = *(ETYPE *)(vd + byte_off);                             \
+    cpu_##STSUF##_data_ra(env, addr, data, retaddr);                    \
+}                                                                       \
+                                                                        \
+static void NAME##_host(void *vd, uint32_t byte_off, void *host)        \
+{                                                                       \
+    ETYPE val = *(ETYPE *)(vd + byte_off);                              \
+    STSUF##_p(host, val);                                               \
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
@@ -199,7 +212,7 @@ static void
 vext_ldst_stride(void *vd, void *v0, target_ulong base,
                  target_ulong stride, CPURISCVState *env,
                  uint32_t desc, uint32_t vm,
-                 vext_ldst_elem_fn *ldst_elem,
+                 vext_ldst_elem_fn_tlb * ldst_elem,
                  uint32_t log2_esz, uintptr_t ra)
 {
     uint32_t i, k;
@@ -221,7 +234,8 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
                 continue;
             }
             target_ulong addr = base + stride * i + (k << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
+            ldst_elem(env, adjust_addr(env, addr),
+                      (i + k * max_elems) << log2_esz, vd, ra);
             k++;
         }
     }
@@ -240,10 +254,10 @@ void HELPER(NAME)(void *vd, void * v0, target_ulong base,               \
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
@@ -255,39 +269,100 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
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
+                  uint32_t log2_esz, bool is_load,
+                  vext_ldst_elem_fn_tlb *ldst_tlb,
+                  vext_ldst_elem_fn_host *ldst_host, uintptr_t ra)
+{
+    void *host;
+    int i, k, flags;
+    uint32_t esz = 1 << log2_esz;
+    uint32_t size = (elems * nf) << log2_esz;
+    uint32_t evl = env->vstart + elems;
+    int mmu_index = riscv_env_mmu_index(env, false);
+    MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
+
+    /* Check page permission/pmp/watchpoint/etc. */
+    flags = probe_access_flags(env, adjust_addr(env, addr), size, access_type,
+                               mmu_index, true, &host, ra);
+
+    if (host && flags == 0) {
+        for (i = env->vstart; i < evl; ++i) {
+            k = 0;
+            while (k < nf) {
+                ldst_host(vd, (i + k * max_elems) << log2_esz, host);
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
+                ldst_tlb(env, adjust_addr(env, addr),
+                         (i + k * max_elems) << log2_esz, vd, ra);
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
 
     VSTART_CHECK_EARLY_EXIT(env);
 
-    /* load bytes from guest memory */
-    for (i = env->vstart; i < evl; env->vstart = ++i) {
-        k = 0;
-        while (k < nf) {
-            target_ulong addr = base + ((i * nf + k) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
-            k++;
+    while (env->vstart < evl) {
+        /* Calculate page range */
+        addr = base + ((env->vstart * nf) << log2_esz);
+        page_split = -(addr | TARGET_PAGE_MASK);
+        /* Get number of elements */
+        elems = page_split / msize;
+        if (unlikely(env->vstart + elems >= evl)) {
+            elems = evl - env->vstart;
+        }
+
+        /* Load/store elements in page */
+        vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, log2_esz,
+                          is_load, ldst_tlb, ldst_host, ra);
+
+        /* Cross page element */
+        if (unlikely((page_split % msize) != 0 && (env->vstart + 1) < evl)) {
+            for (k = 0; k < nf; k++) {
+                addr = base + ((env->vstart * nf + k) << log2_esz);
+                ldst_tlb(env, adjust_addr(env, addr),
+                         (k * max_elems + env->vstart) << log2_esz, vd, ra);
+            }
+            env->vstart++;
         }
     }
-    env->vstart = 0;
 
+    env->vstart = 0;
     vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
 }
 
@@ -296,47 +371,47 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
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
@@ -346,8 +421,8 @@ void HELPER(vlm_v)(void *vd, void *v0, target_ulong base,
 {
     /* evl = ceil(vl/8) */
     uint8_t evl = (env->vl + 7) >> 3;
-    vext_ldst_us(vd, base, env, desc, lde_b,
-                 0, evl, GETPC());
+    vext_ldst_us(vd, base, env, desc, lde_b_tlb, lde_b_host,
+                 0, evl, GETPC(), true);
 }
 
 void HELPER(vsm_v)(void *vd, void *v0, target_ulong base,
@@ -355,8 +430,8 @@ void HELPER(vsm_v)(void *vd, void *v0, target_ulong base,
 {
     /* evl = ceil(vl/8) */
     uint8_t evl = (env->vl + 7) >> 3;
-    vext_ldst_us(vd, base, env, desc, ste_b,
-                 0, evl, GETPC());
+    vext_ldst_us(vd, base, env, desc, ste_b_tlb, ste_b_host,
+                 0, evl, GETPC(), false);
 }
 
 /*
@@ -381,7 +456,7 @@ static inline void
 vext_ldst_index(void *vd, void *v0, target_ulong base,
                 void *vs2, CPURISCVState *env, uint32_t desc,
                 vext_get_index_addr get_index_addr,
-                vext_ldst_elem_fn *ldst_elem,
+                vext_ldst_elem_fn_tlb *ldst_elem,
                 uint32_t log2_esz, uintptr_t ra)
 {
     uint32_t i, k;
@@ -405,7 +480,8 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
                 continue;
             }
             abi_ptr addr = get_index_addr(base, i, vs2) + (k << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
+            ldst_elem(env, adjust_addr(env, addr),
+                      (i + k * max_elems) << log2_esz, vd, ra);
             k++;
         }
     }
@@ -422,22 +498,22 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                   \
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
@@ -448,22 +524,22 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
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
@@ -471,7 +547,7 @@ GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d)
 static inline void
 vext_ldff(void *vd, void *v0, target_ulong base,
           CPURISCVState *env, uint32_t desc,
-          vext_ldst_elem_fn *ldst_elem,
+          vext_ldst_elem_fn_tlb *ldst_elem,
           uint32_t log2_esz, uintptr_t ra)
 {
     uint32_t i, k, vl = 0;
@@ -539,7 +615,8 @@ vext_ldff(void *vd, void *v0, target_ulong base,
                 continue;
             }
             addr = base + ((i * nf + k) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
+            ldst_elem(env, adjust_addr(env, addr),
+                      (i + k * max_elems) << log2_esz, vd, ra);
             k++;
         }
     }
@@ -556,10 +633,10 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,  \
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
@@ -576,7 +653,8 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d)
  */
 static void
 vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
-                vext_ldst_elem_fn *ldst_elem, uint32_t log2_esz, uintptr_t ra)
+                vext_ldst_elem_fn_tlb *ldst_elem, uint32_t log2_esz,
+                uintptr_t ra)
 {
     uint32_t i, k, off, pos;
     uint32_t nf = vext_nf(desc);
@@ -595,8 +673,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         /* load/store rest of elements of current segment pointed by vstart */
         for (pos = off; pos < max_elems; pos++, env->vstart++) {
             target_ulong addr = base + ((pos + k * max_elems) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), pos + k * max_elems, vd,
-                      ra);
+            ldst_elem(env, adjust_addr(env, addr),
+                      (pos + k * max_elems) << log2_esz, vd, ra);
         }
         k++;
     }
@@ -605,7 +683,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     for (; k < nf; k++) {
         for (i = 0; i < max_elems; i++, env->vstart++) {
             target_ulong addr = base + ((i + k * max_elems) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
+            ldst_elem(env, adjust_addr(env, addr),
+                      (i + k * max_elems) << log2_esz, vd, ra);
         }
     }
 
@@ -620,22 +699,22 @@ void HELPER(NAME)(void *vd, target_ulong base,       \
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
@@ -645,10 +724,10 @@ void HELPER(NAME)(void *vd, target_ulong base,       \
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


