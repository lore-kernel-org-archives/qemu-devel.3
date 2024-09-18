Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9392CDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 17:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqyGT-0007QU-MN; Wed, 18 Sep 2024 13:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sqyGR-0007Fm-Ay
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:14:51 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sqyGP-0001tb-Ga
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:14:51 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7d4fbe62bf5so3588960a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 10:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1726679688; x=1727284488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UxyC5GgURxAdr6hpB+84kRGnovowUYOR8ViU/IS7gA=;
 b=V9MiIywUhIwCOW3ByvstVLKqFjkn3Nc4zMWhkwk9s8BhZS3xkVjI5RZvvgPjy3e2H0
 2fqJDiSw9fUPC1xkzfuSh2o4wkWhpYnlI2yptBm4YNJjpRxbnjBjzJyRxc66EFDs4Lcw
 Fd4DvO66NBBYW1YdwQeeY2SN6Ei00J1fJriOXzU5tZ7YbaBmDqvSp0qOKO1C7ldIpHF6
 EOuJzMk3MCqTs2Kk5IelryjqZLBcVsIkfKwTzi/v6OXGlrnL9vV3Qbbc7kg/4FmHz3u0
 m+uKuilOjh/Qk0xUHekDflPlpyRmvM04LyMKT0XUv07gJ9XvAKgjGy94pBrv+ki32wOp
 bmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726679688; x=1727284488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4UxyC5GgURxAdr6hpB+84kRGnovowUYOR8ViU/IS7gA=;
 b=XjpDkKeB16bD049atSJwnMVqfF2q5zw2Unr9vdlgqEdhbx2jwknRXWUXiVRsnrAWWG
 53HPDd33AGs9SUgOmq6cM+zFfNhTN+30SGgsjevxcm3a38JuReJFDsj3IVtVs1homc/f
 Z0Sjv0BFi4vualGc4Qurt3lf02ipfy5pnZgbM3I9i/2sV9S4nM5GcYsoe+Eu3gKxsi4U
 qXYMTDrDRK4WQpEePBEKB8ekZ8QYwXICPzztMMUX41yhKM1aj66XsuWlJczIb5RLBAoi
 idTZ09/YcKV8ps6Sogpq2czlEspENyedNBW+ReFHTvs73LKfn5WEYsDTVgp9An/VIyAz
 PDwg==
X-Gm-Message-State: AOJu0YxMJVBu0NWAy1vVjafOmbaoeO2wDTaoocEDxiahDczSlPaxPQg4
 he5dvbYv4uum4mgez1C4fr4isp/KENGrlQ//nK+heL/oa0BwdLzN/90CQL2Ob1T17Vwg/Woblzl
 PpGaXRdZs5y5qWrojnXgkCrL+1gkgfaxg5TqLX9gtx4BHUMuXqL7fnHbo0WMlFiDYl/l1TT4ao1
 npxjtXNcYd9Sqkg2s8fG/FBGCgfWWPemq9yhqwng==
X-Google-Smtp-Source: AGHT+IHI7ntPiOdCMMKzQ979btH68h6+Jh4QvzEUE6JCbBWAiTHJBbIQTDMJrslSfzhSYHzn5nwAmw==
X-Received: by 2002:a17:90b:886:b0:2cf:eaec:d74c with SMTP id
 98e67ed59e1d1-2dbb9df6432mr21429460a91.16.1726679687711; 
 Wed, 18 Sep 2024 10:14:47 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dd608e2318sm1914577a91.32.2024.09.18.10.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 10:14:47 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 negge@google.com, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 5/7] target/riscv: rvv: Provide a fast path using direct
 access to host ram for unit-stride load-only-first load instructions
Date: Thu, 19 Sep 2024 01:14:10 +0800
Message-Id: <20240918171412.150107-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918171412.150107-1-max.chou@sifive.com>
References: <20240918171412.150107-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x535.google.com
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

The unmasked unit-stride fault-only-first load instructions are similar
to the unmasked unit-stride load/store instructions that is suitable to
be optimized by using a direct access to host ram fast path.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 98 ++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 27 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 824e6401736..59009a940ff 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -557,18 +557,18 @@ GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d_tlb)
  * unit-stride fault-only-fisrt load instructions
  */
 static inline void
