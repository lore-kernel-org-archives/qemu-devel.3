Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54569D2594B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkci8-0002tN-Ec; Tue, 27 Jan 2026 01:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkci4-0002sM-Ey
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:58 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkci2-0006jx-V5
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:56 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a7a94c6d4fso24797695ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495874; x=1770100674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpMM34krHzTHUMhvQN91yHojKXhFA1FwURwec+u8eKw=;
 b=UclLR2k+/eNZsYszGA7Gkswlc1AXJiSeptDtIkwSTpGEV8htst/hdJg6MAbTdf7nvG
 NVTU9hQf5IkB0nBPTZj32o7fYTccJzWjrZGtQcv8DWFPa+TIaMZ1+7fW245g2kjhW6z2
 G4L22WUcmz30GXTipHIvfE7+QBGdt6uYR8O7ZifTKcCRaqx3IyrUlKAd7Zr7NJQxx/NX
 Wwr2+WpRhScHuB5TEMXa485bdAJrDkDUTqsqI5f4aO15BDIn/qnrbD2DhQMD8RCWhpwA
 m0fpsR13xccY694I0YBMlQG+IQnfxuU1sL0JrG4M3RT1rd98W5kX1xkzHCfOm0E7rLj4
 ZvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495874; x=1770100674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QpMM34krHzTHUMhvQN91yHojKXhFA1FwURwec+u8eKw=;
 b=Qf/R13GrhtTz//JKKxOoZnZlmZgfT6xoewmmqxxGJUsjPxsEkANvmCvumlhkKL3C2s
 Zh1NXoBdN6pB5Cyuyhf/KEVJ4R5BvylJKIJYtdGTYbN0SspOE55t3czqI0cfUgTgvNnR
 teuaJ2w6T3HtOyYGD2QcgNOhM4nKCvMTGAN7XW8mZMYIXgYcLRPT+j4VKx4yN/Z+wloe
 ZXyNwm5b7M3Gq0Kig7oOI7XpEDWdfs5MhiDBNujqGf1c/RBXLheJpDOuyUan0gMapEKc
 zXb5RTE4exMnbPi/8VpKeKwwzb0LFaSGq9NiBwxwcNt5tZtapnlI7G/q5CUGxqq9eoKY
 /X4Q==
X-Gm-Message-State: AOJu0YwQUfolB1HZKIzzTko7DkGyP31N1nm3C/SScVUioPeV+4gAkt+0
 Ouoe2zKQmfhY+jXunS5cYrVtGz2lHNZesHhJAVTzGNDdZ7w/Vx0PtvC0qwYx/jeGirzd5yhHHj+
 drOrWPtb4tjlvpK64YAZAbj1ZBYcUxKDyZkLqCczWOmdFdn57UzXCSGiUyuSKDW9nWT+snN1X8V
 bvjAXF7dPmRvcaWQ4ksX6xgPU0Gzfe6deL/Ec48GhvAQ==
X-Gm-Gg: AZuq6aLPZPxSGehfee3RbhPCUDRv1MiZPuKR8fU+i0GFYz7R81wr8q4PRfF5jyHaKRN
 KKcxlwbLXgfyu4Dhyg6D2Vmzdrw2r4ZCwweVjjIptlLG0JoL7qsHAhtNJF8psEI3KiB+4+MlU9d
 ZtVikoA3Dcm+F2LgQRFR47SGZ0fUJUMAPoanto2QZ7pdCLinSLftvZoZ5WSnKqC5gBT1mxPuQBG
 HPPW7fgVmXj4c/3NeeEt7IryQiWdAPT/ZbVY6K1ax+z0+oy7rtii+fCtLppuEJC8f2KjkAimMgT
 pWSmIzrulM82BmOwRutvmijdFh15YnQnWNlsUFqc6aO3mxk4/huqf2UQAQRklJ/swyc0NBOSapd
 DFcdU4jRuvDboJzvSive0KCyegVwqI0BuMJz3d8Y+1AlrYv7tSVaknLJZs0nXcMiJbiurfU2UUB
 98fGl7uhpikrv5CV0yCHkjUPLrWV51WAeT/mQ7mhk0JTH6vYhOIHK/XgYlW+YIKE9kl7ugFRVjP
 IIM3xyUfpvzWFU=
