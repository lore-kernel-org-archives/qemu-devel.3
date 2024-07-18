Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823BBC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbO-00057W-89; Wed, 17 Jul 2024 22:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbK-0004yV-Uf
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:35 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbG-0003I4-Hg
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:34 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fb53bfb6easo2586225ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268628; x=1721873428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8atclyC9Wk54it5NIbF2OB8aNolkdVJ9kvxN5/8lZw=;
 b=dDkQjedKzX0vtJy211XZDbxTnhHsW/7LidHvynHknOlwx1VNV4HSiNfKyz/4obfSsD
 OPWq/OhqyKTW+UtJKLSa+lDCrGV4oOzOD5kNlxQe0gtGNHS98aW6AiGBP9h4n09f8VBT
 VcwKnTGZjL6GvnyJ0Blu0vZ2QR5IAAVm48oATtF2plMAnSV1sd/mVGsNymltH3G2W8Tb
 6KJnXSq5Ko3AVAGzheL4FlKaAcWMSkzl6vRmeF2j0PrkoPgIbWN/w5ROAr8JEaQQwH1m
 Mevo/wTOnncd3cYcU63wQkBeYiA+PmVItjBGg5isOHRgFyKN1G0h08TMsrdWLaLdz3M9
 ryaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268628; x=1721873428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8atclyC9Wk54it5NIbF2OB8aNolkdVJ9kvxN5/8lZw=;
 b=kjZ2psk+9lr+E094Z2IXSmwb8hFa6Yg8eaisozU/B3VmlnQAcy8noo0GOujDcMM1uI
 eBsmjf0XJqFSWb1gZh1U2GxY5DPGqfJ+0jY09ozPN20OX5KQFZH86EnoZnQ4Y39DCWok
 eKMFdkJ0uvMKv36HHvAYHPywE1PJCDLX3gsrWpspgVjewRj9Sk4/pLNiBFfzV8nhNhDp
 3OD5fgeU/3zUyE4mqohdkuBMyowOXH7/SlUk3pPwgvr0tQtCw+2F5gPlL8lI1fwbE95H
 7xmv/9BzwQx2kTmA8KTp+b+P5MMkq+8W64AifW1npZSu2mnDtg0/PfAxZtSiewOJr/Ob
 4T+w==
X-Gm-Message-State: AOJu0Yw5/dGmu5PIbdn0OCtYvZl9xQuv7MpXe6vhK3hqV2pEQugm13bu
 oEypV8iA+M8Ft5tVygK6wis42KjwBO9fWVWOL9Li6OGkw9HkHGMI0TkXrqxe
X-Google-Smtp-Source: AGHT+IGKEzq2Du2dDW1pbrLDL7xxeW7hhJR7Rq9UwhVzW+8FWr2suYFadNrImhYEHFua9Lxw+b1bcQ==
X-Received: by 2002:a17:902:f68d:b0:1fc:4b33:2d24 with SMTP id
 d9443c01a7336-1fc4e68a8cdmr30986795ad.52.1721268628064; 
 Wed, 17 Jul 2024 19:10:28 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:10:27 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PULL 01/30] target/riscv: Add zimop extension
Date: Thu, 18 Jul 2024 12:09:43 +1000
Message-ID: <20240718021012.2057986-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zimop extension defines an encoding space for 40 MOPs.The Zimop
extension defines 32 MOP instructions named MOP.R.n, where n is
an integer between 0 and 31, inclusive. The Zimop extension
additionally defines 8 MOP instructions named MOP.RR.n, where n
is an integer between 0 and 7.

These 40 MOPs initially are defined to simply write zero to x[rd],
but are designed to be redefined by later extensions to perform some
other action.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Message-ID: <20240709113652.1239-2-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                      |  1 +
 target/riscv/insn32.decode                  | 11 ++++++
 target/riscv/cpu.c                          |  2 ++
 target/riscv/translate.c                    |  1 +
 target/riscv/insn_trans/trans_rvzimop.c.inc | 37 +++++++++++++++++++++
 5 files changed, 52 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzimop.c.inc

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index fb7eebde52..9f53512053 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -71,6 +71,7 @@ struct RISCVCPUConfig {
     bool ext_zihintntl;
     bool ext_zihintpause;
     bool ext_zihpm;
+    bool ext_zimop;
     bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f22df04cfd..60da673153 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -38,6 +38,8 @@
 %imm_bs   30:2                   !function=ex_shift_3
 %imm_rnum 20:4
 %imm_z6   26:1 15:5
+%imm_mop5 30:1 26:2 20:2
+%imm_mop3 30:1 26:2
 
 # Argument sets:
 &empty
@@ -56,6 +58,8 @@
 &r2nfvm    vm rd rs1 nf
 &rnfvm     vm rd rs1 rs2 nf
 &k_aes     shamt rs2 rs1 rd
+&mop5 imm rd rs1
+&mop3 imm rd rs1 rs2
 
 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
@@ -98,6 +102,9 @@
 @k_aes   .. ..... ..... .....  ... ..... ....... &k_aes  shamt=%imm_bs   %rs2 %rs1 %rd
 @i_aes   .. ..... ..... .....  ... ..... ....... &i      imm=%imm_rnum        %rs1 %rd
 
+@mop5 . . .. .. .... .. ..... ... ..... ....... &mop5 imm=%imm_mop5 %rd %rs1
+@mop3 . . .. .. . ..... ..... ... ..... ....... &mop3 imm=%imm_mop3 %rd %rs1 %rs2
+
 # Formats 64:
 @sh5     .......  ..... .....  ... ..... ....... &shift  shamt=%sh5      %rs1 %rd
 
@@ -1010,3 +1017,7 @@ amocas_w    00101 . . ..... ..... 010 ..... 0101111 @atom_st
 amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
 # *** RV64 Zacas Standard Extension ***
 amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
+
+# *** Zimop may-be-operation extension ***
+mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
+mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c53b0d5b40..ac503826ce 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -113,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
+    ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
@@ -1471,6 +1472,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
+    MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
     MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
     MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
     MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0569224e53..379b68289f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1099,6 +1099,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvzacas.c.inc"
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
+#include "insn_trans/trans_rvzimop.c.inc"
 #include "insn_trans/trans_rvzfa.c.inc"
 #include "insn_trans/trans_rvzfh.c.inc"
 #include "insn_trans/trans_rvk.c.inc"
diff --git a/target/riscv/insn_trans/trans_rvzimop.c.inc b/target/riscv/insn_trans/trans_rvzimop.c.inc
new file mode 100644
index 0000000000..165aacd2b6
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzimop.c.inc
@@ -0,0 +1,37 @@
+/*
+ * RISC-V translation routines for May-Be-Operation(zimop).
+ *
+ * Copyright (c) 2024 Alibaba Group.
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
+#define REQUIRE_ZIMOP(ctx) do {           \
+    if (!ctx->cfg_ptr->ext_zimop) {       \
+        return false;                     \
+    }                                     \
+} while (0)
+
+static bool trans_mop_r_n(DisasContext *ctx, arg_mop_r_n *a)
+{
+    REQUIRE_ZIMOP(ctx);
+    gen_set_gpr(ctx, a->rd, ctx->zero);
+    return true;
+}
+
+static bool trans_mop_rr_n(DisasContext *ctx, arg_mop_rr_n *a)
+{
+    REQUIRE_ZIMOP(ctx);
+    gen_set_gpr(ctx, a->rd, ctx->zero);
+    return true;
+}
-- 
2.45.2


