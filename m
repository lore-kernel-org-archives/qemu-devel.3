Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC54DC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHobv-00076N-F6; Thu, 13 Jun 2024 13:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHobt-00075O-LS
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:51:41 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHobr-0002d0-Ag
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:51:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f47f07aceaso12309045ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718301098; x=1718905898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbbhXU+D2a2z0zlNrJgBTx/auUyPuzgul9ffEU9GMBY=;
 b=eO26abdSpgrabh7u/T6b+6zLvsCvC6emlbFtpYNuxG4Y6vOeJ473C5+pAiH6useNre
 wWsfuJCerhcI+AT4FPbP550n+40VGPTHQFZRMo6HTUgWZmOXPzApoWnwcYFag90U+WRH
 FQz71Gz6ibLc0gRVBrW2EIj1htsncG+FMTHwk4To/hYkCjep8ldGzSnJoqqGPYZbaUt9
 zw8+X20o/Fl3mvnv3kmdM+gUn1nubTu6NOcu6D2AJ2ow3H9+6XXBTlUlRawqH4NRDish
 69yJdfLZLj4w3tAAFKD/KwBCDwCSvBMUgyJtYCKHlT1yMccz9TkAJ9GAEGK6zIJRTj+w
 CWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718301098; x=1718905898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbbhXU+D2a2z0zlNrJgBTx/auUyPuzgul9ffEU9GMBY=;
 b=aOdnvgBawSEg3Xu1sdXu+sdsgCivbzywa0ECACr9n0BBlqBftgZk+kZ8YKf87ekM9o
 2k27FgVfmrvYmOmFqJ2Ssf+X3E4YyBYUMH3+2KDpQWh2YmA5TR0SY8oblUKr6KBZ+E0d
 TZLHeRHPSJDgk4ywGbRAFIt817sK9oTM+zUxNu2/s3Sued4QUq0ZnxV2OFLsPayyUyWM
 K5+byPr5Wc5Jj8TnD7b+VrBUIEb1nZtMj3AY1cwvs9qRsLlof/pX3zvMiHPzO9/sXy5c
 cIdjffOKLvbgy+d0CB+26oTdmMW0pzP2yTHQodY2S3IayvWlOT4x+73RvyQ5W4yg/dFm
 HjHg==
X-Gm-Message-State: AOJu0Yyf16Dw+sbTncZ2478OEmfHlWUzjGW0XEKG8eXfK3YeA/UbBPIm
 xnbjzBjlNpJnGMEnoMpFkGo/+wGhGGAuLD+C04buQBKNoe14ECLOIUgHLacs1rCVpXaceTlgdAP
 7MUJY0IaIO3NA+hOSrOFBcPN/9BQTCDuZTU+BG5DB2W3/YMJjkn4mRCJ6CUswPm+0UEZmzoivr7
 Pg0WMtUvUodle/hI6OdCMbvNqq1t7dScpeJdfjmQ==
X-Google-Smtp-Source: AGHT+IHxuOeGGItFkst6d8wnU8yqm31Rw0Qs3molr4WIOT8xJeXogNQPT5IeOWEPdDxNh0IhT9Y/7g==
X-Received: by 2002:a17:902:b711:b0:1f7:187f:cb63 with SMTP id
 d9443c01a7336-1f862a168e7mr3303525ad.47.1718301097695; 
 Thu, 13 Jun 2024 10:51:37 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e55d7dsm16780865ad.14.2024.06.13.10.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 10:51:37 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v4 3/5] target/riscv: rvv: Provide a fast path using
 direct access to host ram for unit-stride whole register load/store
Date: Fri, 14 Jun 2024 01:51:20 +0800
Message-Id: <20240613175122.1299212-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613175122.1299212-1-max.chou@sifive.com>
References: <20240613175122.1299212-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The vector unit-stride whole register load/store instructions are
similar to unmasked unit-stride load/store instructions that is suitable
to be optimized by using a direct access to host ram fast path.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 185 +++++++++++++++++++++++++----------
 1 file changed, 133 insertions(+), 52 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 3d284138fb3..793337a6f96 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -935,81 +935,162 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb)
  */
 static void
 vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
