Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E59D232E9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RE-0005kn-21; Fri, 09 Jan 2026 01:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Q2-0004bZ-Sa
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:23 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Pz-0002tH-Tw
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:22 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-bc274b8b15bso2586491a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941778; x=1768546578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POiDnI8BIOUkZ2LDLAStq+imox0YEbmN0To2N6UkRIc=;
 b=FSU25YZ8yvr2gx6dWlBq4YlC/uLblpDyWZPcaDlJ89ochDfpvl4suYmIHklTSVfB2k
 L1e2jzkrkM0NVOX76jgfPIDxOw7GCvOwhNqtnV16bXUxEaMW6f4piFEiivRpyuYBiuAY
 oImiPYkmfV3/CL9/ysDLcnuCWeY2PqaXC/xcQ9tJoa0W40cSZkLb6pIEpIA5hMnF7GDj
 M0noLK9yYeU8X2zXywDxBqCX7ETBETvcJA54biY6LniZJMZp1kUfM56ymr8eejQaQ2+i
 k5RCRrljASFxoLa15Lt69nq4o0SKiFidcbk/ku5IrisWEMTH+GU3m1JRl7DS1tTFsQUY
 DJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941778; x=1768546578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=POiDnI8BIOUkZ2LDLAStq+imox0YEbmN0To2N6UkRIc=;
 b=jneph0nm6aTxFz88/dP/q4i6MmO4C6+opQCrOkcVujgjzVfxX8a5iGSCU9Vwjdovsn
 PO02c1+J/jOuNmBB52LJKrMaow/htQWc3xnPpdDUYKko7IofzicoERewt/HQ5x3H1002
 BrVjhAklX//KcrB7c1C86FyF/CM85SHGg6h0vow7CLW5NSOCr5jp6DrFee2LzIQICiwm
 Qzxy1HJM9K50rjAvgcwKLDtVaVfJN8QIXmPu+tyeHzzt+V4Eu9awXcvPGhYAQiGy+U/h
 b1bTcmIX10cVqOX9WDmuAdDsHguvVK2Bu9RwVBZqQ4xBuNo0R8cWJdhCjMQnEQDHe69y
 iwgQ==
X-Gm-Message-State: AOJu0Yz5GugTfjUeDjz8P02LrJ/h5e6yuY8em/RLMsbciUSthCzaCofz
 7COV5hH2UBxJANHABde12LUk8BxAw7tZH2R8Y+Q73vYs0VAazEQVTxfotVHPKw==
X-Gm-Gg: AY/fxX453tVQJNV4zl/fxxfzweD01ABjp3+CovcI3aMMPDkKQNZ99/7cRHsA8r1cdTJ
 Dqsy1WR2ovcJmBj+HAUOEXrVx7p1poXtvcl57lnuZSnPalXsZGEtRo2yuBeRKQZzdf+c8ZE8c4W
 98i6DQqoAcSQzqMP9TlgGpv7n/jQX+bc25JuZ/GPykv9xKAK8J16r5qF2sdO2sR6ntwGsJwXu3u
 +/Q6LxCzkChwVmMVW4NXHKpXyUH6JnvnuJMyptJF6qhfTVx/HXWHEmm7lyx1tfHS1wNXeZcxd+0
 /2cCri6Ui6RRcknR+WwAdgcZ/aJ7yFNSZJYkcmybMNkUJKq8w4LcJhv5DlINx9F445qiM6I/CJV
 8a2iYjpDCh2j7whLeis7N1K/V1MaPXX8m+oCiTSnFf8KnpN/h7KfrC/rEdyJs5RtiF/qK8s3YN2
 qgoLHt0AhRlUzBWcZ08Il5y67axj8r/uHfnSYjYu9AyXcY12lhHwXy+F0KhJsdOjiNGxTNmch5r
 fK2MNT3bXlfPmKHkZo=
X-Google-Smtp-Source: AGHT+IHcfbgguSGHcqW8IKJA2C+mthnfIWW2+4aXmzizcSWSzMAaQeqIQRGAXjiH4OBD2/uTTwhSIw==
X-Received: by 2002:a05:6a20:7d9d:b0:364:144a:d21c with SMTP id
 adf61e73a8af0-3898f9058d9mr8597463637.26.1767941777954; 
 Thu, 08 Jan 2026 22:56:17 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:17 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, lxx <1733205434@qq.com>,
 LIU Xu <liuxu@nucleisys.com>, SUN Dongya <sundongya@nucleisys.com>,
 ZHAO Fujin <zhaofujin@nucleisys.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/34] target/riscv: Add Zilsd and Zclsd extension support
Date: Fri,  9 Jan 2026 16:54:46 +1000
Message-ID: <20260109065459.19987-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
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

From: lxx <1733205434@qq.com>

This patch adds support for the Zilsd and Zclsd extension,
which is documented at https://github.com/riscv/riscv-zilsd/releases/tag/v1.0

