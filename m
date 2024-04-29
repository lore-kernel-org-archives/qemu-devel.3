Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DBDC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 07:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1LZV-0006nv-4z; Mon, 29 Apr 2024 03:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1s1LZR-0006nH-5Q
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:37:05 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1s1LZN-00086u-VM
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:37:04 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5727c009fe4so1344582a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 00:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1714376219; x=1714981019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+6wIoA8JqTxY9ZzUdgC8RoII+Yghdnj8xKPpWn/+v0E=;
 b=CkXjDs/vA7QpBwBamfGQNLHRXYlQty3fPIUOhmpfKq620l8BRzZtLR1mUxxpU7UjmQ
 Sl4W+8SZY2HH8YZG7lcN+afEMNeFeVANQ6wNfpXQz9hasN4leNcLhWRlUDJCZw6oHZWX
 yt1eI+ABO31K+LmHYq20psDDx/cBGUnRbsd1krnSLsE/LPuEnqTY8a1WFJ44nhmcGX5L
 h+EYpQ5T1he777E0j07mlJNGWKbg0nca9cHSpAm9UIbMHR4wHhR7lSPQq1QWRpPM8Rs1
 SBrb5BHZ0YUjFof4189hvJqCFlxB3sZJ+IXdAlZOvRZDeWAx/aldy9N8JB4rDBXB0rUA
 pIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714376219; x=1714981019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+6wIoA8JqTxY9ZzUdgC8RoII+Yghdnj8xKPpWn/+v0E=;
 b=LqR+Q+iOWfUFVKbgBQFtyb/pXaaMZxnvtfldOJ8I7sm3Mtr6hQq9lcNqRc0gEtChqU
 /kZSlFvREpQ7DJTLF8YJsWMdMqTZlLspgbNFqDeqCUHxcqFJCJ5vAIfEs6pTe/A9/V7M
 I9EHMFiTKFaUXoVPwENRyT6t86URN+Pfm02hubf0bCdoiaNVUSzgzkqCs+P2Sg7YNza8
 nrKVAmg6aHz/XGlq8vpCwprqOgWkIkSg1f0EY7PVAxZzcKbPkS7Kks9NrOtZDrETB5tl
 hMJsgZfeC1WkHsmczUO4R9DJFbjGTk/lTGVIKlS50rm/w7UOctQxmPm1pbxPFYP5/U10
 ImeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHh1pS12maJW6BbIuGGN4Ae1xXPBmNZS6p24qfFQmTojHtDflUa248z1xFBwDpNbdY5zMWhZGpDz9lsA5mX3AF7FFzFtk=
X-Gm-Message-State: AOJu0YxNF0X6BSyDrarvCUAiQtWQOO4RCF2tc2VXDVMK3u6q9g48Fz2b
 N8J2p2YA/OKYFukkrcVEj+zHQxKbfaNdErY7fc8ldrO0ckQP5yyj69nD6AhJiYY=
X-Google-Smtp-Source: AGHT+IHuHB4eSYprjhkwyWIxPDBFjnWCraXLcL4ZR9swxVoVRhjPeLKRNjRc0/PvbI8reyav4ECLVQ==
X-Received: by 2002:a50:8d54:0:b0:572:7d78:741a with SMTP id
 t20-20020a508d54000000b005727d78741amr2072157edt.15.1714376219317; 
 Mon, 29 Apr 2024 00:36:59 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 er25-20020a056402449900b005727eb1ed6asm1049447edb.68.2024.04.29.00.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 00:36:58 -0700 (PDT)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cooper Qu <cooper.qu@linux.alibaba.com>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
 Huang Tao <eric.huang@linux.alibaba.com>, Conor Dooley <conor@kernel.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Vivian Wang <uwu@dram.page>, Qingfang Deng <dqfext@gmail.com>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwe_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>
Subject: [PATCH v5] riscv: thead: Add th.sxstatus CSR emulation
Date: Mon, 29 Apr 2024 09:36:56 +0200
Message-ID: <20240429073656.2486732-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ed1-x52b.google.com
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

