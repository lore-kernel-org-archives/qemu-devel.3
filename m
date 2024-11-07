Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBF7D5AE5F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 04:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8trD-0006Fe-1d; Wed, 06 Nov 2024 23:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8trC-0006FR-2D
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:54 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8trA-00050E-AP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:53 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso5531665ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 20:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730952650; x=1731557450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxXLp9CGYXId0860br5UNhIvqsxNnWf1Fs9zYkkG6Sg=;
 b=TJC3GxYmhbt2QGbDeltV2PTa9aExOs2sBYNc6QJ79eKjD2GOu3V9lPDLqlUP/E5jSH
 rYjLiF+IWWdesb7YgYabVZi4ileCszcQoBU51tnuEOYw1hGhGTFpsBiyAtv5Zj+eEsKA
 lkpUMaGrJ7flUkGdUhcAYYxZp20/15GBIo+NaRKnLo4H4p7PRG9XbE/Jnf+3k1LEFVWc
 gc/0qp8AlaYHgY9Uhs5CrMqTlUyEUXTCXAOmLDG1yJcygIOpzXve2Let4buJi40bbqea
 MbFQjTdozEUDq+9QAIA6f0rrfb96tax4apF0LnAo/6vsRV6sqo8LqSyQkShTjS95StQ4
 8+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730952650; x=1731557450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxXLp9CGYXId0860br5UNhIvqsxNnWf1Fs9zYkkG6Sg=;
 b=wvr0442v2MkBUXLw2X4sSCKSDnq1VZw3puyWYdfKu32spUnqh92AK94TSr7z2W7IZA
 EAKWagtxX3n0bnizGabCr98eaGitPUSdoiFtDnkDEmmg0xmzbS6dyFq4xfdkGuGNH3jz
 0IwuHn1u32VzTLda9dylKJIT+Lx2tFtKmeY9a58Mr5Zc3kUYwRIrvNx/7fp7uBmWJYpL
 zkelME2kotAZPRFpI6axx0o7QbBbRsGyP5yPSkv/Xd/o9dxqRsLiM+hCKwpwLLwVlHBD
 yMYl5LwkTquKq9fN1c4qqMlr9TWnfgiy7Dy+jUyW0yeNLzsQmty+NjiUmkYQulSKVrBT
 kfGA==
X-Gm-Message-State: AOJu0YwBiT7oDKlitTgnwPHrkonq0OVhqoTrQLmAmY9YqWTpG30z8ASL
 hpmPd5q8rz4VlohfP/6ACb9qjLoFtmWIFp6U3/gDKzqI1UDLgkrUbjv3ng==
X-Google-Smtp-Source: AGHT+IGhGXYNlSC2FAm0AuaaWCXX00ac/y+bBCFRTemyzeH8KTog70u5f7luAg7zDY4pUzPqlsJW2g==
X-Received: by 2002:a17:902:ea0d:b0:210:f69c:bebe with SMTP id
 d9443c01a7336-210f69cc47cmr459319995ad.38.1730952650164; 
 Wed, 06 Nov 2024 20:10:50 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc3f12sm2789105ad.9.2024.11.06.20.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 20:10:49 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/12] target/riscv: rvv: Provide a fast path using direct
 access to host ram for unit-stride load-only-first load instructions
Date: Thu,  7 Nov 2024 14:10:12 +1000
Message-ID: <20241107041016.40800-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107041016.40800-1-alistair.francis@wdc.com>
References: <20241107041016.40800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

The unmasked unit-stride fault-only-first load instructions are similar
to the unmasked unit-stride load/store instructions that is suitable to
be optimized by using a direct access to host ram fast path.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240918171412.150107-6-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 98 ++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 27 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ddcd1600e8..d8d476c3ea 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -558,18 +558,18 @@ GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d_tlb)
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
@@ -618,19 +618,63 @@ ProbeSuccess:
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
@@ -638,18 +682,18 @@ ProbeSuccess:
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
2.47.0


