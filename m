Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEB5CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQht-0001zo-D0; Tue, 16 Jun 2026 06:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhl-0001ns-9w
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:38 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhj-0003Te-1b
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:37 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c85893bce34so1812911a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604454; x=1782209254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWVbz+LoV9WM9mA2yBpJy2LIqx8pnUBQTK1oHveufzQ=;
 b=MVUQ0v55yUUrfXhvdQmipoGB9i4UVU0VbAN9ZPSiGtp7IFex5ralNiEpAjZtj3MqBF
 flyXfStbzklWbmama4VcSmoeQJ6Cegxaw6D3ln3sxAzJy4HevGQq/wgIPIuVI3Potica
 A4mzeEHUvw3pJGjg3sjxXt/iZPVivxnI8ITnSRJp6a0gWhgaps3Yh1q3Utu8F41vSuM8
 K+WRvH6B3DYVyNFgRMIjK6JQYirTCh0Zi+aj0wwewj20fFPRFqERTrV93Wtawfum8eN+
 DL7tWslFpzQlK9EhL123a0zHDFwMbQmbs+c8t+COaagOYZ+DUqr8I4s3gJwF9hdrhdcs
 MsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604454; x=1782209254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CWVbz+LoV9WM9mA2yBpJy2LIqx8pnUBQTK1oHveufzQ=;
 b=cVBMrZyUN3Jt2zBlHEMapRDjXgNnAph2yj04nXlN3rTMVmBSIHq/HAtIr/50TrNiXx
 sXYBR230eHsnjrViclQmAn7aTQt82zv6pGFngvdpHJkWajrcxKEfmHMOxIS6u1gkcmCi
 q7TT4CgCNfbl4tpy4E2AS2B+7h4sFNaiHM/OLn1AaCszr6yRFpaEom9NCl6+2H0apw19
 pkfM5U7DcsqlvlEVHoI0Uskp8rS6e3HUgNUEfHIztAsHUMCR32C7oTOvniHj7F6uWO+y
 ZcAEHCP6f38m3UFRKE4FuWkDdrr6zR/XOP0WgZV6rMathe2pDitOPsBp+xjFqjUuEmq2
 8bug==
X-Gm-Message-State: AOJu0Yyg7X2LtlORGbBzWdv1GyS+DlAJvM6gdWnCOi7jSyywbkhUX1U7
 VoaUdTIXfmtGX7oS5o27h/KyuwdHeMkjRyOTV7INQYSxjnexG2IqNcEgOA2Wcq9I
X-Gm-Gg: Acq92OGixcOf5zSaLp/nVuUvYQwZIQ9yIwfRzMRf9GKOaB+NJlU4o/fKd7S6mQDi6Vh
 xEpLBCATPFNLO0f4YpgrJIsBqAtNl/hfwNy8+lvAml8IkX/K9VK/UeTKOlLF2n/0mvwOzAe91+1
 Q1A+BQimsKCV89c1/NfqSzZT5YGTxt105XRIGgtpi4+j27eoPTFRWSIPgrHRnPVSZrX4NWFo0jm
 selrSRz9ISnnosXPuvpI9zc1tEkmvt2SFhwXp2odHxOGwtAnav+uwgV7zlkYUU4qaVmZFzUrEmG
 pj9n4rBGOFt17nlat9ACTUKiQhjngRBR6+h9mOZq1ZWyqH0xNufIgHeP674ETfEd2UwAdcvO9vr
 bGNCRJt0mNud+GjARB56nmhdwLxliCXdIe+o8PVbRp0YfpkiWWZwW96WqsVudzJh99h0IKEm80E
 XJ66Y/0j9bi0IG6SmmMSNq0TyGR7VHEkheMLIYQUBG
X-Received: by 2002:a05:6a20:7287:b0:3b4:871a:5aaa with SMTP id
 adf61e73a8af0-3b7963c95famr15505929637.26.1781604453629; 
 Tue, 16 Jun 2026 03:07:33 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/83] target/riscv: Move CSR declarations to separate csr.h
 header
Date: Tue, 16 Jun 2026 20:04:37 +1000
Message-ID: <20260616100527.1939565-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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

From: Anton Johansson <anjo@rev.ng>

Most of these definitions save riscv_csrr, riscv_csrrw, riscv_csr_read,
riscv_csr_write are only used in target/.  Move declarations to a
separate headers which will soon be made internal to target/.

