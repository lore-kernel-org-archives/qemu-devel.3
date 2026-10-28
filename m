Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D69606A334
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=hE/Wb3tU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLvKf-0007aO-3h; Wed, 28 Oct 2026 00:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvKG-0007WU-AK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:31:51 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvKE-0001dg-2K
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:31:47 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2d01548ac96so956175ad.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 21:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793161904; x=1793766704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dgo2XhJWzYeIm74eJEIkWqQP5o4rena+PUi0auaTe00=;
 b=hE/Wb3tU2CLUJFZ2tMC2vCpz9l1uTdVktEYH6kG68+FKfCShcNFOw1m5z4Gv2oV2KW
 JEiy+kVBt12548qz4yg5JJrk636kNIQjUIYWv/exj1w0Wy+xzvR6dIYra0QEuycTL2M+
 dFijnbcLx6zR+Jw4jPPuja84ilqqhNF9wPymc/slSWmZsPZ1KvmyXJe5bvrdKSsCAPkb
 0Z6Zhk6nDZ0DDZu6j6bsKPnHz4b4ddUe7qUOzYy8GZtNpcTlyMfxfuHcRpJpixsgJWHi
 RdMNmYZGfvoRJ1xKnMrPVVCrhC6mN5t0rUxt92CGQxAJh9XoHcRFXI8udwa30C3aym1w
 yM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793161904; x=1793766704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dgo2XhJWzYeIm74eJEIkWqQP5o4rena+PUi0auaTe00=;
 b=SAQ01ox2bRIBI7vIgEG+M6dJ8wfkEdacm1CcpI5ZagCZertFH1ys1X/iVuWCPG7tWo
 0mwbsLsWXxsULcwn/UvFxbuYuRLO7cZxBYVmu6kK667bMZV+jq2flMZ7nbAiZEas/f36
 NZXJE7SADa6HVeXbSs0NeTHEpwu8881An+TNbsF7Gksk9dbkYIaU2cwD2CWLrFMfuMcB
 OdM6oyHZkzgTa3MMh+mwuUiJIPQCIFw6wVHm+zWEcp0tHRH25tMLMJOQb30OqyDI8dP8
 3tKPKf5yfxcyi9RLH+WR00eTPff2fbZ77WHa+B0p3873/nETcN6JOIsW3pHO2FipVocs
 DwIg==
X-Gm-Message-State: AFq9FYK8tZce081ADmGlMqFri3PwgoZSLF04wBHBjW2PEHPoGRtD0EQi
 qTjGn+sNIYovZdvw4EQDzK+RZzwDxGZ5dV6prc22xUkfeOe/k77hxcyLCD/TqK+KT4dOXbr14MZ
 hTWhn
X-Gm-Gg: AYBFou1y6VIi3OjIa8qEldqfRaquYN3Y2mTAONL3G9XjK1nmltZ8LvSZIusGH39EW7P
 iXFAbKE0AnZ1+4xbZ32EpYdojOFAt4QYolecNbEaKgk0vu9CCE+61Ca2NgOYgjyDvsMntum4q+q
 p5Yz74T/Gv1GgIKwpR8oUzw0bPk+ey+iFtSb8KUzzFfWLJKKMKjk0Yirfl8TpEwriBrj8xGUUQy
 pXacCWJfpRYPafUgrOExgU5TwlzKlaXfBWr4he7Ufeb+eLOFzgAAWWbWWJb940tsSGDD4Dx67p9
 G4nOBtoYsC2tFH5r/Tw/CaXZo3nH0PyR9vhcqLkTfywO4qphmB2TvGYG3td33pgZ25bPn7Zb3RD
 YRSb5+ulcn2QEGOkClAsrmU7TcJiEGzj81d8UBgm+eZiGFU0rXfUzKfk1qUvsnN/uhECfrGPAfz
 ro3L2rarDxQbRKXGIkWNoX9xLYiBCfMBINx51EcgtdvAUnbmry2+hnojPI5BIb0zm7eTTeslXUS
 pyxgAU6OC64FBJfsd15cGzX0Yq+Ku/n3x5ve4C6/XDsACxZpJr9ay/jtmHixqsZOcS5HKTO1KsO
 txDtvEo06IWYOXzCicpL6c386i+Ag19hQcFV2VfBY+lKZUSSezRJK4V58IlCXDe7CwwPu7bdXhv
 aI/0=
X-Received: by 2002:a17:90b:4c:b0:3ad:818f:3db4 with SMTP id
 98e67ed59e1d1-3ae582da5fdmr1439012a91.6.1793161904535; 
 Tue, 27 Oct 2026 21:31:44 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a5d45a8sm1024470a91.17.2026.10.27.21.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 21:31:44 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 05/10] target/riscv: Add Tenstorrent Real-time CPU
Date: Wed, 28 Oct 2026 14:30:54 +1000
Message-ID: <20261028043059.600498-6-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028043059.600498-1-portias@oss.tenstorrent.com>
References: <20261028043059.600498-1-portias@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=portias@tenstorrent.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RCPU is a high-performance 32-bit RISC-V embedded processor featuring
a 6-stage, dual-issue superscalar pipeline, with tightly-coupled memories
(TCMs), advanced interrupt controller (CLIC), and comprehensive
debug/trace capabilities. It is designed for real-time, system
management, and safety-critical applications requiring deterministic
execution and low interrupt latency. See the Atlantis Datasheet, section
2.2 for more information [1].

