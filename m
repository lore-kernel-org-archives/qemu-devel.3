Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3058EC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4t9-0001JP-Ef; Wed, 17 Jul 2024 09:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sU4t5-00015u-Qn
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:40:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sU4st-0007Sj-Sy
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:40:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fb8781ef1bso54156445ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721223594; x=1721828394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AgdC7+ev+17fl87ruXR55XIU4+t2//DA3K4P/cKC9yA=;
 b=jRHPO91zyD3PeU5/jU8j7Ayy6H1L0dYV8iOO6lgc3CY7+1dg1LSEx3vpIFr9stvWTP
 yheZIhqGz1j+GXre+zCumh44R+TLErppYWLITxWnLYchrHeubCVEiOhcS/sXfgDBqcJQ
 U4n4et5OcGEt9Wkh8ZICsqxSRrzJ3VV1b7TJFMwPJ+c89MGh4YTbtwCLCZwLkcdvAxjU
 pcxoHHAfoiZlwT1FT8iVKORwf7ws2HPnZNZZuHQ0J3ZB+2gx73HjXNkSAjUqP1KFCEQN
 zOpS00Ujk8tfjzKMVtBt/di5iVC/mGlEEI3281H+p0vIpTazW6xI4Y3tUR/hkb6twzKx
 R4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721223594; x=1721828394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AgdC7+ev+17fl87ruXR55XIU4+t2//DA3K4P/cKC9yA=;
 b=jaX4YUF0zQD5ym+be1xTF5yQWQaULh6/05CzGojOjFMIeEURnVo1wwVa9RDL65ksWF
 kqgcGpbgTiobjU1hoF9iFQvafFKV2gmH6LQ+jIyhvvTnGlm8kFJrRnHI6xNQ94r7TUyE
 fB+zrrMwNc3WU+tlk+EJ6Etu1lA3ix45nJxIT5qkNyIoC1PzmL5DK+nMbaQ2/SCsMBbw
 zgVXCSf5WTVnLBKgwRPO+f5+odoTjiLkDwg7PCKntfYgfaD9y+SlNgXEi77nHa5htyus
 VLmCem06aLNbi9Ahq0QzuHne0K7/PMDYopoGEyqgFkg8mV5h3kOLdHNMFgXX3l5XiY+e
 lexQ==
X-Gm-Message-State: AOJu0YwOkpsRkyZ9EMDgvyxmprMGlPW6pkvLdXTHrRxjG2JSOjOIKzp2
 vG0HhHq8x5hQ9il9PP60VtYCv14ZAfo0FUlzsn5d36av9Ul25LnDbVA/iodSADunYHzSsHpweu3
 glL/pI/TjK5pH6tLXiVOOze5Ph6mzWmybwIcuvQjoVn84W2qpKQv8Rx3QMmPB+0n/TDPaJtB0Lr
 b93fMyxmicqeDCHTTIkJoFXEBEL+wrz6HA+lJ39w==
X-Google-Smtp-Source: AGHT+IEnRb7c1roUlDRyF+f17QD0fG9J5BjOWX4PSelCmqG85q5wJF9H7/Cz+lwm5Z9iy+IdI3/3wA==
X-Received: by 2002:a17:902:d4cb:b0:1f8:44f8:a364 with SMTP id
 d9443c01a7336-1fc4e6886e0mr13809345ad.48.1721223594102; 
 Wed, 17 Jul 2024 06:39:54 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc5aa6esm74903495ad.299.2024.07.17.06.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 06:39:53 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v5 3/5] target/riscv: rvv: Provide a fast path using
 direct access to host ram for unit-stride whole register load/store
Date: Wed, 17 Jul 2024 21:39:34 +0800
Message-Id: <20240717133936.713642-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717133936.713642-1-max.chou@sifive.com>
References: <20240717133936.713642-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x630.google.com
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

The vector unit-stride whole register load/store instructions are
similar to unmasked unit-stride load/store instructions that is suitable
to be optimized by using a direct access to host ram fast path.

Because the vector whole register load/store instructions do not need to
handle the tail agnostic, so remove the vstart early exit checking.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 123 +++++++++++++++++------------------
 1 file changed, 61 insertions(+), 62 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 23396a1b750..5343a08e6ad 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -653,81 +653,80 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb)
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
+    target_ulong page_split, elems, addr;
     uint32_t nf = vext_nf(desc);
     uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
     uint32_t max_elems = vlenb >> log2_esz;
+    uint32_t evl = nf * max_elems;
+    uint32_t esz = 1 << log2_esz;
 
-    if (env->vstart >= ((vlenb * nf) >> log2_esz)) {
-        env->vstart = 0;
-        return;
-    }
-
-    k = env->vstart / max_elems;
-    off = env->vstart % max_elems;
-
-    if (off) {
-        /* load/store rest of elements of current segment pointed by vstart */
-        for (pos = off; pos < max_elems; pos++, env->vstart++) {
-            target_ulong addr = base + ((pos + k * max_elems) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr),
-                      (pos + k * max_elems) << log2_esz, vd, ra);
+    while (env->vstart < evl) {
+        /* Calculate page range */
+        addr = base + (env->vstart << log2_esz);
+        page_split = -(addr | TARGET_PAGE_MASK);
+        /* Get number of elements */
+        elems = page_split / esz;
+        if (unlikely(env->vstart + elems >= evl)) {
+            elems = evl - env->vstart;
         }
-        k++;
-    }
 
-    /* load/store elements for rest of segments */
-    for (; k < nf; k++) {
-        for (i = 0; i < max_elems; i++, env->vstart++) {
-            target_ulong addr = base + ((i + k * max_elems) << log2_esz);
-            ldst_elem(env, adjust_addr(env, addr),
-                      (i + k * max_elems) << log2_esz, vd, ra);
+        /* Load/store elements in page */
+        vext_page_ldst_us(env, vd, addr, elems, 1, max_elems, log2_esz,
+                          is_load, ldst_tlb, ldst_host, ra);
+
+        /* Cross page element */
+        if (unlikely((page_split % esz) != 0 && (env->vstart + 1) < evl)) {
+            addr = base + (env->vstart << log2_esz);
+            ldst_tlb(env, adjust_addr(env, addr), (env->vstart << log2_esz),
+                     vd, ra);
+            env->vstart++;
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