csr.h is temporarily included from cpu.h to not break includes from
outside target/, this include will be removed in the following commit.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-24-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            |  87 +---------------------------
 target/riscv/csr.h            | 103 ++++++++++++++++++++++++++++++++++
 target/riscv/cpu.c            |   1 +
 target/riscv/csr.c            |   1 +
 target/riscv/gdbstub.c        |   1 +
 target/riscv/kvm/kvm-cpu.c    |   1 +
 target/riscv/mips_csr.c       |   1 +
 target/riscv/monitor.c        |   1 +
 target/riscv/op_helper.c      |   1 +
 target/riscv/riscv-qmp-cmds.c |   1 +
 target/riscv/th_csr.c         |   1 +
 11 files changed, 113 insertions(+), 86 deletions(-)
 create mode 100644 target/riscv/csr.h

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 644a08ea5a..b751c9d348 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -905,75 +905,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
-RISCVException riscv_csrr(CPURISCVState *env, int csrno,
-                          target_ulong *ret_value);
-
-RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
-                           target_ulong *ret_value, target_ulong new_value,
-                           target_ulong write_mask, uintptr_t ra);
-RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
-                                 target_ulong *ret_value,
-                                 target_ulong new_value,
-                                 target_ulong write_mask);
-
-static inline void riscv_csr_write(CPURISCVState *env, int csrno,
-                                   target_ulong val)
-{
-    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
-}
-
-static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
-{
-    target_ulong val = 0;
-    riscv_csrr(env, csrno, &val);
-    return val;
-}
-
-typedef RISCVException (*riscv_csr_predicate_fn)(CPURISCVState *env,
-                                                 int csrno);
-typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
-                                            target_ulong *ret_value);
-typedef RISCVException (*riscv_csr_write_fn)(CPURISCVState *env, int csrno,
-                                             target_ulong new_value,
-                                             uintptr_t ra);
-typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
-                                          target_ulong *ret_value,
-                                          target_ulong new_value,
-                                          target_ulong write_mask);
-
-RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
-                               Int128 *ret_value);
-RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
-                                Int128 *ret_value, Int128 new_value,
-                                Int128 write_mask, uintptr_t ra);
-
-typedef RISCVException (*riscv_csr_read128_fn)(CPURISCVState *env, int csrno,
-                                               Int128 *ret_value);
-typedef RISCVException (*riscv_csr_write128_fn)(CPURISCVState *env, int csrno,
-                                             Int128 new_value);
-
-typedef struct {
-    const char *name;
-    riscv_csr_predicate_fn predicate;
-    riscv_csr_read_fn read;
-    riscv_csr_write_fn write;
-    riscv_csr_op_fn op;
-    riscv_csr_read128_fn read128;
-    riscv_csr_write128_fn write128;
-    /* The default priv spec version should be PRIV_VERSION_1_10_0 (i.e 0) */
-    uint32_t min_priv_ver;
-} riscv_csr_operations;
-
-struct RISCVCSR {
-    int csrno;
-    bool (*insertion_test)(RISCVCPU *cpu);
-    riscv_csr_operations csr_ops;
-};
-
-/* CSR function table constants */
-enum {
-    CSR_TABLE_SIZE = 0x1000
-};
+#include "target/riscv/csr.h"
 
 /*
  * The event id are encoded based on the encoding specified in the
@@ -1007,28 +939,11 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 void riscv_add_satp_mode_properties(Object *obj);
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
-/* CSR function table */
-extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
-bool riscv_csr_is_fpu(int csrno);
-bool riscv_csr_is_vpu(int csrno);
-
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
-void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
-void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
-
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
-target_ulong riscv_new_csr_seed(target_ulong new_value,
-                                target_ulong write_mask);
-
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
-/* In th_csr.c */
-extern const RISCVCSR th_csr_list[];
-
-/* Implemented in mips_csr.c */
-extern const RISCVCSR mips_csr_list[];
-
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/csr.h b/target/riscv/csr.h
new file mode 100644
index 0000000000..f45f9912c5
--- /dev/null
+++ b/target/riscv/csr.h
@@ -0,0 +1,103 @@
+/*
+ * QEMU RISC-V CSRs
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2017-2018 SiFive, Inc.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_CSR_H
+#define RISCV_CSR_H
+
+#include "exec/target_long.h"
+#include "cpu_bits.h"
+
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask);
+
+RISCVException riscv_csrr(CPURISCVState *env, int csrno,
+                          target_ulong *ret_value);
+
+RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
+                           target_ulong *ret_value, target_ulong new_value,
+                           target_ulong write_mask, uintptr_t ra);
+RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
+                                 target_ulong *ret_value,
+                                 target_ulong new_value,
+                                 target_ulong write_mask);
+
+static inline void riscv_csr_write(CPURISCVState *env, int csrno,
+                                   target_ulong val)
+{
+    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
+}
+
+static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
+{
+    target_ulong val = 0;
+    riscv_csrr(env, csrno, &val);
+    return val;
+}
+
+typedef RISCVException (*riscv_csr_predicate_fn)(CPURISCVState *env,
+                                                 int csrno);
+typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
+                                            target_ulong *ret_value);
+typedef RISCVException (*riscv_csr_write_fn)(CPURISCVState *env, int csrno,
+                                             target_ulong new_value,
+                                             uintptr_t ra);
+typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
+                                          target_ulong *ret_value,
+                                          target_ulong new_value,
+                                          target_ulong write_mask);
+
+RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
+                               Int128 *ret_value);
+RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
+                                Int128 *ret_value, Int128 new_value,
+                                Int128 write_mask, uintptr_t ra);
+
+typedef RISCVException (*riscv_csr_read128_fn)(CPURISCVState *env, int csrno,
+                                               Int128 *ret_value);
+typedef RISCVException (*riscv_csr_write128_fn)(CPURISCVState *env, int csrno,
+                                             Int128 new_value);
+
+typedef struct {
+    const char *name;
+    riscv_csr_predicate_fn predicate;
+    riscv_csr_read_fn read;
+    riscv_csr_write_fn write;
+    riscv_csr_op_fn op;
+    riscv_csr_read128_fn read128;
+    riscv_csr_write128_fn write128;
+    /* The default priv spec version should be PRIV_VERSION_1_10_0 (i.e 0) */
+    uint32_t min_priv_ver;
+} riscv_csr_operations;
+
+struct RISCVCSR {
+    int csrno;
+    bool (*insertion_test)(RISCVCPU *cpu);
+    riscv_csr_operations csr_ops;
+};
+
+/* CSR function table constants */
+enum {
+    CSR_TABLE_SIZE = 0x1000
+};
+
+/* CSR function table */
+extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
+
+bool riscv_csr_is_fpu(int csrno);
+bool riscv_csr_is_vpu(int csrno);
+
+void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
+void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
+
+/* In th_csr.c */
+extern const RISCVCSR th_csr_list[];
+
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
+#endif /* RISCV_CSR_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7fb426b697..bcc8a6bcb1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
+#include "target/riscv/csr.h"
 #include "internals.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8b1de77b7a..e508985311 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "cpu.h"