The th.sxstatus CSR can be used to identify available custom extension
on T-Head CPUs. The CSR is documented here:
  https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadsxstatus.adoc

An important property of this patch is, that the th.sxstatus MAEE field
is not set (indicating that XTheadMae is not available).
XTheadMae is a memory attribute extension (similar to Svpbmt) which is
implemented in many T-Head CPUs (C906, C910, etc.) and utilizes bits
in PTEs that are marked as reserved. QEMU maintainers prefer to not
implement XTheadMae, so we need give kernels a mechanism to identify
if XTheadMae is available in a system or not. And this patch introduces
this mechanism in QEMU in a way that's compatible with real HW
(i.e., probing the th.sxstatus.MAEE bit).

Further context can be found on the list:
https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00775.html

Reviewed-by: LIU Zhiwei <zhiwe_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 MAINTAINERS              |  1 +
 target/riscv/cpu.c       |  1 +
 target/riscv/cpu.h       |  3 ++
 target/riscv/meson.build |  1 +
 target/riscv/th_csr.c    | 79 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+)
 create mode 100644 target/riscv/th_csr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 302b6fd00c..628e2b3141 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -342,6 +342,7 @@ L: qemu-riscv@nongnu.org
 S: Supported
 F: target/riscv/insn_trans/trans_xthead.c.inc
 F: target/riscv/xthead*.decode
+F: target/riscv/th_*
 F: disas/riscv-xthead*
 
 RISC-V XVentanaCondOps extension
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eb1a2e7d6d..70d30a2c00 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -545,6 +545,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     cpu->cfg.mvendorid = THEAD_VENDOR_ID;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_SV39);
+    th_register_custom_csrs(cpu);
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2d0c02c35b..8dd6175e20 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -822,4 +822,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
+/* Implemented in th_csr.c */
+void th_register_custom_csrs(RISCVCPU *cpu);
+
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index a5e0734e7f..a4bd61e52a 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -33,6 +33,7 @@ riscv_system_ss.add(files(
   'monitor.c',
   'machine.c',
   'pmu.c',
+  'th_csr.c',
   'time_helper.c',
   'riscv-qmp-cmds.c',
 ))
diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
new file mode 100644
index 0000000000..6c970d4e81
--- /dev/null
+++ b/target/riscv/th_csr.c
@@ -0,0 +1,79 @@
+/*
+ * T-Head-specific CSRs.
+ *
+ * Copyright (c) 2024 VRULL GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+#define CSR_TH_SXSTATUS 0x5c0
+
+/* TH_SXSTATUS bits */
+#define TH_SXSTATUS_UCME        BIT(16)
+#define TH_SXSTATUS_MAEE        BIT(21)
+#define TH_SXSTATUS_THEADISAEE  BIT(22)
+
+typedef struct {
+    int csrno;
+    int (*insertion_test)(RISCVCPU *cpu);
+    riscv_csr_operations csr_ops;
+} riscv_csr;
+
+static RISCVException smode(CPURISCVState *env, int csrno)
+{
+    if (riscv_has_ext(env, RVS)) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}
+
+static int test_thead_mvendorid(RISCVCPU *cpu)
+{
+    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
+{
+    /* We don't set MAEE here, because QEMU does not implement MAEE. */
+    *val = TH_SXSTATUS_UCME | TH_SXSTATUS_THEADISAEE;
+    return RISCV_EXCP_NONE;
+}
+
+static riscv_csr th_csr_list[] = {
+    {
+        .csrno = CSR_TH_SXSTATUS,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
+    }
+};
+
+void th_register_custom_csrs(RISCVCPU *cpu)
+{
+    for (size_t i = 0; i < ARRAY_SIZE(th_csr_list); i++) {
+        int csrno = th_csr_list[i].csrno;
+        riscv_csr_operations *csr_ops = &th_csr_list[i].csr_ops;
+        if (!th_csr_list[i].insertion_test(cpu)) {
+            riscv_set_csr_ops(csrno, csr_ops);
+        }
+    }
+}
-- 
2.44.0