Signed-off-by: LIU Xu <liuxu@nucleisys.com>
Co-developed-by: SUN Dongya <sundongya@nucleisys.com>
Co-developed-by: ZHAO Fujin <zhaofujin@nucleisys.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <176154834968.21563.217396575391240410-1@git.sr.ht>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg_fields.h.inc         |   2 +
 target/riscv/insn16.decode                |   8 ++
 target/riscv/insn32.decode                |  12 ++-
 target/riscv/cpu.c                        |   4 +
 target/riscv/tcg/tcg-cpu.c                |  33 +++++++
 target/riscv/translate.c                  |   1 +
 target/riscv/insn_trans/trans_zilsd.c.inc | 105 ++++++++++++++++++++++
 7 files changed, 163 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a154ecdc79..0a12ccd6cd 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -19,6 +19,7 @@ BOOL_FIELD(ext_zce)
 BOOL_FIELD(ext_zcf)
 BOOL_FIELD(ext_zcmp)
 BOOL_FIELD(ext_zcmt)
+BOOL_FIELD(ext_zclsd)
 BOOL_FIELD(ext_zk)
 BOOL_FIELD(ext_zkn)
 BOOL_FIELD(ext_zknd)
@@ -41,6 +42,7 @@ BOOL_FIELD(ext_zicond)
 BOOL_FIELD(ext_zihintntl)
 BOOL_FIELD(ext_zihintpause)
 BOOL_FIELD(ext_zihpm)
+BOOL_FIELD(ext_zilsd)
 BOOL_FIELD(ext_zimop)
 BOOL_FIELD(ext_zcmop)
 BOOL_FIELD(ext_ztso)
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index bf893d1c2e..c34020e4dc 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -130,10 +130,14 @@ sw                110  ... ... .. ... 00 @cs_w
 {
   ld              011  ... ... .. ... 00 @cl_d
   c_flw           011  ... ... .. ... 00 @cl_w
+  # *** Zclsd Extension ***
+  zclsd_ld        011  ... ... .. ... 00 @cl_d
 }
 {
   sd              111  ... ... .. ... 00 @cs_d
   c_fsw           111  ... ... .. ... 00 @cs_w
+  # *** Zclsd Extension ***
+  zclsd_sd        111  ... ... .. ... 00 @cs_d
 }
 
 # *** RV32/64C Standard Extension (Quadrant 1) ***
@@ -212,10 +216,14 @@ sw                110 .  .....  ..... 10 @c_swsp
   c64_illegal     011 -  00000  ----- 10 # c.ldsp, RES rd=0
   ld              011 .  .....  ..... 10 @c_ldsp
   c_flw           011 .  .....  ..... 10 @c_lwsp
+  # *** Zclsd Extension ***
+  zclsd_ldsp      011 .  .....  ..... 10 @c_ldsp
 }
 {
   sd              111 .  .....  ..... 10 @c_sdsp
   c_fsw           111 .  .....  ..... 10 @c_swsp
+  # *** Zclsd Extension ***
+  zclsd_sd        111 .  .....  ..... 10 @c_sdsp
 }
 
 # *** RV64 and RV32 Zcb Extension ***
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cd23b1f3a9..b341832e41 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -182,8 +182,16 @@ csrrci   ............     ..... 111 ..... 1110011 @csr
 
 # *** RV64I Base Instruction Set (in addition to RV32I) ***
 lwu      ............   ..... 110 ..... 0000011 @i
-ld       ............   ..... 011 ..... 0000011 @i
-sd       ....... .....  ..... 011 ..... 0100011 @s
+{
+  ld       ............   ..... 011 ..... 0000011 @i
+  # *** Zilsd instructions ***
+  zilsd_ld ............   ..... 011 ..... 0000011 @i
+}
+{
+  sd       ....... .....  ..... 011 ..... 0100011 @s
+  # *** Zilsd instructions ***
+  zilsd_sd ....... .....  ..... 011 ..... 0100011 @s
+}
 addiw    ............   ..... 000 ..... 0011011 @i
 slliw    0000000 .....  ..... 001 ..... 0011011 @sh5
 srliw    0000000 .....  ..... 101 ..... 0011011 @sh5
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 60abdf3324..d48ff50232 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -121,6 +121,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
+    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
     ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -144,6 +145,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_13_0, ext_zcmop),
     ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
     ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
+    ISA_EXT_DATA_ENTRY(zclsd, PRIV_VERSION_1_12_0, ext_zclsd),
     ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),
     ISA_EXT_DATA_ENTRY(zbb, PRIV_VERSION_1_12_0, ext_zbb),
     ISA_EXT_DATA_ENTRY(zbc, PRIV_VERSION_1_12_0, ext_zbc),
@@ -1267,6 +1269,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
 
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
     MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
+    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
 
     MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
     MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
@@ -1306,6 +1309,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
     MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
     MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
+    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),
 
     /* Vector cryptography extensions */
     MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index cdc05f60e9..988b2d905f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -834,6 +834,19 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->pmu_avail_ctrs = 0;
     }
 