X-Received: by 2002:a17:902:e784:b0:2a0:b02b:210b with SMTP id
 d9443c01a7336-2a870dfc7e9mr9761495ad.41.1769495873344; 
 Mon, 26 Jan 2026 22:37:53 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:37:52 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 09/17] target/riscv: rvv: Add vfncvtbf16.sat.f.f.w
 instruction for Zvfofp8min extension
Date: Tue, 27 Jan 2026 14:37:15 +0800
Message-ID: <20260127063723.442734-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x629.google.com
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

The vfncvtbf16.sat.f.f.w instruction converts a vector of 16-bit
floating-point numbers to a vector of 8-bit floating-point numbers with
saturation.
The VTYPE.altfmt field is used to select the format of the 8-bit floating-point
numbers.
* altfmt = 0: BF16 to OFP8.e4m3
* altfmt = 1: BF16 to OFP8.e5m2

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn32.decode                 |  3 ++
 target/riscv/insn_trans/trans_rvofp8.c.inc | 43 ++++++++++++++++++++++
 target/riscv/translate.c                   |  1 +
 3 files changed, 47 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6e35c4b1e6..49201c0c20 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -973,6 +973,9 @@ vfwcvtbf16_f_f_v  010010 . ..... 01101 001 ..... 1010111 @r2_vm
 vfwmaccbf16_vv    111011 . ..... ..... 001 ..... 1010111 @r_vm
 vfwmaccbf16_vf    111011 . ..... ..... 101 ..... 1010111 @r_vm
 
+# *** Zvfofp8min Extension ***
+vfncvtbf16_sat_f_f_w  010010 . ..... 11111 001 ..... 1010111 @r2_vm
+
 # *** Zvbc vector crypto extension ***
 vclmul_vv   001100 . ..... ..... 010 ..... 1010111 @r_vm
 vclmul_vx   001100 . ..... ..... 110 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvofp8.c.inc b/target/riscv/insn_trans/trans_rvofp8.c.inc
new file mode 100644
index 0000000000..f1a7b0affd
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvofp8.c.inc
@@ -0,0 +1,43 @@
+/*
+ * RISC-V translation routines for the OFP8 Standard Extensions.
+ *
+ * Copyright (C) 2025 SiFive, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define REQUIRE_ZVFOFP8MIN(ctx) do {        \
+    if (!ctx->cfg_ptr->ext_zvfofp8min) {    \
+        return false;                       \
+    }                                       \
+} while (0)
+
+
+static bool trans_vfncvtbf16_sat_f_f_w(DisasContext *ctx, arg_rmr *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZVFOFP8MIN(ctx);
+
+    if (opfv_narrow_check(ctx, a) && ctx->sew == MO_8) {
+        gen_helper_gvec_3_ptr *fn;
+        uint32_t data = 0;
+
+        fn = ctx->altfmt ? gen_helper_vfncvtbf16_sat_f_f_w_ofp8e5m2 :
+                           gen_helper_vfncvtbf16_sat_f_f_w_ofp8e4m3;
+
+        gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
+        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
+        tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
+                           vreg_ofs(ctx, a->rs2), tcg_env,
+                           ctx->cfg_ptr->vlenb,
+                           ctx->cfg_ptr->vlenb, data, fn);
+        finalize_rvv_inst(ctx);
+        return true;
+    }
+    return false;
+}
+
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a1c4b325e5..137022d7fb 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1219,6 +1219,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_privileged.c.inc"
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
+#include "insn_trans/trans_rvofp8.c.inc"
 #include "decode-xthead.c.inc"
 #include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
-- 
2.52.0


