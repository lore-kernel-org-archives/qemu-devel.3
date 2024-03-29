Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3053CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 12:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqAyL-0005GM-7I; Fri, 29 Mar 2024 08:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rqAyI-0005Fl-Sz
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:04:34 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rqAyG-00017W-Jt
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:04:34 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-515d30db54bso234427e87.3
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1711713871; x=1712318671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gLXdedQiSpcjHV3+nBK5vnPRBrkLCL5A4dg1stDDZ/0=;
 b=RQP9Smsq+oWXB+cy5tC2WJ/xb54GdIv4ulqtGge3UHZH9WWjWnS9KLfZqhCufwjeLL
 ipcOjkM74GgNcIktNJSr2aZw20SZ+skiC+9p8S+li1IkI38554RsBdAbrj1z6D9qORyG
 5ow5kIRi28IEIiHbhFZoPLwZinMy/Ei0G0IHHQ5pa6qc3MoyIQfviIEvXKqykvXJLCQP
 MOEy6a1/hUS0CRBUv60gQxjqvlUenthILkWTorrmmcpxRlAgnC/tE22RzHZSI4+yJtSO
 W/IKC0pTkJwUZtdGe1hvzAcTOwJID0Azyoz9impiRlfDClX6elMt9PXj0c1d3D6t7kej
 IRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711713871; x=1712318671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gLXdedQiSpcjHV3+nBK5vnPRBrkLCL5A4dg1stDDZ/0=;
 b=XuBERAWmP/MyfIh1G9V4Arf4avITYOIUweMOdPGi6X6gyPnALr3hm5MhTXsgjsxYdY
 sVJy6aLGkF67ZablJrV3jitbaBeuU0YdpDKmzAeHiluf53PIu4WqYpa1+/n1DcY9wL6a
 uTbe/+/oseBfEOJcH/B/SvLDW+HN/O8qOWk/ihrKhuLcjssWKoy5IgbfrCY54ScumrCS
 hyyUbBIawL/VESKfEGr062tAfHy4mcf0OYSZGqxpB3VRlB9nLAID2ib+2M3soD19lf8m
 2l7QMdoMThsAkDNwG9hEkOJ5aGuX7NzPfQDYx6P3qPq7AvLZdD8JZ4RUBh0LN3s1zK2X
 lj7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7Mq1anqP6qAw0fyKI7+f4P2esQuvUOHAMIjORP5Ro02w8x8lHbn9rBKUtk8pOT5uWV+y+EYCo86C3KM7ZShMCaLnhxpM=
X-Gm-Message-State: AOJu0Yzl1PpFFzvjL/EaJQVOdmZKaANzq8tW63b0csnOCb2RD9w7je4N
 rhhn6RQqt4AEk+hjPJmS9ajIaA9rdBYfTDDXmoBogy22XfRwF2ZnZa5wpY6KRms=
X-Google-Smtp-Source: AGHT+IHaBXu/DmwdMbwLOwpqt/MVeDWcGDps3bNd5LALyYf1g8VQ8C0I9BAGOkmVvg+KCrvrEd/NPw==
X-Received: by 2002:ac2:54ae:0:b0:513:cb74:9ffe with SMTP id
 w14-20020ac254ae000000b00513cb749ffemr1405456lfk.50.1711713870549; 
 Fri, 29 Mar 2024 05:04:30 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 rv4-20020a17090710c400b00a46cffe6d06sm1860870ejb.42.2024.03.29.05.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 05:04:29 -0700 (PDT)
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
 Weiwei Li <liwei1518@gmail.com>
Subject: [PATCH v2] riscv: thead: Add th.sxstatus CSR emulation
Date: Fri, 29 Mar 2024 13:04:27 +0100
Message-ID: <20240329120427.684677-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-lf1-x135.google.com
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
  https://github.com/T-head-Semi/thead-extension-spec/pull/46

An important property of this patch is, that the th.sxstatus MAEE field
is not set (indicating that XTheadMaee is not available).
XTheadMaee is a memory attribute extension (similar to Svpbmt) which is
implemented in many T-Head CPUs (C906, C910, etc.) and utilizes bits
in PTEs that are marked as reserved. QEMU maintainers prefer to not
implement XTheadMaee, so we need give kernels a mechanism to identify
if XTheadMaee is available in a system or not. And this patch introduces
this mechanism in QEMU in a way that's compatible with real HW
(i.e., probing the th.sxstatus.MAEE bit).

Further context can be found on the list:
https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00775.html

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 target/riscv/cpu.c       |  1 +
 target/riscv/cpu.h       |  3 ++
 target/riscv/meson.build |  1 +
 target/riscv/th_csr.c    | 78 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)
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
index 3b1a02b944..c9f8f06751 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -824,4 +824,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
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
index 0000000000..66d260cabd
--- /dev/null
+++ b/target/riscv/th_csr.c
@@ -0,0 +1,78 @@
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
+static RISCVException s_mode_csr(CPURISCVState *env, int csrno)
+{
+    if (env->debugger)
+        return RISCV_EXCP_NONE;
+
+    if (env->priv >= PRV_S)
+        return RISCV_EXCP_NONE;
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}
+
+static int test_thead_mvendorid(RISCVCPU *cpu)
+{
+    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID)
+        return -1;
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
+        .csr_ops = { "th.sxstatus", s_mode_csr, read_th_sxstatus }
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


