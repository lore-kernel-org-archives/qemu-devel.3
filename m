Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E975D232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RE-0005kz-CC; Fri, 09 Jan 2026 01:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6QJ-0005At-TH
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:44 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6QH-0002uy-PJ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:39 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-bc274b8b15bso2586659a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941796; x=1768546596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7rfip6RLO4KehajLK/Crndgj6uNCXjS7ySjzRuZjhQ=;
 b=gttemzVUb+oWDrkivkCRN8aCvKTNW1xVQoHesBxvxhDHBZhW2LXmEkEd1LQiX89yEP
 2O7KRAQukOvJZO5lSgxJnNocoJylH90LKZcpWtppklCE754sENKohMk0wpWxrlEI4nUC
 SoAun5d8AijYKlbL5WuhSsO24uvAu23hDOLTQvQsWxi3qemi5YzV6J4NMKrs9VhE3t75
 gZcmVesZxlwUx1SdLZCUF+8QtsCdtscFGSg2AiLz5lYHIRlkzv+n4UEhTYsGdsat8y43
 u3QaIC7EyyeRSIFBT2UVDYKb5dD6kKSd/fRINk6G3moGxhvi88tEuwq+5wpQ7PYgk/ra
 4UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941796; x=1768546596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d7rfip6RLO4KehajLK/Crndgj6uNCXjS7ySjzRuZjhQ=;
 b=Aww+tgC5MANjI0yTKDDUFUomk2SxV9LWmNqKJDa8TTtlqaNTxGCxCWQWTLWyetSAlF
 5nV7gJdWRdB+g59Kr08BE1SmTDOiX1YKSmxbQBuieVI2iGisPbMi9FJue+pjDYylkCdz
 8KeBtvaclcjHKb21km7TBk/BpB3hAZ8wGADvg66XuaFwxe218YqK2zdkPD4cjD4vefID
 0nkFvOTBK+Wm3yeKY1Jc07WqRWNYx7E8xfBHs8PAbl5lBSysRpyCjuh8y7vZ0afS/UMl
 Jl3D2vP2exMirxTMbyG8e/LAkhmL0BWwKV0KlUeWlJanuktRXE5ECsygQL/aAshunxO7
 KyDw==
X-Gm-Message-State: AOJu0YyuLb1AEfxdSdJa02bkwtoGGVXuaSUmQ/Am1UcTbBOG7Yr+WP55
 O/iqPj4woPBDTLquqdGlVD21/HqaTcsq89h17TaiSpUmw8FZma0vhL8m1dNTDg==
X-Gm-Gg: AY/fxX5MuCohyVcpVCmr2H/hmNMuAAeVwufv/3gGYVWU4EOObo9Sb7ujikAmPdDAa2s
 S0MAGuryxSihFw1fci8KkDJg/+vOE4pGh7u06/6dgDo6UC5sWlzGaSkCKLM9WX2AnY4gph26Phm
 gnDedtAluw6SuqCSj4FpU4NjlTzdTb0OMAc5vcWu8tZeonYNX4l0eabH8Nw/PH9/UfWaMn3IaRz
 dlg/ET05LtfW5AKTmEclczg4plPpOFKec2iU4r4xoKZyNO3p8Afe+vk02H6gRUT0q8XvjqcegrE
 4zW0dwR+r/LHHKamG8ROrxHLmGPjoPrSEoE7DnCS9maGspv/QALVH2QRJpvmlQ/zEo229UlXZPP
 lP8pWp0ADs0hTWzBkfwLo1snSP1Zc2gvc5Ahfm020+kuMFUSDV81+HgkZ343XXkmAUmKtQHxSpS
 jK84y9NLypyhz384AyMQKTay2+aNtNNEpyKDqkEs9gI1qvehZkZPsY7VSIt52z2fMEsx0W0dRFI
 15rb67yJXU5ofrhX5w=
X-Google-Smtp-Source: AGHT+IFRMiJAo9qhkUbfNWUrLnY074Ay06wRuZLmQ6QTJsb+l93pW0tu0md2MOWVrtcGQLvcSeEyOw==
X-Received: by 2002:a05:6a20:3d95:b0:344:f9e5:e9a9 with SMTP id
 adf61e73a8af0-3898f8fdc5emr7870575637.18.1767941796027; 
 Thu, 08 Jan 2026 22:56:36 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:35 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/34] target/riscv: Add mips.ccmov instruction
Date: Fri,  9 Jan 2026 16:54:51 +1000
Message-ID: <20260109065459.19987-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260108134128.2218102-5-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                    |  5 ++++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/xmips.decode                 | 11 ++++++++
 target/riscv/cpu.c                        |  3 +++
 target/riscv/translate.c                  |  3 +++
 target/riscv/insn_trans/trans_xmips.c.inc | 33 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 7 files changed, 57 insertions(+)
 create mode 100644 target/riscv/xmips.decode
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *cfg __attribute__((__unus
     return true;
 }
 
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index f4ff4f3f96..0b461bb05b 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -150,6 +150,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..fadcb78470
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e17b3e0785..d0a6a88a4e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -252,6 +252,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1363,6 +1364,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
 
     { },
 };
@@ -3315,6 +3317,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp = true,
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
+        .cfg.ext_xmipscmov = true,
         .cfg.marchid = 0x8000000000000201,
         .cfg.mvendorid = MIPS_VENDOR_ID,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0d61420b46..f687c75fe4 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1211,8 +1211,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
 
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1229,6 +1231,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 
 const RISCVDecoder decoder_table[] = {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..3202fd9cc0
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,33 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+/* Conditional move by MIPS. */
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero = tcg_constant_tl(0);
+    source1 = get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 = get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 25d59ef9f9..3842c7c1a8 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen = [
   decodetree.process('insn32.decode', extra_args: '--static-decode=decode_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=decode_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=decode_xmips'),
 ]
 
 riscv_ss = ss.source_set()
-- 
2.52.0


