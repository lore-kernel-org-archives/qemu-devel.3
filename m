Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BD3CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 19:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIAt6-0003Ob-2y; Sun, 09 Nov 2025 14:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vIAt3-0003Mf-KR
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 14:15:41 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vIAt0-0007us-2X
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 14:15:41 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so15405545e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 11:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1762715736; x=1763320536;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOCt94/jYqEKQ0fi5IY8khjz3WqWYGUTB8ZkxXFgisw=;
 b=gYIUPHIRJPGogFPkXDEcuC8goxDEzgBAApcIklpkQ9UTcQ8u2seXCx64nWqcRD7wNt
 K497cQBKcMKCO86qQPQWJMMDPwCy/253sTTBFlWAC0ztbyCi20MAzs0qB0hl+pnzf3fk
 d4jAdnuTWqmiasiAvhjAVdU0HeCnEedLCdb4jObN1HGYKjC9Zm5assYxzoelhDpgD3E3
 zkuJrR5BO3mUBAzYj7+QZBZDEyTSrQDGS/uxzIaj6D9LHUhSWy10gwZDvry4Ldho+Jn8
 39I7yBsqIaRQUzybWgkbKK38ItZtAsGEW+4i+BP5DoRHY5uwoEVk+ipi4NdyyU3EzNnD
 rb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762715736; x=1763320536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yOCt94/jYqEKQ0fi5IY8khjz3WqWYGUTB8ZkxXFgisw=;
 b=JszCOnvKNvMZbcPyRNFTxlsTsI3ljB/fiGBA0mqhulUlxoMHGmmMcjNLly4UHar9tY
 Btzmr63mqF3UjqQkHLFEzadyLR4Fif0O9JO6xfZhpNjTibS1eZRUZR9PN2IGVatNqB5S
 EG9m5pxkSFAS+vlmUrdCQl8zCXR1gNMRzqkXepl2Lwkg2p4UFWfOQ/13LTuutWP1oUtb
 JqG89HLf2llt1SRE8GdAB29lIBUt0qKYioxg3St0TAV1B1xkOg9ZQgI0ru0O7vbesVGx
 9ZarR8uJDid43e7R4Zod2nAOyocBuFKXJ6Ihy5fY9JC6/yjCKDbPpHPfuhB690RNKTeS
 0B1g==
X-Gm-Message-State: AOJu0Ywr1mcaExJzczMrPLw9/YxDq5lav7I8gOcvFfQVefaZY37RWnUJ
 JblbTfUs//FreCYB1LGZzhBOGZionHDWbcdepfGL5E72xryk+oV1/ct7gN2UbCiiOeWUlshb7gj
 zaj8mdZo=
X-Gm-Gg: ASbGnctZkV0mqPRn9w3YpQZ3hXPxBsqdNc4yupcNxvEir1j+WBuqHdHyg/4dlyUCltR
 d2n4dulWWcEYuVJvGlq3yty527Rr0lChQBlGWZTLk5MHmb1Kr2ICx/FvL5SuIL76PAqqAEwqBDK
 Vgy88WkA2zqfF2Bnt8xPmGsmjtE04Uht1uodL7/ZXtAjy6hC2Qqghxg9veGblgoFnkfHt1ke1E6
 5SyuJTfkBd8Iv40/AX3QwcWw8m2JCJtmJn3v5PYDVbwtVBuqaiNLxrCeXkrqajeI/IhUGzW42dZ
 IoZ0UOC4P3xEzqO8SjD4OkTaLuH7ARcv4riS25u+pKLEoqYtMdWeOjcb+AVyGYzi4bz7lnBQjZ+
 NzpEixQdQtd5FGpn2VH+XqEMFUmEC/YQkFsdnVRv/lgnpjQ0nUXNlD9YmHpOWBfTLgw/d9sLXvw
 FXqMSQGaWgyGY=
X-Google-Smtp-Source: AGHT+IFJsfVD+5aLGfqGgoEpdZnXSs5ITo7S7ZZi4TxhmchvxvJpfRf7R3MdID25JqgTW7Zc2Sv/Hw==
X-Received: by 2002:a05:600c:4251:b0:475:de06:dbaf with SMTP id
 5b1f17b1804b1-4776dcd61dfmr44318815e9.17.1762715735995; 
 Sun, 09 Nov 2025 11:15:35 -0800 (PST)
Received: from DDesktop.local ([2a10:8012:1:b32a:35:83e6:baea:8ad])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47778daf2c3sm54600265e9.10.2025.11.09.11.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 11:15:35 -0800 (PST)
From: Michael Levit <michael@videogpu.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, smishash@gmail.com
Subject: [PATCH v4 1/5] target/riscv: add NEORV32 RV32 CPU type and vendor CSR
 hooks