-                vext_ldst_elem_fn_tlb *ldst_elem, uint32_t log2_esz,
-                uintptr_t ra)
+                vext_ldst_elem_fn_tlb *ldst_tlb,
+                vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
+                uintptr_t ra, bool is_load)
 {
-    uint32_t i, k, off, pos;
+    RVVContLdSt info;
+    target_ulong addr;
+    void *host;
+    int flags;
+    intptr_t reg_start, reg_last;
+    uint32_t idx_nf, off, evl;
     uint32_t nf = vext_nf(desc);
     uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
     uint32_t max_elems = vlenb >> log2_esz;
+    uint32_t esz = 1 << log2_esz;
 
     if (env->vstart >= ((vlenb * nf) >> log2_esz)) {
         env->vstart = 0;
         return;
     }
 
-    k = env->vstart / max_elems;
-    off = env->vstart % max_elems;
+    vext_cont_ldst_elements(&info, base, env->vreg, env->vstart,
+                            nf * max_elems, desc, log2_esz, true);
+    vext_cont_ldst_pages(env, &info, base, is_load, desc, esz, ra, true);
+    vext_cont_ldst_watchpoints(env, &info, env->vreg, base, esz, is_load, ra,
+                               desc);
+
+    flags = info.page[0].flags | info.page[1].flags;
+    if (unlikely(flags != 0)) {
+        /* At least one page includes MMIO. */
+        reg_start = info.reg_idx_first[0];
+        idx_nf = reg_start / max_elems;
+        off = reg_start % max_elems;
+        evl = (idx_nf + 1) * max_elems;
+
+        if (off) {
+            /*
+             * load/store rest of elements of current segment pointed by vstart
+             */
+            addr = base + (reg_start << log2_esz);
+            for (; reg_start < evl; reg_start++, addr += esz) {
+                ldst_tlb(env, adjust_addr(env, addr), reg_start << log2_esz,
+                         vd, ra);
+            }
+            idx_nf++;
+        }
+
+        /* load/store elements for rest of segments */
+        evl = nf * max_elems;
+        addr = base + (reg_start << log2_esz);
+        for (; reg_start < evl; reg_start++, addr += esz) {
+            ldst_tlb(env, adjust_addr(env, addr), reg_start << log2_esz, vd,
+                     ra);
+        }
+
+        env->vstart = 0;
+        return;
+    }
+
+    /* The entire operation is in RAM, on valid pages. */
+    reg_start = info.reg_idx_first[0];
+    reg_last = info.reg_idx_last[0] + 1;
+    host = info.page[0].host;
+    idx_nf = reg_start / max_elems;
+    off = reg_start % max_elems;
+    evl = (idx_nf + 1) * max_elems;
 
     if (off) {
         /* load/store rest of elements of current segment pointed by vstart */
-        for (pos = off; pos < max_elems; pos++, env->vstart++) {
-            target_ulong addr = base + ((pos + k * max_elems) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr),
-                      (pos + k * max_elems) << log2_esz, vd, ra);
+        for (; reg_start < evl; reg_start++) {
+            ldst_host(vd, reg_start << log2_esz,
+                      host + (reg_start << log2_esz));
         }
-        k++;
+        idx_nf++;
     }
 
     /* load/store elements for rest of segments */
-    for (; k < nf; k++) {
-        for (i = 0; i < max_elems; i++, env->vstart++) {
-            target_ulong addr = base + ((i + k * max_elems) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr),
-                      (i + k * max_elems) << log2_esz, vd, ra);
+    for (; reg_start < reg_last; reg_start++) {
+        ldst_host(vd, reg_start << log2_esz, host + (reg_start << log2_esz));
+    }
+
+    /*
+     * Use the slow path to manage the cross-page misalignment.
+     * But we know this is RAM and cannot trap.
+     */
+    if (unlikely(info.mem_off_split >= 0)) {
+        reg_start = info.reg_idx_split;
+        addr = base + (reg_start << log2_esz);
+        ldst_tlb(env, adjust_addr(env, addr), reg_start << log2_esz, vd, ra);
+    }
+
+    if (unlikely(info.mem_off_first[1] >= 0)) {
+        reg_start = info.reg_idx_first[1];
+        reg_last = info.reg_idx_last[1] + 1;
+        host = info.page[1].host;
+        idx_nf = reg_start / max_elems;
+        off = reg_start % max_elems;
+        evl = (idx_nf + 1) * max_elems;
+
+        if (off) {
+            /*
+             * load/store rest of elements of current segment pointed by vstart
+             */
+            for (; reg_start < evl; reg_start++) {
+                ldst_host(vd, reg_start << log2_esz,
+                          host + (reg_start << log2_esz));
+            }
+            idx_nf++;
+        }
+
+        /* load/store elements for rest of segments */
+        for (; reg_start < reg_last; reg_start++) {
+            ldst_host(vd, reg_start << log2_esz,
+                      host + (reg_start << log2_esz));
         }
     }
 
     env->vstart = 0;
 }
 
-#define GEN_VEXT_LD_WHOLE(NAME, ETYPE, LOAD_FN)      \
-void HELPER(NAME)(void *vd, target_ulong base,       \
-                  CPURISCVState *env, uint32_t desc) \
-{                                                    \
-    vext_ldst_whole(vd, base, env, desc, LOAD_FN,    \
-                    ctzl(sizeof(ETYPE)), GETPC());   \
-}
-
-GEN_VEXT_LD_WHOLE(vl1re8_v,  int8_t,  lde_b_tlb)
-GEN_VEXT_LD_WHOLE(vl1re16_v, int16_t, lde_h_tlb)
-GEN_VEXT_LD_WHOLE(vl1re32_v, int32_t, lde_w_tlb)
-GEN_VEXT_LD_WHOLE(vl1re64_v, int64_t, lde_d_tlb)
-GEN_VEXT_LD_WHOLE(vl2re8_v,  int8_t,  lde_b_tlb)
-GEN_VEXT_LD_WHOLE(vl2re16_v, int16_t, lde_h_tlb)
-GEN_VEXT_LD_WHOLE(vl2re32_v, int32_t, lde_w_tlb)
-GEN_VEXT_LD_WHOLE(vl2re64_v, int64_t, lde_d_tlb)
-GEN_VEXT_LD_WHOLE(vl4re8_v,  int8_t,  lde_b_tlb)
-GEN_VEXT_LD_WHOLE(vl4re16_v, int16_t, lde_h_tlb)
-GEN_VEXT_LD_WHOLE(vl4re32_v, int32_t, lde_w_tlb)
-GEN_VEXT_LD_WHOLE(vl4re64_v, int64_t, lde_d_tlb)
-GEN_VEXT_LD_WHOLE(vl8re8_v,  int8_t,  lde_b_tlb)
-GEN_VEXT_LD_WHOLE(vl8re16_v, int16_t, lde_h_tlb)
-GEN_VEXT_LD_WHOLE(vl8re32_v, int32_t, lde_w_tlb)
-GEN_VEXT_LD_WHOLE(vl8re64_v, int64_t, lde_d_tlb)
-
-#define GEN_VEXT_ST_WHOLE(NAME, ETYPE, STORE_FN)     \
-void HELPER(NAME)(void *vd, target_ulong base,       \
-                  CPURISCVState *env, uint32_t desc) \
-{                                                    \
-    vext_ldst_whole(vd, base, env, desc, STORE_FN,   \
-                    ctzl(sizeof(ETYPE)), GETPC());   \
-}
-
-GEN_VEXT_ST_WHOLE(vs1r_v, int8_t, ste_b_tlb)
-GEN_VEXT_ST_WHOLE(vs2r_v, int8_t, ste_b_tlb)
-GEN_VEXT_ST_WHOLE(vs4r_v, int8_t, ste_b_tlb)
-GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b_tlb)
+#define GEN_VEXT_LD_WHOLE(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)   \
+void HELPER(NAME)(void *vd, target_ulong base, CPURISCVState *env,  \
+                  uint32_t desc)                                    \
+{                                                                   \
+    vext_ldst_whole(vd, base, env, desc, LOAD_FN_TLB, LOAD_FN_HOST, \
+                    ctzl(sizeof(ETYPE)), GETPC(), true);            \
+}
+
+GEN_VEXT_LD_WHOLE(vl1re8_v,  int8_t,  lde_b_tlb, lde_b_host)
+GEN_VEXT_LD_WHOLE(vl1re16_v, int16_t, lde_h_tlb, lde_h_host)
+GEN_VEXT_LD_WHOLE(vl1re32_v, int32_t, lde_w_tlb, lde_w_host)
+GEN_VEXT_LD_WHOLE(vl1re64_v, int64_t, lde_d_tlb, lde_d_host)
+GEN_VEXT_LD_WHOLE(vl2re8_v,  int8_t,  lde_b_tlb, lde_b_host)
+GEN_VEXT_LD_WHOLE(vl2re16_v, int16_t, lde_h_tlb, lde_h_host)
+GEN_VEXT_LD_WHOLE(vl2re32_v, int32_t, lde_w_tlb, lde_w_host)
+GEN_VEXT_LD_WHOLE(vl2re64_v, int64_t, lde_d_tlb, lde_d_host)
+GEN_VEXT_LD_WHOLE(vl4re8_v,  int8_t,  lde_b_tlb, lde_b_host)
+GEN_VEXT_LD_WHOLE(vl4re16_v, int16_t, lde_h_tlb, lde_h_host)
+GEN_VEXT_LD_WHOLE(vl4re32_v, int32_t, lde_w_tlb, lde_w_host)
+GEN_VEXT_LD_WHOLE(vl4re64_v, int64_t, lde_d_tlb, lde_d_host)
+GEN_VEXT_LD_WHOLE(vl8re8_v,  int8_t,  lde_b_tlb, lde_b_host)
+GEN_VEXT_LD_WHOLE(vl8re16_v, int16_t, lde_h_tlb, lde_h_host)
+GEN_VEXT_LD_WHOLE(vl8re32_v, int32_t, lde_w_tlb, lde_w_host)
+GEN_VEXT_LD_WHOLE(vl8re64_v, int64_t, lde_d_tlb, lde_d_host)
+
+#define GEN_VEXT_ST_WHOLE(NAME, ETYPE, STORE_FN_TLB, STORE_FN_HOST)     \
+void HELPER(NAME)(void *vd, target_ulong base, CPURISCVState *env,      \
+                  uint32_t desc)                                        \
+{                                                                       \
+    vext_ldst_whole(vd, base, env, desc, STORE_FN_TLB, STORE_FN_HOST,   \
+                    ctzl(sizeof(ETYPE)), GETPC(), false);               \
+}
+
+GEN_VEXT_ST_WHOLE(vs1r_v, int8_t, ste_b_tlb, ste_b_host)
+GEN_VEXT_ST_WHOLE(vs2r_v, int8_t, ste_b_tlb, ste_b_host)
+GEN_VEXT_ST_WHOLE(vs4r_v, int8_t, ste_b_tlb, ste_b_host)
+GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b_tlb, ste_b_host)
 
 /*
  * Vector Integer Arithmetic Instructions
-- 
2.34.1


