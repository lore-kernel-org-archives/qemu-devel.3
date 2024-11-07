Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EA1D5AE5F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 04:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8trG-0006GJ-4n; Wed, 06 Nov 2024 23:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8trE-0006G3-OO
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:56 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8trD-00050Y-0G
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:56 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20c8b557f91so5579045ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 20:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730952653; x=1731557453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1miqYX0xQo/7o/8q+JA+EDvRgf2MXw9rICv8IrHiWDQ=;
 b=LIfoQQ45FZNaVboiNp5B0zXM5oci0TZbrRAQo/nZ1nOlEXIvpGKX3y6usXW+OqjQsz
 eU+emWG2CQGaY7dvN/DNBLMry/tlaib5ziHjG08UN7CRKJ4AzgZP1HlLHyuvzZY4pzGO
 gv9SrPWfSjVlHqgXOHqq2iLvKruEmmym//t9/LggZNtwQ2Yb3beKYV9LHiqykOcHR0qc
 0MbjBl0x0Bk0vmJ1VV6rf+8KQ0nMMoBoWJO2fYqBJAcAUqtwwbskSDDlQ7HFZ/YaFQm/
 nq9RlqMVopJcZv2QyueH+AbJIO+l3h0KiYYwNz7lQ2h5Grh/zH2rcedno2Pipbvoboeo
 ZprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730952653; x=1731557453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1miqYX0xQo/7o/8q+JA+EDvRgf2MXw9rICv8IrHiWDQ=;
 b=fcHglFf/94s1fkMBkr1RtY1jAmWydPDnMDbaQW5L7/xevlUlF+XyCyRVmjpCrAcyMB
 53/1VncIgKz94n33Ot+EK7FZ5HPb9gHj6lkJMH3hriZXZDaVOIuwXJW269JjrzMS+5ZP
 twMw2pWkMqXH6qSV4Mu8CPGYn79pj2ynHt1wgfkdGmqnw8/EZksf4O2SP2NEGKlS86jv
 3r24KeVMM6hvH7v6FYqdfzKLQG5Bo8Z0fXKnCDksPwS3k9lJQkMj0MH4wO4nYUbw2ZHc
 Trf1cbV4NAjwqM1Wua5U+zXUZCGIdEClakKtPSx9dJ+V/8y5dUyI2fGsqw/VTPcoLtUO
 HVng==
X-Gm-Message-State: AOJu0Yxp/arhy8wuyG0HlhxmFynULDtCi1oAQoWCpl+/8eB0JREFQdeP
 v6ks9cxXBGzoe5PMWW4UuwLT8pMC1veoz6WY0M1xPiluR2txNYy+a+C+Rw==
X-Google-Smtp-Source: AGHT+IHDMsDC5fhe/N7zHMbAe760SlKOpfirGBaN0Lq6v4MCBEBC2h33cV9Mo7Sv8Q8k1SY71gq96g==
X-Received: by 2002:a17:902:db01:b0:20c:9983:27ae with SMTP id
 d9443c01a7336-210c6c88004mr551524995ad.48.1730952653422; 
 Wed, 06 Nov 2024 20:10:53 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc3f12sm2789105ad.9.2024.11.06.20.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 20:10:52 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/12] target/riscv: rvv: Provide group continuous ld/st flow
 for unit-stride ld/st instructions
Date: Thu,  7 Nov 2024 14:10:13 +1000
Message-ID: <20241107041016.40800-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107041016.40800-1-alistair.francis@wdc.com>
References: <20241107041016.40800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

The vector unmasked unit-stride and whole register load/store
instructions will load/store continuous memory. If the endian of both
the host and guest architecture are the same, then we can group the
element load/store to load/store more data at a time.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240918171412.150107-7-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 77 +++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 14 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index d8d476c3ea..3d10ff94cd 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -190,6 +190,45 @@ GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
 GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
 GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
 
+static inline QEMU_ALWAYS_INLINE void
+vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
+                       void *vd, uint32_t evl, target_ulong addr,
+                       uint32_t reg_start, uintptr_t ra, uint32_t esz,
+                       bool is_load)
+{
+    uint32_t i;
+    for (i = env->vstart; i < evl; env->vstart = ++i, addr += esz) {
+        ldst_tlb(env, adjust_addr(env, addr), i, vd, ra);
+    }
+}
+
+static inline QEMU_ALWAYS_INLINE void
+vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
+                        void *vd, uint32_t evl, uint32_t reg_start, void *host,
+                        uint32_t esz, bool is_load)
+{
+#if HOST_BIG_ENDIAN
+    for (; reg_start < evl; reg_start++, host += esz) {
+        ldst_host(vd, reg_start, host);
+    }
+#else
+    if (esz == 1) {
+        uint32_t byte_offset = reg_start * esz;
+        uint32_t size = (evl - reg_start) * esz;
+
+        if (is_load) {
+            memcpy(vd + byte_offset, host, size);
+        } else {
+            memcpy(host, vd + byte_offset, size);
+        }
+    } else {
+        for (; reg_start < evl; reg_start++, host += esz) {
+            ldst_host(vd, reg_start, host);
+        }
+    }
+#endif
+}
+
 static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
                                    uint32_t desc, uint32_t nf,
                                    uint32_t esz, uint32_t max_elems)
@@ -298,24 +337,34 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
                                mmu_index, true, &host, ra);
 
     if (flags == 0) {
-        for (i = env->vstart; i < evl; ++i) {
-            k = 0;
-            while (k < nf) {
-                ldst_host(vd, i + k * max_elems, host);
-                host += esz;
-                k++;
+        if (nf == 1) {
+            vext_continus_ldst_host(env, ldst_host, vd, evl, env->vstart, host,
+                                    esz, is_load);
+        } else {
+            for (i = env->vstart; i < evl; ++i) {
+                k = 0;
+                while (k < nf) {
+                    ldst_host(vd, i + k * max_elems, host);
+                    host += esz;
+                    k++;
+                }
             }
         }
         env->vstart += elems;
     } else {
-        /* load bytes from guest memory */
-        for (i = env->vstart; i < evl; env->vstart = ++i) {
-            k = 0;
-            while (k < nf) {
-                ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems, vd,
-                         ra);
-                addr += esz;
-                k++;
+        if (nf == 1) {
+            vext_continus_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
+                                   ra, esz, is_load);
+        } else {
+            /* load bytes from guest memory */
+            for (i = env->vstart; i < evl; env->vstart = ++i) {
+                k = 0;
+                while (k < nf) {
+                    ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems,
+                             vd, ra);
+                    addr += esz;
+                    k++;
+                }
             }
         }
     }
-- 
2.47.0


