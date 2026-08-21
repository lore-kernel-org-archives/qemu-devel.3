Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCC3C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUN-000612-JJ; Fri, 21 Aug 2026 00:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUK-0005yF-D1
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:16 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUI-00039s-8C
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:16 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cbedda4c154so328269a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285053; x=1787889853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fuMC9PhVUGvU8XYUJlJKMiY++czJtpI2ArXd7iTeRnQ=;
 b=bIL4biltswjHqYaOsTxFxxI3FUxpwUpNIf7moTLpsrvnBP4vww6NiTZJX09XsYErYN
 A1XWr2jmDsZmL0tANpTwuMuEFoMq/kRM71mgaPtcIOGjV8CFGePOPZfV2tV04QFsNSa2
 EtFH1LDdeBGf/QB81Hq2MqPi3zKwjqljd4f+sLosftumo8u7S3nLUmqtX48rCZhgz/8A
 Mui5SFNWvf4sba4RQ32S8lew0gwdMeUQMF8fKr0SW4hZIpAwmuLNLmpvj+ReIh70w2Ml
 RZHwjEEWs9EQovIdyja4618q9zMursyCQv+dNphiEbOeUJMAviykkEnfnAqHSmCdYDQp
 pDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285053; x=1787889853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fuMC9PhVUGvU8XYUJlJKMiY++czJtpI2ArXd7iTeRnQ=;
 b=hp16jrSgy5RMN2CU/rcmfhoo8FF9Wb4B09TZN2DapIvyg4yAf5xs2ni2GEZ1SpF6Wt
 lMshnbppDi6IMlOZ6Nr7l+dPw2rhGA0P67ubF/Sfv/j/GR9sgp9Ke6XHVL955CMIQzi3
 twSD/0tDXw+t5cvSP0rIVvPLCqgnqXlDx24idyHJuB27Ds8c8vhgqOcx0VELzG27Bk4a
 7oJH4CvNGJReV0eChMxjoDDkL0aN6zm8XToxjFBdFYHNyA4p9H8lDluQGvItRL4hGcrM
 Ax6zR4rhp3cwWcod0lokL8wPqIZWZnOp/vAMCr46XxODMxntG6bqPOPL6CJRk2jXQkMa
 K0ng==
X-Gm-Message-State: AFuF++lzQ1wZZoLHWvBX21Ht/3yfP/35lSs1N+i8bzrSf6avXsFCX8o1
 AGPRu4oiB8jFqRyseC7AkL9guT9Wa8jYhRcm9TPGCjYx9t1tBc8RQjdvnXB2QwnYuUtQd737VsS
 2NJlj
X-Gm-Gg: AR+sD110eHEjFn/NG5bmt0IbT70S8wKUaGgZ06RzuTRdqOWrM6JIN0BWObCbW87TTBJ
 H606+QOENlkQpytpIlnzyjKhOafojEKN3S8epq4PXHx2QT41d1hHsmBx39z1D5SIAnZGXeN/+yP
 ceJfO9oNFAIDNBDqHDZJBsQ2dScUMj5Jh2ig39kuUEieuv6YXrZJvdPsZLK5gXdGnhMdvhiNgP/
 gOIZWKt+tcRLjc1c/WFhSVVFu8LRLFY5n5aHIq9AKsvlsoeiQ/gB+tO6K0+M1UBlBRHQglfJuMt
 BPI1nGhW+Zgfk9KkKNFU3h/4al6Q66u6qZcqwfdASJntwU49PyYcXKcJtIiA7QKo6bCYU30k4S6
 k57di2w4YSxGxeI8ZB1TlzJTtNuGcq68yb/c0hjycOOlSd6J7Ve4AA4BPxAPXOlZIwRkMnQED0s
 iHsGHmNiNuEQvFb6MqvGnq5oLppVCJLk7+uP2b4KhuGdM1ppNET3Qoiq22Gqte/qcmEqA=
X-Received: by 2002:a17:90b:2785:b0:38f:23d6:b4ad with SMTP id
 98e67ed59e1d1-395c3594cf5mr6502794a91.8.1787285052512; 
 Thu, 20 Aug 2026 21:04:12 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 02/23] target/riscv: Split out vext_ldst_nf_tlb
Date: Thu, 20 Aug 2026 21:03:43 -0700
Message-ID: <20260821040404.268123-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Provide a helper that calls ldst_tlb for all NF vectors.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 77 +++++++++++++++-----------------
 1 file changed, 35 insertions(+), 42 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 20a8f95efb..b04d461c08 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -337,6 +337,16 @@ static void vext_set_nf_elems_1s(void *vd, uint32_t i, uint32_t nf,
     }
 }
 