+    if (cpu->cfg.ext_zclsd) {
+        if (riscv_has_ext(env, RVC) && riscv_has_ext(env, RVF)) {
+            error_setg(errp,
+                    "Zclsd cannot be supported together with C and F extension");
+            return;
+        }
+        if (cpu->cfg.ext_zcf) {
+            error_setg(errp,
+                    "Zclsd cannot be supported together with Zcf extension");
+            return;
+        }
+    }
+
     if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
         error_setg(errp, "zicfilp extension requires zicsr extension");
         return;
@@ -1097,6 +1110,20 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
     }
 }
 
+static void cpu_enable_zilsd_implied_rules(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+
+    if (cpu->cfg.ext_zilsd && riscv_has_ext(env, RVC)) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zclsd), true);
+    }
+
+    if (cpu->cfg.ext_zclsd) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zilsd), true);
+    }
+}
+
 static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
 {
     RISCVCPUImpliedExtsRule *rule;
@@ -1105,6 +1132,9 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
     /* Enable the implied extensions for Zc. */
     cpu_enable_zc_implied_rules(cpu);
 
+    /* Enable the implied extensions for Zilsd. */
+    cpu_enable_zilsd_implied_rules(cpu);
+
     /* Enable the implied MISAs. */
     for (i = 0; (rule = riscv_misa_ext_implied_rules[i]); i++) {
         if (riscv_has_ext(&cpu->env, rule->ext)) {
@@ -1608,6 +1638,9 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmp), false);
     isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmt), false);
 
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zilsd), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zclsd), false);
+
     if (env->misa_mxl != MXL_RV32) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
     } else {
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e1f4dc5ffd..280ce48a1e 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1216,6 +1216,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
 #include "insn_trans/trans_rvzce.c.inc"
+#include "insn_trans/trans_zilsd.c.inc"
 #include "insn_trans/trans_rvzcmop.c.inc"
 #include "insn_trans/trans_rvzicfiss.c.inc"
 
diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/insn_trans/trans_zilsd.c.inc
new file mode 100644
index 0000000000..369c33004b
--- /dev/null
+++ b/target/riscv/insn_trans/trans_zilsd.c.inc
@@ -0,0 +1,105 @@
+/*
+ * RISC-V translation routines for the Zilsd & Zclsd Extension.
+ *
+ * Copyright (c) 2025 Nucleisys, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The documentation of the ISA extensions can be found here:
+ *   https://github.com/riscv/riscv-zilsd/releases/tag/v1.0
+ */
+
+#define REQUIRE_ZILSD(ctx) do {    \
+    if (!ctx->cfg_ptr->ext_zilsd)  \
+        return false;              \
+} while (0)
+
+#define REQUIRE_ZCLSD(ctx) do {    \
+    if (!ctx->cfg_ptr->ext_zclsd)  \
+        return false;              \
+} while (0)
+
+static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
+{
+    if ((a->rd) % 2) {
+        return false;
+    }
+
+    TCGv dest_low = dest_gpr(ctx, a->rd);
+    TCGv dest_high = dest_gpr(ctx, a->rd + 1);
+    TCGv addr = get_address(ctx, a->rs1, a->imm);
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
+
+    if (a->rd == 0) {
+        return true;
+    }
+
+    tcg_gen_extr_i64_tl(dest_low, dest_high, tmp);
+
+    gen_set_gpr(ctx, a->rd, dest_low);
+    gen_set_gpr(ctx, a->rd + 1, dest_high);
+
+    return true;
+}
+
+static bool trans_zilsd_ld(DisasContext *ctx, arg_zilsd_ld *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_ZILSD(ctx);
+    return gen_load_i64(ctx, a);
+}
+
+static bool trans_zclsd_ld(DisasContext *ctx, arg_zclsd_ld *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_ZCLSD(ctx);
+    return gen_load_i64(ctx, a);
+}
+
+static bool trans_zclsd_ldsp(DisasContext *ctx, arg_zclsd_ldsp *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_ZCLSD(ctx);
+
+    if (a->rd == 0) {
+        return false;
+    }
+    return gen_load_i64(ctx, a);
+}
+
+static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
+{
+    if ((a->rs2) % 2) {
+        return false;
+    }
+
+    TCGv data_low = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data_high = get_gpr(ctx, a->rs2 + 1, EXT_NONE);
+    TCGv addr = get_address(ctx, a->rs1, a->imm);
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    if (a->rs2 == 0) {
+        tmp = tcg_constant_i64(0);
+    } else {
+        tcg_gen_concat_tl_i64(tmp, data_low, data_high);
+    }
+    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
+
+    return true;
+}
+
+static bool trans_zilsd_sd(DisasContext *ctx, arg_zilsd_sd *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_ZILSD(ctx);
+    return gen_store_i64(ctx, a);
+}
+
+static bool trans_zclsd_sd(DisasContext *ctx, arg_zclsd_sd *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_ZCLSD(ctx);
+    return gen_store_i64(ctx, a);
+}
-- 
2.52.0


