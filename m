Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80751C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6Ax-0002D5-Er; Thu, 23 Jul 2026 23:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wn6Av-0002Ci-Pw
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:02:13 -0400
Received: from mail-pj2-x00.google.com ([2607:f8b0:4864:39::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wn6At-0007Ge-P9
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:02:13 -0400
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc2c6e0688so11210685ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784862130; x=1785466930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HyRRBH7OxghhR6T3TZqAmX/1r1N6QDbkkGmYiJtTmJ4=;
 b=HOQvTj29x1LPQv7wc65DCOWr7cgzutF7MztI/zbXB2zZ9pneFdSAA3e+kYUoyBdbxu
 z4EhPykjAyHutUWQwQpoW0SpDGqOHMBVBXXKvyHfeUuB6qRZjMKXjqQ5Kh21Ym3wXKrs
 dvxDf2foTwgmmLikW+oklkoqMRNjnEHk3gSKzt8J1KPtC5LdyP2wpCfWu/EaAvZ9dxqP
 svsbPMJ1nGq5BJENC2D1OCSjCDYl4ibFG8GqIgr57OaDilPsMcb264gGbYm8xmlNdBYB
 p+Ul/7pvD9Slxw6o7i8CKrh8h0eKabhzG3wcm+opEaSiii+BoifeJzkXzpK8ytVtELvT
 lvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784862130; x=1785466930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HyRRBH7OxghhR6T3TZqAmX/1r1N6QDbkkGmYiJtTmJ4=;
 b=l4zQcfGI08oB8imdBEejajW0ZRBK2xrIAVvE4X2hSRNh4W2iOYC1sxhSMjJJOwXSSI
 ej+KCivGQUZTLhA4cSG8/q4pIBldFAMF9Imdu5oJWUVS9jrlH9RYdpGWCa9iTQCvT0Tx
 ggiFRsdm08vKZphFaL7rIPvdSd7QQv3mQO5RIVFHZRNJdfmBPjV8RNRyVrat2trJ4V/h
 jfIW+81mYbtMjqVEoMThn5itkgBfkNbRcmp0ZLReZDqM8uov9QcK6pZgMz4eYJ1QDpJ9
 qgP43YUpq1Tu27WT1t5T8ET7X4xuCRh389Q+ys4El1gkfintrwObndFCPr91/tX7kibR
 shNA==
X-Gm-Message-State: AOJu0Yyu1Oyz/OT7W4gKqi4JYKsvzxxrZGAf4bh8V3kmeN4Y3ar+XQc3
 8lnM9L9KJW6ZfeCQylkSrjnFmqVvK+Ew3cUFmc0kWWKZwYHtFq7ajigiYAyK0GZR
X-Gm-Gg: AR+sD10Wn1yKR703piXy6Tka/Pz2yi/78DEwRORefPZHKvJ53EPm6rQNC6F8O3O1MkP
 KPEAwqNKQfrvpMNQmQrAFKE/ggxY7ubR4zWB4oSQyxlUaWeUujsJTQr0xvTT3i29KA75T2Kwq+3
 IxPDlnzJty0bDSJavlcjDWRFPUhvzXLpKuAArqltR6ZXO2zcCTjANQUauCNixzKvJiVo3IlOTTq
 Yy/lHjzfJ8UDfyACRTekxaP7SvNo41VewEOhVqAev1cJnnSPriT7F8Vg547HpuyfOZeypTO5SxH
 S1ahT3xCrwv4+6B/HK2rK83k5/QX/1xRG3wem2z3W6YLkPENdsXtvybKVUbTy8c8+qsnPvG8D85
 sMNz5Od/U6IGRPCgonDEU5VB4fzvsotLghfU7dHTr+aZk/58i1H2lXVUIC+vHqKTGUvhUNRcGT7
 VqgNQYcI0E2DW1jk29wAEBJpgBfBVJR5o=
X-Received: by 2002:a05:6300:14c:b0:3bb:106d:77be with SMTP id
 adf61e73a8af0-3c44b18ce73mr6588722637.44.1784862129437; 
 Thu, 23 Jul 2026 20:02:09 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([103.190.179.65])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm34000754c88.2.2026.07.23.20.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 20:02:08 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH] target/riscv: preserve vl on element-zero fault
Date: Fri, 24 Jul 2026 11:01:45 +0800
Message-ID: <20260724030145.14778-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x00.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A unit-stride fault-only-first load must leave vl unchanged when element zero raises a synchronous exception. Keep the shortened value in a local bound until all loads complete, and only then update the architectural vl.

Add a bare-metal RVV regression test which faults vle32ff.v on element zero and checks that vl remains unchanged in the trap handler.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3544
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/tcg/vector_helper.c          | 23 ++++++----
 tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
 tests/tcg/riscv64/test-vle32ff.S          | 56 +++++++++++++++++++++++
 3 files changed, 75 insertions(+), 9 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-vle32ff.S

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index e321ca2616..5a310822b7 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -686,7 +686,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
           uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
           vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz, uintptr_t ra)
 {
-    uint32_t i, k, vl = 0;
+    uint32_t i, k, vl = 0, load_vl;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
@@ -752,22 +752,24 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
         }
     }
 ProbeSuccess:
-    /* load bytes from guest memory */
-    if (vl != 0) {
-        env->vl = vl;
-    }
+    /*
+     * Keep a shortened vl local until all loads complete. In particular,
+     * an exception from element zero must leave the architectural vl alone.
+     */
+    load_vl = vl ? vl : env->vl;
 
-    if (env->vstart < env->vl) {
+    if (env->vstart < load_vl) {
         if (vm) {
             /* Load/store elements in the first page */
             if (likely(elems)) {
+                elems = MIN(elems, load_vl - env->vstart);
                 vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
                                   log2_esz, true, mmu_index, ldst_tlb,
                                   ldst_host, ra);
             }
 
             /* Load/store elements in the second page */
-            if (unlikely(env->vstart < env->vl)) {
+            if (unlikely(env->vstart < load_vl)) {
                 /* Cross page element */
                 if (unlikely(page_split % msize)) {
                     for (k = 0; k < nf; k++) {
@@ -780,7 +782,7 @@ ProbeSuccess:
 
                 addr = base + ((env->vstart * nf) << log2_esz);
                 /* Get number of elements of second page */
-                elems = env->vl - env->vstart;
+                elems = load_vl - env->vstart;
 
                 /* Load/store elements in the second page */
                 vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
@@ -788,7 +790,7 @@ ProbeSuccess:
                                   ldst_host, ra);
             }
         } else {
-            for (i = env->vstart; i < env->vl; i++) {
+            for (i = env->vstart; i < load_vl; i++) {
                 k = 0;
                 while (k < nf) {
                     if (!vext_elem_mask(v0, i)) {
@@ -806,6 +808,9 @@ ProbeSuccess:
             }
         }
     }
+    if (vl != 0) {
+        env->vl = vl;
+    }
     env->vstart = 0;
 
     vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 82be8a2c91..7ae225bd73 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -41,5 +41,10 @@ comma:= ,
 run-test-crc32: test-crc32
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-vle32ff
+run-test-vle32ff: test-vle32ff
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true $(QEMU_OPTS)$<)
+test-vle32ff: CFLAGS += -march=rv64gcv
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-vle32ff.S b/tests/tcg/riscv64/test-vle32ff.S
new file mode 100644
index 0000000000..4c687bf1e4
--- /dev/null
+++ b/tests/tcg/riscv64/test-vle32ff.S
@@ -0,0 +1,56 @@
+/*
+ * Verify that a fault-only-first load keeps vl unchanged when element zero
+ * raises a synchronous exception.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option norvc
+
+	.text
+	.globl _start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	li	t1, 4
+	vsetvli	t2, t1, e32, m1, ta, ma
+	li	t0, 1
+	vle32ff.v	v1, (t0)
+
+	/* Element zero did not trap. */
+	li	a0, 1
+	j	_exit
+
+trap:
+	csrr	t0, mcause
+	li	t1, 5		/* Load access fault. */
+	bne	t0, t1, trap_fail
+
+	csrr	t0, vl
+	li	t1, 4
+	bne	t0, t1, trap_fail
+
+	li	a0, 0
+	j	_exit
+
+trap_fail:
+	li	a0, 1
+
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	8
+semiargs:
+	.space	16