Date: Sun,  9 Nov 2025 21:15:28 +0200
Message-ID: <20251109191532.32419-2-michael@videogpu.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109191532.32419-1-michael@videogpu.com>
References: <20251109191532.32419-1-michael@videogpu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::330;
 envelope-from=michael@videogpu.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

From: Michael <michael@videogpu.com>

Introduce NEORV32 RV32 CPU type under target/riscv, wire NEORV32 vendor ID,
and add a vendor CSR (CSR_MXISA) guarded by mvendorid match, plus meson glue.

Signed-off-by: Michael Levit <michael@videogpu.com>
---
 target/riscv/cpu-qom.h            |  1 +
 target/riscv/cpu.c                | 17 +++++++++++++
 target/riscv/cpu.h                |  3 +++
 target/riscv/cpu_cfg.h            |  1 +
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/cpu_vendorid.h       |  2 ++
 target/riscv/meson.build          |  1 +
 target/riscv/neorv32_csr.c        | 40 +++++++++++++++++++++++++++++++
 8 files changed, 66 insertions(+)
 create mode 100644 target/riscv/neorv32_csr.c

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..e0c1f5888f 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -43,6 +43,7 @@
 #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
+#define TYPE_RISCV_CPU_NEORV32          RISCV_CPU_TYPE_NAME("neorv32")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c..67260ed9d7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -233,6 +233,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xneorv32xisa, PRIV_VERSION_1_10_0, ext_xneorv32xisa),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1366,6 +1367,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xneorv32xisa", ext_xneorv32xisa, false),
 
     { },
 };
@@ -3075,6 +3077,21 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVE
     ),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_NEORV32, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI | RVM | RVA | RVC | RVU,
+        .priv_spec = PRIV_VERSION_1_10_0,
+
+        .cfg.max_satp_mode = VM_1_10_MBARE,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true,
+        .cfg.pmp_regions = 16,
+        .cfg.mvendorid = NEORV32_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs = neorv32_csr_list
+#endif
+    ),
 #endif
 
 #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f10037..6a9918a25a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -985,5 +985,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
 
+/* Implemented in neorv32_csr.c */
+extern const RISCVCSR neorv32_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..9ad38506e4 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -64,5 +64,6 @@ MATERIALISE_EXT_PREDICATE(xtheadmemidx)
 MATERIALISE_EXT_PREDICATE(xtheadmempair)
 MATERIALISE_EXT_PREDICATE(xtheadsync)
 MATERIALISE_EXT_PREDICATE(XVentanaCondOps)
+MATERIALISE_EXT_PREDICATE(xneorv32xisa)
 
 #endif
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a154ecdc79..b84e1bd287 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xneorv32xisa)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..66a8f30b81 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -7,4 +7,6 @@
 #define VEYRON_V1_MIMPID        0x111
 #define VEYRON_V1_MVENDORID     0x61f
 
+#define NEORV32_VENDOR_ID       0xF0000001
+
 #endif /*  TARGET_RISCV_CPU_VENDORID_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fdefe88ccd..44e706ad3f 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -40,6 +40,7 @@ riscv_system_ss.add(files(
   'th_csr.c',
   'time_helper.c',
   'riscv-qmp-cmds.c',
+  'neorv32_csr.c',
 ))
 
 subdir('tcg')
diff --git a/target/riscv/neorv32_csr.c b/target/riscv/neorv32_csr.c
new file mode 100644
index 0000000000..3b0f0cab05
--- /dev/null
+++ b/target/riscv/neorv32_csr.c
@@ -0,0 +1,40 @@
+/*
+ * NEORV32-specific CSR.
+ *
+ * Copyright (c) 2025 Michael Levit
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+#define    CSR_MXISA    (0xfc0)
+
+static RISCVException smode(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_neorv32_xisa(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
+{
+    /* We don't support any extension for now on QEMU */
+    *val = 0x00;
+    return RISCV_EXCP_NONE;
+}
+
+static bool test_neorv32_mvendorid(RISCVCPU *cpu)
+{
+    return cpu->cfg.mvendorid == NEORV32_VENDOR_ID;
+}
+
+const RISCVCSR neorv32_csr_list[] = {
+    {
+        .csrno = CSR_MXISA,
+        .insertion_test = test_neorv32_mvendorid,
+        .csr_ops = { "neorv32.xisa", smode, read_neorv32_xisa }
+    },
+    { }
+};
+
-- 
2.51.1


