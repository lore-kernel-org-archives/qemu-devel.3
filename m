Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A9BC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQ5V-0000Fv-JF; Wed, 27 Mar 2024 06:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rpQ5O-0008RJ-7g
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:00:46 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rpQ5J-0000ut-2c
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:00:45 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a46a7208eedso886009566b.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1711533638; x=1712138438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=unvmvu9B6Vrmtygb3di4GTC7E2hLPG03yoE1C4AJVBI=;
 b=N/KYZuylSZEqTGKTG91tPubss/u375CCT8SRyWNKXP6lZBRfHchSPfpJqwMe2MzXAq
 dHg8rTo/8eKZukj0QPZqWzW5ou5ZgrK7rh3fCwUDDxaDkBmaffTfJyXXkVjfpoGbzskP
 CQ+Zy0wePzumHrxVeEvS9ka1irgXJO8y1VaiI4Tls59Z26MRRs8BfUxoBA+snJv2Gq+u
 v95pkQGPUWP2RZPPyJgccp05kfCMw+WmtSSepnZLds3d02pAcMGyvTJ+8JJPGTmvaUY9
 byg/SwrkljlFdLX+5wq5QFOZIUgtJM/QiiCbQeJA6HYMvBBzLJ97KsRU0ZbxoAHKuFql
 U2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533638; x=1712138438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=unvmvu9B6Vrmtygb3di4GTC7E2hLPG03yoE1C4AJVBI=;
 b=PGx/cPsinsyfwpbq8GruKXNKDMILHBJGEzK6wESvsqQRCbSpH+6Xl+xFW+Kx/S/zd2
 GQ3ikk2zZn3rcTUNWuR7KaE0w0CmEFgpbWkhOJERneWKjw0mlLJdsAqn92jy8Pn0eBHa
 cyB3kJgZZa74q2LuvnwxF06xf09tDM87F5+N6fo/4Ln4EWEUCMC0EmxOval5GPKiESAp
 AhPhV9PV6/bjfnajml+bw0KbdnVHVWV73K/Sdo807JuJffK+XXbgax5CWvtcpwhH5WW/
 jCHmTuENZYr75eQshVUTjpCBCINBwDMZHujHV53zB45l5oHP/C/KLzzlz1wJqVWlbYzq
 ofug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKQBQOQMwQpKXgnwL5NXIhETHocftvINIsRZ7GgQ19oWG9D9uD2aEX/eYXQzICxhAIrsJlKVWacpZ27MT2PeqTuUjn534=
X-Gm-Message-State: AOJu0Yy5qe9EtDryGJyoR7qiEBUkz3JlvlNnVkf0k/jbbarNZDBvrBan
 5rr4CHQywJwFErFJ80yecGR9dc/cBa9vVfm5xg+ggfPueWR/F3mhWL8zQ8Sf9Ro=
X-Google-Smtp-Source: AGHT+IFcC+xfeZlZ9H0mOJx5HI4hgpPLr6qVM3RlRVmV5iCC0LiljRWB+mY0eaZKiODkLQmDKnIMtA==
X-Received: by 2002:a17:906:3797:b0:a46:967b:7c94 with SMTP id
 n23-20020a170906379700b00a46967b7c94mr2605700ejc.18.1711533637763; 
 Wed, 27 Mar 2024 03:00:37 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 n19-20020a170906119300b00a4660b63502sm5277061eja.12.2024.03.27.03.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 03:00:37 -0700 (PDT)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cooper Qu <cooper.qu@linux.alibaba.com>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
 Huang Tao <eric.huang@linux.alibaba.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] riscv: thead: Add th.mxstatus CSR emulation
Date: Wed, 27 Mar 2024 11:00:34 +0100
Message-ID: <20240327100034.3636610-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x62d.google.com
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

The th.mxstatus CSR can be used to identify available custom extension
on T-Head CPUs. The CSR is documented here:
  https://github.com/T-head-Semi/thead-extension-spec/pull/45

An important property of this patch is, that the th.mxstatus MAEE field
is not set (indicating that XTheadMaee is not available).
XTheadMaee is a memory attribute extension (similar to Svpbmt) which is
implemented in many T-Head CPUs (C906, C910, etc.) and utilizes bits
in PTEs that are marked as reserved. QEMU maintainers prefer to not
implement XTheadMaee, so we need give kernels a mechanism to identify
if XTheadMaee is available in a system or not. And this patch introduces
this mechanism in QEMU in a way that's compatible with real HW
(i.e., probing the th.mxstatus.MAEE bit).

Further context can be found on the list:
https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00775.html

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 target/riscv/cpu.c       |  1 +
 target/riscv/cpu.h       |  3 ++
 target/riscv/meson.build |  1 +
 target/riscv/th_csr.c    | 76 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)
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
index 0000000000..7fbcf88b5b
--- /dev/null
+++ b/target/riscv/th_csr.c
@@ -0,0 +1,76 @@
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
+#define CSR_TH_MXSTATUS 0x7c0
+
+/* TH_MXSTATUS bits */
+#define TH_MXSTATUS_UCME        BIT(16)
+#define TH_MXSTATUS_MAEE        BIT(21)
+#define TH_MXSTATUS_THEADISAEE  BIT(22)
+
+typedef struct {
+    int csrno;
+    int (*insertion_test)(RISCVCPU *cpu);
+    riscv_csr_operations csr_ops;
+} riscv_csr;
+
+static RISCVException m_mode(CPURISCVState *env, int csrno)
+{
+    if (env->debugger)
+        return RISCV_EXCP_NONE;
+    if (env->priv != PRV_M)
+        return RISCV_EXCP_ILLEGAL_INST;
+    return RISCV_EXCP_NONE;
+}
+
+static int test_thead_mvendorid(RISCVCPU *cpu)
+{
+    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID)
+        return -1;
+    return 0;
+}
+
+static RISCVException read_th_mxstatus(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
+{
+    /* We don't set MAEE here, because QEMU does not implement MAEE. */
+    *val = TH_MXSTATUS_UCME | TH_MXSTATUS_THEADISAEE;
+    return RISCV_EXCP_NONE;
+}
+
+static riscv_csr th_csr_list[] = {
+    {
+        .csrno = CSR_TH_MXSTATUS,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mxstatus", m_mode, read_th_mxstatus }
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