The Atlantis SoC includes an RCPU used for boot, low-level control, and
ongoing system management [1]. This adds a cpu entry for the RCPU
and implementation specific CSRs. The CSRs are stubbed to allow code to
run without exceptions but does not implement their functionality.

[1] https://github.com/tenstorrent/atlantis-soc-docs/blob/main/data_sheet/atl_soc_data_sheet.pdf

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 MAINTAINERS                  |  1 +
 target/riscv/cpu-qom.h       |  1 +
 target/riscv/cpu.c           | 28 +++++++++++++++++
 target/riscv/tcg/csr.h       |  3 ++
 target/riscv/tcg/meson.build |  1 +
 target/riscv/tcg/tt_csr.c    | 58 ++++++++++++++++++++++++++++++++++++
 6 files changed, 92 insertions(+)
 create mode 100644 target/riscv/tcg/tt_csr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cc426451c..b5b019b3e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1847,6 +1847,7 @@ R: Portia Stephens <portias@oss.tenstorrent.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: docs/system/riscv/tt_*.rst
+F: target/riscv/tcg/tt_*.c
 F: hw/misc/tt_*.c
 F: hw/riscv/tt_*.c
 F: include/hw/misc/tt_*.h
diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 61234842e3..72570ed47e 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -57,6 +57,7 @@
 #define TYPE_RISCV_CPU_THEAD_C908V      RISCV_CPU_TYPE_NAME("thead-c908v")
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
+#define TYPE_RISCV_CPU_TT_RCPU          RISCV_CPU_TYPE_NAME("tt-rcpu")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
 #define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a682350d28..fdedf16ebe 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3455,6 +3455,34 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp_regions = 8
     ),
 
+#if defined(TARGET_RISCV32) || \
+    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_RCPU, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI | RVM | RVA | RVB | RVC | RVD | RVF | RVU,
+        .priv_spec = PRIV_VERSION_1_13_0,
+
+        .cfg.mmu = false,
+        .cfg.ext_zbc = true,
+
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_zca = true,
+        .cfg.ext_zcb = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicntr = true,
+        .cfg.ext_zihpm = true,
+        .cfg.ext_zicond = true,
+        .cfg.pmp = true,
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+        .custom_csrs = tt_csr_list,
+#endif
+    ),
+#endif
+
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
diff --git a/target/riscv/tcg/csr.h b/target/riscv/tcg/csr.h
index 53ba3b4a4d..4bc55b70d6 100644
--- a/target/riscv/tcg/csr.h
+++ b/target/riscv/tcg/csr.h
@@ -87,6 +87,9 @@ extern const RISCVCSR th_csr_list[];
 /* Implemented in mips_csr.c */
 extern const RISCVCSR mips_csr_list[];
 
+/* In tt_csr.c */
+extern const RISCVCSR tt_csr_list[];
+
 /* PMP CSRs, defined in pmp.c */
 void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
                       target_ulong val);
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 86805b30cb..77357475c3 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -25,6 +25,7 @@ riscv_system_ss.add(files(
   'pmp.c',
   'pmu.c',
   'th_csr.c',
+  'tt_csr.c',
 ))
 
 
diff --git a/target/riscv/tcg/tt_csr.c b/target/riscv/tcg/tt_csr.c
new file mode 100644
index 0000000000..c76cd1a9cb
--- /dev/null
+++ b/target/riscv/tcg/tt_csr.c
@@ -0,0 +1,58 @@
+/*
+ * Tenstorrent CPU implementation specifics.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2026 Tenstorrent
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "target/riscv/tcg/csr.h"
+
+/* RCPU custom CSRs */
+#define RCPU_CSR_MICACHE          0x7c0
+#define RCPU_CSR_MDCACHE          0x7c1
+#define RCPU_CSR_MITCMCR          0x7c5
+#define RCPU_CSR_MDTCMCR          0x7c6
+#define RCPU_CSR_MHCR             0x7c7
+#define RCPU_CSR_MEXINFO          0x7ca
+#define RCPU_CSR_MNMIE            0xbc6
+
+/* predicate for an RCPU core */
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_zero(CPURISCVState *env, int csrno,
+                                target_ulong *val)
+{
+    *val = 0;
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_none(CPURISCVState *env, int csrno,
+                                 target_ulong val, uintptr_t ra)
+{
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR tt_csr_list[] = {
+    { .csrno = RCPU_CSR_MICACHE,
+      .csr_ops = { "micache", any, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MDCACHE,
+      .csr_ops = { "mdcache", any, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MITCMCR,
+      .csr_ops = { "mitcmcr", any, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MDTCMCR,
+      .csr_ops = { "mdtcmcr", any, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MHCR,
+      .csr_ops = { "mhcr", any, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MEXINFO,
+      .csr_ops = { "mexinfo", any, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MNMIE,
+       .csr_ops = { "mnmie", any, read_zero, write_none} },
+    { },
+};
-- 
2.43.0


