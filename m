Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAA1C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MMn-0008N4-FC; Fri, 04 Sep 2026 01:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMl-0008Dz-Vm
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:32 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMj-0001Sa-VV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:31 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so742396a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499288; x=1789104088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xb7+AEbl+/oGGo3WOco6TNPjryYhUnA4NsnYmi8thy0=;
 b=p1liOXN6WcGNi8Oov3bCYA5k8UWCXS5/vIsMm25agabKXZauCLUQHyh9qxPCo1+Gg5
 BsuE7sf7vAaMfZEPduBFIeb6c3EaycJkcZQEBf426lrk/7jNkyG14UtorZ0OIdKosWpX
 +dT+qjYeW/Mx78n12hxdJGorGjsyEuKzW4WRkDCL69LFOzP3/+mnUmp8FV1xdGpzQp4Z
 yMQTkZNW2/b4fCjejbDUh6/FSrXDDRc9NePkkI4Ufal0AC45krTRI60xzKRFt4+68lcx
 CU1vaJTj2xsvBCAuLm/umdCeEfY/eY6zNsRWi9fahnLePViv5Lkimfy4KIQDXZZfP6AM
 LCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499288; x=1789104088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xb7+AEbl+/oGGo3WOco6TNPjryYhUnA4NsnYmi8thy0=;
 b=EPRpeTqkCxn+suL5Vyfq8eW/C60Wk9+ew5rbbKwK8pW5jdjEkTsMhWl1UMgZpcadgo
 Nq5qXXgDjiHwl7kdgZ20mU6MXmhmY0K0Ejgu+cAvH688u3HHp7WUPhr1+hW3HE/YXhc6
 dIZqrWZ2vszn1/E7MChTveMN2o5bL6enna57VGma+7bdXDoLHi/wGGELsLpDnB04etXU
 prNOI3UxDz+azuDEmR5LGpMsW1ndfJrkhmcxKxxg2o3TJaQRxwc4FDOHEtK5WXZiNVRI
 R/gyX8nM8UsNocKWnGKel9hpjmBnN1i7Uq51fbyWAiGa/tXvK4Zl9Fcpj/UP2697r1hR
 tHHw==
X-Gm-Message-State: AFuF++l4HOH6vbTaxjzLqxIVSfQcB/JLC+FJp2QrATlGQmKNhWoBPnNP
 vXLfVkcVZ/jEgtNtBISHJAElsTol88yJF/4GUc2eZ2jJalOmkQsiVh6PqIqaXQ==
X-Gm-Gg: AYBFou3MQXpnGHmchk/qTyatmZ+QVaWAMgyRDW4QtyFAQOgFkpmMOui650C1V+boGGL
 isCfPtaFjUyXWfVs+8QzbzSkWR5/6aCd2mZ+K3U3tfnVthcEEtl09EvQKDMy9E+GH+11C38Zw5S
 NF6pOT3QX1c2bvpwRKeHDhdKgNB8fjI+Fd5plZH1V1tTsNO4+6izFaock+va3CzMbKVOiTAw+hv
 pTsMLrcDnq0bFIUsRGYoQULAA35K+2scDyCMkaBC0JKPz9oay8ZCpq7ceqh3xc+HaQLBrKkSIOi
 IwpBS5iDj6UMrb62RpgchMEab+Okyx8ils3Gm3FezqUy142xYiTCoCb6yYetPqlvxW+l8Dl78lH
 qnf1kNobgnVF2v1WfUb10MHRKPo/CAfijzjD+BKRTdw8j87QC7UueYf4v9xaUghtKRE+DwK1C6r
 O74zo9Dg5CtZGRZD5Jz7rbIBCKMetxE0wWzGJD0jOCnpqqfDYH97n6YhtB9Lu3tBXs9zw6K4h6E
 TFoDg==
X-Received: by 2002:a05:6a20:db8e:b0:3d3:aec2:4dc9 with SMTP id
 adf61e73a8af0-3da3a0f6709mr5468324637.21.1788499288488; 
 Thu, 03 Sep 2026 22:21:28 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:28 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/47] target/riscv: preserve vl on element-zero fault
Date: Fri,  4 Sep 2026 15:19:26 +1000
Message-ID: <20260904051943.799041-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
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

From: Zephyr Li <fritchleybohrer@gmail.com>

A unit-stride fault-only-first load must leave vl unchanged when element
zero raises a synchronous exception.

The current implementation updates vl after probing the accesses but
before performing the actual loads. For unassigned MMIO, the probe can
succeed even though the subsequent device transaction raises an
exception. If this happens for element zero, the trap handler observes
a prematurely shortened vl.

Keep the shortened value in a local bound until all loads complete, and
only then update the architectural vl.

Add a bare-metal RVV regression test using an unassigned MMIO address
and check that vl remains unchanged in the trap handler.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3544
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260813025959.583-1-fritchleybohrer@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/vector_helper.c          | 23 +++++----
 tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
 tests/tcg/riscv64/test-vle32ff.S          | 58 +++++++++++++++++++++++
 3 files changed, 77 insertions(+), 9 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-vle32ff.S

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index e28d8a3d9f..0d1e4e0964 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -721,7 +721,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
           uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
           vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz, uintptr_t ra)
 {
-    uint32_t i, k, vl = 0;
+    uint32_t i, k, vl = 0, load_vl;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
@@ -787,22 +787,24 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
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
@@ -815,7 +817,7 @@ ProbeSuccess:
 
                 addr = base + ((env->vstart * nf) << log2_esz);
                 /* Get number of elements of second page */
-                elems = env->vl - env->vstart;
+                elems = load_vl - env->vstart;
 
                 /* Load/store elements in the second page */
                 vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
@@ -823,7 +825,7 @@ ProbeSuccess:
                                   ldst_host, ra);
             }
         } else {
-            for (i = env->vstart; i < env->vl; i++) {
+            for (i = env->vstart; i < load_vl; i++) {
                 k = 0;
                 while (k < nf) {
                     if (!vext_elem_mask(v0, i)) {
@@ -841,6 +843,9 @@ ProbeSuccess:
             }
         }
     }
+    if (vl != 0) {
+        env->vl = vl;
+    }
     env->vstart = 0;
 
     vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 575571de90..f2c75abd57 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -80,5 +80,10 @@ EXTRA_RUNS += run-test-rv128-sstatus
 run-test-rv128-sstatus: test-rv128-sstatus
 	$(call run-test, $<, $(QEMU) -cpu x-rv128 $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-vle32ff
+run-test-vle32ff: test-vle32ff
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true $(QEMU_OPTS)$<)
+test-vle32ff: CFLAGS += -march=rv64gcv
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-vle32ff.S b/tests/tcg/riscv64/test-vle32ff.S
new file mode 100644
index 0000000000..2cffe8659c
--- /dev/null
+++ b/tests/tcg/riscv64/test-vle32ff.S
@@ -0,0 +1,58 @@
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
+	li	t0, (1 << 9)	/* Set mstatus.VS to Initial. */
+	csrs	mstatus, t0
+	li	t1, 4
+	vsetvli	t2, t1, e32, m1, ta, ma
+	/* Unassigned MMIO: probe succeeds, load faults. */
+	li	t0, 0x18000000
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
+	bne	t0, t2, trap_fail
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
-- 
2.55.0


