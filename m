Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2FDD1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrm3-0001Ti-TK; Thu, 08 Jan 2026 10:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlU-00013S-6O
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:41 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlR-0003ZY-N9
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:31 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so2340880b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885448; x=1768490248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRBuMviCQzKLoZJcd93haU3Tf4rhKSDwz1QTnIhNPyo=;
 b=Tx4MQsv+cGq6JJ/uGg2IUIAMol21/6VP1pb6VF3sTj4pgItw6k6bPA9OnrKaqhc5wa
 sCmcpRw/Z588o1D/xMcJeprrczo+5wplf/TU8dlnkMn/hqbjPSDWAWblDY9r+vhPvVwC
 9dHVThjTy/IrqnaiZpNR83jHpNuRWVb8EvBleNFYljrnNxhVJV/q8y94UEdIzxmRTNk9
 oF9Zf4dsfD8fxz0T3NrWAyeNkbU+NsHPyJrynDDOq5HO/AB7m0KNxpj4KFvPDuEYAGq+
 k+zurxvFYegoAobpVC6XiS/KcRdQfcjcdPabOG3h6d3PNiIHCOFyXgjfAdel5/l7cJsz
 IfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885448; x=1768490248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GRBuMviCQzKLoZJcd93haU3Tf4rhKSDwz1QTnIhNPyo=;
 b=HdzIKqXYW2cCacBIuc35XXfnTz6Tmb+52UxPqg8cH6964JGuxoA9ZZXBxG95FWeIj7
 mszAYzZ6rqFl8IBkmwC4SJlNJbkkLB5YruifEhEA0Y/ufYGIE0D+mUWNASVdO/LY46Jw
 S8rCNC06FdEjusMXoNtTiJtggH5Vh49yoJanZfK/nzf8TDaMaCetf/Y8U1T+7pG0+6Hk
 +uArbek2dEbBnvTkQwO7fueLYny6YNbKCVixElNKfvN1WlY5FyJkxYSmLArK2pL3QguQ
 J92JDdQuaRMSMO2gr0492R3zFgUl35Bd2S9olJmnUp2DiUpCZ6PpNokilrwEQPvhuk6r
 KXsw==
X-Gm-Message-State: AOJu0YyoYsCk4jKVH0qp16es2A6rLNvHEjeeOfyozrlwtg2FhEslIM/K
 Jl4mANK2/qDXWqlPfewSQ/90966n4MFxJbJKA2pIYbLIXHFXJcaFCKbbamxUwrwUEQ64QZHcYwZ
 9K7qRaewuEEUFATEcST90uGzy2aNNkCg/GX5ifWmXVVPIh4irX3zuCBIeZbYAB1ThNsPxBKQgjF
 m5EzaexuZxvRSvlIbIyP8wS4p49EjMGt+I5fZIQAs=
X-Gm-Gg: AY/fxX6hbjyE+xCYgQBYmi+seqbf52w+IN/VPJz64XyMHobn2+BgXp5O4sBr1DKD1KG
 PRBquRjxwcjgrOZYGDt7whuZKdUixALOI3a4tUtVu+n4o5EQXrdvuMNZUuBx4Lz5ucX2alym7fq
 wZaqHirVZER5fN/0UCWNrBJen6xPcJ39MBpzYCuL2ZbU4hA+D4Iu2rAxoEZaCbhYM1Z+mxkpY78
 UOflWBHxMWCjSL5LUam1Oa02XTMnov6Ac3OYJ3H2nJ2RvSGcGopfz18zF/Wvp8DiYWJISygvV2Z
 ejUgXJec4P94EAq9LqpcFsuCQSb6I52BUUTX2TApt0QPkTBUdPc+NQLm9579Sps7qJk1mOZtgll
 Q2JMYWrpnYAIMznxHPfs3nJ+WP4bHtPNRZGWV7RQn9lIM+FXPFy+lJ6cokt5Ag8DNu0wNiZQX7K
 no/upNY1B1mAUZpHuCGnniOkIBAmIl7ZBJeY2k5q5M2YsQ2aO9sqo0azMd0EScMkCXhQ==
X-Google-Smtp-Source: AGHT+IE9Yq2yJvGvUWq3duj3tncXc8ltVWqowv2rGzSWgqrqen0JqTHSQq0i9730CNaHQ9vu83Kk7w==
X-Received: by 2002:a05:6a00:1a1b:b0:81c:4a92:2594 with SMTP id
 d2e1a72fcca58-81c4a92285fmr3403319b3a.40.1767885447731; 
 Thu, 08 Jan 2026 07:17:27 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:27 -0800 (PST)
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
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 10/18] target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction
 for Zvfofp8min extension
Date: Thu,  8 Jan 2026 23:16:41 +0800
Message-ID: <20260108151650.16329-11-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42b.google.com
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
 target/riscv/insn_trans/trans_rvofp8.c.inc | 53 ++++++++++++++++++++++
 target/riscv/translate.c                   |  1 +
 3 files changed, 57 insertions(+)
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
index 0000000000..70a22616dc
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvofp8.c.inc
@@ -0,0 +1,53 @@
+/*
+ * RISC-V translation routines for the OFP8 Standard Extensions.
+ *
+ * Copyright (C) 2025 SiFive, Inc.
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
+#define REQUIRE_ZVFOFP8MIN(ctx) do { \
+    if (!ctx->cfg_ptr->ext_zvfofp8min) { \
+        return false; \
+    } \
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
2.43.7