+#include "target/riscv/csr.h"
 #include "tcg/tcg-cpu.h"
 #include "pmu.h"
 #include "time_helper.h"
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 7abacd0e11..a2bbaf7f07 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -21,6 +21,7 @@
 #include "gdbstub/helpers.h"
 #include "cpu.h"
 #include "internals.h"
+#include "target/riscv/csr.h"
 
 struct TypeSize {
     const char *gdb_type;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 53d88339c1..f0de5c3071 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -31,6 +31,7 @@
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "cpu.h"
+#include "target/riscv/csr.h"
 #include "trace.h"
 #include "accel/accel-cpu-target.h"
 #include "hw/pci/pci.h"
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
index 822e25e346..609718f288 100644
--- a/target/riscv/mips_csr.c
+++ b/target/riscv/mips_csr.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
+#include "target/riscv/csr.h"
 
 /* Static MIPS CSR state storage */
 static struct {
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 9edac0533c..3e89dcaf7c 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -22,6 +22,7 @@
 #include "qemu/ctype.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
+#include "target/riscv/csr.h"
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index c074b24bc9..3dc8c4f6b3 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "target/riscv/csr.h"
 #include "internals.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 93e6b7fa68..b94e8391ed 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -35,6 +35,7 @@
 #include "system/tcg.h"
 #include "cpu-qom.h"
 #include "cpu.h"
+#include "target/riscv/csr.h"
 
 static void riscv_cpu_add_definition(gpointer data, gpointer user_data)
 {
diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 49eb7bbab5..a4ea4ce391 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
+#include "target/riscv/csr.h"
 
 #define CSR_TH_SXSTATUS 0x5c0
 
-- 
2.54.0