-vext_ldff(void *vd, void *v0, target_ulong base,
-          CPURISCVState *env, uint32_t desc,
-          vext_ldst_elem_fn_tlb *ldst_elem,
-          uint32_t log2_esz, uintptr_t ra)
+vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
+          uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
+          vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz, uintptr_t ra)
 {
     uint32_t i, k, vl = 0;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
+    uint32_t msize = nf * esz;
     uint32_t vma = vext_vma(desc);
-    target_ulong addr, offset, remain;
+    target_ulong addr, offset, remain, page_split, elems;
     int mmu_index = riscv_env_mmu_index(env, false);
 
     VSTART_CHECK_EARLY_EXIT(env);
@@ -617,19 +617,63 @@ ProbeSuccess:
     if (vl != 0) {
         env->vl = vl;
     }
-    for (i = env->vstart; i < env->vl; i++) {
-        k = 0;
-        while (k < nf) {
-            if (!vm && !vext_elem_mask(v0, i)) {
-                /* set masked-off elements to 1s */
-                vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
-                                  (i + k * max_elems + 1) * esz);
-                k++;
-                continue;
+
+    if (env->vstart < env->vl) {
+        if (vm) {
+            /* Calculate the page range of first page */
+            addr = base + ((env->vstart * nf) << log2_esz);
+            page_split = -(addr | TARGET_PAGE_MASK);
+            /* Get number of elements */
+            elems = page_split / msize;
+            if (unlikely(env->vstart + elems >= env->vl)) {
+                elems = env->vl - env->vstart;
+            }
+
+            /* Load/store elements in the first page */
+            if (likely(elems)) {
+                vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
+                                  log2_esz, true, mmu_index, ldst_tlb,
+                                  ldst_host, ra);
+            }
+
+            /* Load/store elements in the second page */
+            if (unlikely(env->vstart < env->vl)) {
+                /* Cross page element */
+                if (unlikely(page_split % msize)) {
+                    for (k = 0; k < nf; k++) {
+                        addr = base + ((env->vstart * nf + k) << log2_esz);
+                        ldst_tlb(env, adjust_addr(env, addr),
+                                 env->vstart + k * max_elems, vd, ra);
+                    }
+                    env->vstart++;
+                }
+
+                addr = base + ((env->vstart * nf) << log2_esz);
+                /* Get number of elements of second page */
+                elems = env->vl - env->vstart;
+
+                /* Load/store elements in the second page */
+                vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
+                                  log2_esz, true, mmu_index, ldst_tlb,
+                                  ldst_host, ra);
+            }
+        } else {
+            for (i = env->vstart; i < env->vl; i++) {
+                k = 0;
+                while (k < nf) {
+                    if (!vext_elem_mask(v0, i)) {
+                        /* set masked-off elements to 1s */
+                        vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
+                                          (i + k * max_elems + 1) * esz);
+                        k++;
+                        continue;
+                    }
+                    addr = base + ((i * nf + k) << log2_esz);
+                    ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems,
+                             vd, ra);
+                    k++;
+                }
             }
-            addr = base + ((i * nf + k) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
-            k++;
         }
     }
     env->vstart = 0;
@@ -637,18 +681,18 @@ ProbeSuccess:
     vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
 }
 
-#define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN)               \
-void HELPER(NAME)(void *vd, void *v0, target_ulong base,  \
-                  CPURISCVState *env, uint32_t desc)      \
-{                                                         \
-    vext_ldff(vd, v0, base, env, desc, LOAD_FN,           \
-              ctzl(sizeof(ETYPE)), GETPC());              \
+#define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)   \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,        \
+                  CPURISCVState *env, uint32_t desc)            \
+{                                                               \
+    vext_ldff(vd, v0, base, env, desc, LOAD_FN_TLB,             \
+              LOAD_FN_HOST, ctzl(sizeof(ETYPE)), GETPC());      \
 }
 
-GEN_VEXT_LDFF(vle8ff_v,  int8_t,  lde_b_tlb)
-GEN_VEXT_LDFF(vle16ff_v, int16_t, lde_h_tlb)
-GEN_VEXT_LDFF(vle32ff_v, int32_t, lde_w_tlb)
-GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb)
+GEN_VEXT_LDFF(vle8ff_v,  int8_t,  lde_b_tlb, lde_b_host)
+GEN_VEXT_LDFF(vle16ff_v, int16_t, lde_h_tlb, lde_h_host)
+GEN_VEXT_LDFF(vle32ff_v, int32_t, lde_w_tlb, lde_w_host)
+GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb, lde_d_host)
 
 #define DO_SWAP(N, M) (M)
 #define DO_AND(N, M)  (N & M)
-- 
2.34.1


