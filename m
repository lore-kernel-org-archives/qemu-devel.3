Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD784C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 06:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rynXG-0002rx-Uw; Mon, 22 Apr 2024 02:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rynXF-0002qh-GF
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 02:52:17 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rynXD-0007FM-Fe
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 02:52:17 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a557044f2ddso434552166b.2
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 23:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1713768732; x=1714373532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ax/1ZshuL00ahAPXg4nf6xoxsqH77MMrKGqY9tToeg=;
 b=ZaJ+MmUHI3ZZ5J3tkr69FdSyRULTFSGNsKQNnfufn/OSuyK+eI5HqD2myMWDckI55V
 ESmVWnxTKNIkvrJjElPHkmCIqs5VDu5LE3AciFbQTFQmhc3lP7D5zTx6c9g6logvdJSc
 70LTPVxRm3yORP5GSOu53K1JzT++Es9hFyHyKPo802UjF60ZXQEIaDmuWs4Vf3ZIk2cN
 ospJc0W+G46VYaq+4IBLSqsHPgDBrZBkj0fzq50d+tZq41kfWgz54NBp76L1eMhmp5AL
 ohLG6tGbbOYbUn9C1HmCxRy49r8hQ4SWWvTtxfYgVZ3xBJLJLtJ7a9G4giy1pxIOVNms
 6kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713768732; x=1714373532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ax/1ZshuL00ahAPXg4nf6xoxsqH77MMrKGqY9tToeg=;
 b=AtfxWK4K/TVWiaGWdyyVjtu5Ix4GRj5s6dW0S49KoEO/l8kGCW9i7GYOZuZ+Dv4W6/
 wM2dMxUBHl+VzVfM27fG0qgK9MqpGalw6UlBkmEyghJesLD0ukRLk8+Uxnu5do6GggWq
 iN3KmhFisvmvOrmER0HzcIZLR/FbHeIauIw/7oAGsmJspH6Vcg7toePa9qNKtUvP7opd
 /jTA/dpXjuK9q6s8guKRMZJLPYgMAYJy0cBVGLnj1jSm72dd+5TwrZVu89SOiujtxmyH
 swiO6GjRuRUfS3aF67RFf3e1eAjGJeS5SP4B5fGJKVuKN239guSldCXRbdx4n0cXEHRy
 NmPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcb6v1/dae84C7NIma/a/Jx5arvrzI2b4rtwXq2UDrJ9DtemmO2u23lWKCJvpCcmEK6HHNeAH0+MkedV7RDJVK9gajus4=
X-Gm-Message-State: AOJu0Yz7ai3MbM4JVhCK535T7Ajy7HRpyzvnk3e+xbV1zFPIF6F38YS2
 veNI3ZigWHNOfLXzJrNRNF6WsMLBiLO1tpTobZZ6x8GGlmkF3J5wDBbagJ/34wA=
X-Google-Smtp-Source: AGHT+IGjKkOyr3f3ErgC37kJeVNzpF0SkjzTbB0I+RN4kEPiIYwzrQdW5tGZlepV40sjsR90Km3fPg==
X-Received: by 2002:a17:907:3ea8:b0:a52:56e8:2245 with SMTP id
 hs40-20020a1709073ea800b00a5256e82245mr8879019ejc.47.1713768731868; 
 Sun, 21 Apr 2024 23:52:11 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 i12-20020a170906698c00b00a4e58c74c9fsm5364887ejr.6.2024.04.21.23.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Apr 2024 23:52:11 -0700 (PDT)
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
Subject: [PATCH v4] riscv: thead: Add th.sxstatus CSR emulation
Date: Mon, 22 Apr 2024 08:52:08 +0200
Message-ID: <20240422065208.1953562-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x635.google.com
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
 target/riscv/cpu.h       |  3 ++
 target/riscv/meson.build |  1 +
 target/riscv/th_csr.c    | 77 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+)
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
index 0000000000..0eb3ad64f1
--- /dev/null
+++ b/target/riscv/th_csr.c
@@ -0,0 +1,77 @@
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