+static void vext_ldst_nf_tlb(CPURISCVState *env, void *vd, target_ulong addr,
+                             uint32_t i, uint32_t nf,
+                             uint32_t esz, uint32_t max_elems,
+                             vext_ldst_elem_fn_tlb *ldst_tlb, uintptr_t ra)
+{
+    for (uint32_t k = 0; k < nf; k++, addr += esz) {
+        ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
+    }
+}
+
 /*
  * stride: access vector element from strided memory
  */
@@ -354,16 +364,11 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base, target_ulong stride,
     VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
     for (uint32_t i = env->vstart; i < env->vl; env->vstart = ++i) {
-        if (!vm && !vext_elem_mask(v0, i)) {
-            if (vma) {
-                vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
-            }
-            continue;
-        }
-
-        for (uint32_t k = 0; k < nf; ++k) {
-            target_ulong addr = base + stride * i + (k << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
+        if (vm || vext_elem_mask(v0, i)) {
+            vext_ldst_nf_tlb(env, vd, base + stride * i, i, nf,
+                             esz, max_elems, ldst_elem, ra);
+        } else if (vma) {
+            vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
         }
     }
 
@@ -417,6 +422,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     int i, k, flags;
     uint32_t esz = 1 << log2_esz;
     uint32_t size = (elems * nf) << log2_esz;
+    uint32_t msize = nf * esz;
     uint32_t evl = env->vstart + elems;
     MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
 
@@ -459,15 +465,10 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
             vext_continuous_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
                                    ra, esz, is_load);
         } else {
-            /* load bytes from guest memory */
             for (i = env->vstart; i < evl; env->vstart = ++i) {
-                k = 0;
-                while (k < nf) {
-                    ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems,
-                             vd, ra);
-                    addr += esz;
-                    k++;
-                }
+                vext_ldst_nf_tlb(env, vd, addr, i, nf, esz,
+                                 max_elems, ldst_tlb, ra);
+                addr += msize;
             }
         }
     }
@@ -479,7 +480,6 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
              uint32_t evl, uintptr_t ra, bool is_load)
 {
-    uint32_t k;
     target_ulong page_split, elems, addr;
     uint32_t nf = vext_nf(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
@@ -522,17 +522,16 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 
     /* Load/store elements in the second page */
     if (unlikely(env->vstart < evl)) {
+        addr = base + env->vstart * msize;
+
         /* Cross page element */
         if (unlikely(page_split % msize)) {
-            for (k = 0; k < nf; k++) {
-                addr = base + ((env->vstart * nf + k) << log2_esz);
-                ldst_tlb(env, adjust_addr(env, addr),
-                        env->vstart + k * max_elems, vd, ra);
-            }
+            vext_ldst_nf_tlb(env, vd, addr, env->vstart,
+                             nf, esz, max_elems, ldst_tlb, ra);
             env->vstart++;
+            addr += msize;
         }
 
-        addr = base + ((env->vstart * nf) << log2_esz);
         /* Get number of elements of second page */
         elems = evl - env->vstart;
 
@@ -723,7 +722,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
           uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
           vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz, uintptr_t ra)
 {
-    uint32_t i, k, vl = 0;
+    uint32_t i, vl = 0;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
@@ -805,17 +804,16 @@ ProbeSuccess:
 
             /* Load/store elements in the second page */
             if (unlikely(env->vstart < env->vl)) {
+                addr = base + env->vstart * msize;
+
                 /* Cross page element */
                 if (unlikely(page_split % msize)) {
-                    for (k = 0; k < nf; k++) {
-                        addr = base + ((env->vstart * nf + k) << log2_esz);
-                        ldst_tlb(env, adjust_addr(env, addr),
-                                 env->vstart + k * max_elems, vd, ra);
-                    }
+                    vext_ldst_nf_tlb(env, vd, addr, env->vstart, nf,
+                                     esz, max_elems, ldst_tlb, ra);
                     env->vstart++;
+                    addr += msize;
                 }
 
-                addr = base + ((env->vstart * nf) << log2_esz);
                 /* Get number of elements of second page */
                 elems = env->vl - env->vstart;
 
@@ -826,16 +824,11 @@ ProbeSuccess:
             }
         } else {
             for (i = env->vstart; i < env->vl; i++) {
-                if (!vext_elem_mask(v0, i)) {
-                    if (vma) {
-                        vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
-                    }
-                    continue;
-                }
-                for (k = 0; k < nf; ++k) {
-                    addr = base + ((i * nf + k) << log2_esz);
-                    ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems,
-                             vd, ra);
+                if (vext_elem_mask(v0, i)) {
+                    vext_ldst_nf_tlb(env, vd, base + i * msize, i, nf,
+                                     esz, max_elems, ldst_tlb, ra);
+                } else if (vma) {
+                    vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
                 }
             }
         }
-- 
2.43.0


