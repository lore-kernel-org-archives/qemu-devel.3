Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B616C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 22:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxEAv-0000UY-He; Wed, 17 Apr 2024 18:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rxEAs-0000TP-Lt
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 18:54:42 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rxEAq-0003Rh-HG
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 18:54:42 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e47843cc7so219617a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1713394477; x=1713999277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1yUdyE0KjSO39EtBYmbBE63Xd7+Hv8FijgZbRJ5Jxj0=;
 b=T9vASBdo6SXTvmOawfekZpJZnpsvWUaXxld1MCCdsrnhWkr40stcULav+foZG1ppuf
 jRoAsiErH0rsl+6Z7tti4C2sTj/DqqPlN2t6UzkS2rWzWzWNcZZQ+ku3WLCt0RzEQqci
 +XHv413TWIJbg0miw6uaYVHCtFghk6/9l+JMk+rQVfSMU9ErybVnhV8dTcVz+1hpy1gi
 wmPs5C5ATNjuTojdKUM193Q8NNI9jVnahly9t5L1oZ/fNi7pSrN/sVHSCRKOTv93NUyq
 Wlqi+RTS93z+jOjogB3VjBF4txI3sS7lsYRHCSv5fjO9o5jx73xIKysdgwZSLB8j1DKY
 sUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713394477; x=1713999277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1yUdyE0KjSO39EtBYmbBE63Xd7+Hv8FijgZbRJ5Jxj0=;
 b=r9TvTCJCMnGMbKl07JHBSAN+/cslKNClWPLm6MXF2r64Ynexg3CT/WDZYV3jZyIAsN
 SdEaHw/tuGTXHvB6o7FOhTaJZ4TuwioisaEv54QhKovjYFEp8EGNZKz3FHsRY328TRX0
 pTetgG/k2P9CkSWbNb5Pby1WpoP3vc4jYhZpLyyDINK+o+kMaomN3nHz6NhV7cKabKX5
 rUmJzlCkF6CIsc4cEp+k8Swxs6jXLi0aId7okQVc2sdsKw8ylBCV6kwG6BlUc4Dd9r/t
 XcF1FCL+pDS/BEsAa2TIuXIp04Kwya8VC1ast6A9WOO+CnQP5i8r/R1wzYA0VkXF/vSm
 3qwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb0M5JsD/FaJ7hvqlmlDrOr9de6OJEg8WgwL4FmdY7nPewtUHMHxfTNXWdXQpPKTkau0plxOhuqSWyZNX31jObLi0thWU=
X-Gm-Message-State: AOJu0YzvWy5e9Nw3c+YsatqYd04rAySbV8dHteVOXEl0BedwQJfnnEo4
 vvJmegO29T0NXGMPQs5yEk5P65P3vGLc610EqQNq/Leke5WznUhLaN+WeQRqTxE=
X-Google-Smtp-Source: AGHT+IFqwK4X9y7eX/jnGB+2DiFbzXrNZRHTCu7FvCl3py/lwy5kzmA/LY/YnhbKs0xcpN/PwJYWJg==
X-Received: by 2002:a50:8d11:0:b0:570:5b98:dfda with SMTP id
 s17-20020a508d11000000b005705b98dfdamr587362eds.23.1713394476613; 
 Wed, 17 Apr 2024 15:54:36 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 b15-20020a0564021f0f00b0056febfc5395sm117009edb.58.2024.04.17.15.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 15:54:35 -0700 (PDT)
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
Subject: [PATCH v3] riscv: thead: Add th.sxstatus CSR emulation
Date: Thu, 18 Apr 2024 00:54:32 +0200
Message-ID: <20240417225432.476505-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ed1-x52e.google.com
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
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 target/riscv/cpu.c       |  1 +
 target/riscv/cpu.h       |  4 +++
 target/riscv/csr.c       |  2 +-
 target/riscv/meson.build |  1 +
 target/riscv/th_csr.c    | 68 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 target/riscv/th_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 36e3e5fdaf..b82ba95ae6 100644
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
index 3b1a02b944..fd9424c8e9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -818,10 +818,14 @@ extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
 void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
+RISCVException smode(CPURISCVState *env, int csrno);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
 uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
+/* Implemented in th_csr.c */
+void th_register_custom_csrs(RISCVCPU *cpu);
+
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 726096444f..503eeb5f24 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -260,7 +260,7 @@ static RISCVException aia_any32(CPURISCVState *env, int csrno)
     return any32(env, csrno);
 }
 
-static RISCVException smode(CPURISCVState *env, int csrno)
+RISCVException smode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVS)) {
         return RISCV_EXCP_NONE;
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
index 0000000000..44e28a9298
--- /dev/null
+++ b/target/riscv/th_csr.c
@@ -0,0 +1,68 @@
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
+static int test_thead_mvendorid(RISCVCPU *cpu)
+{
+    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID)
+        return -1;
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
+        if (!th_csr_list[i].insertion_test(cpu))
+            riscv_set_csr_ops(csrno, csr_ops);
+    }
+}
-- 
2.44.0


