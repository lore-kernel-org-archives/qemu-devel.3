Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FA1C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbi-0005il-D9; Wed, 17 Jul 2024 22:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbZ-0005Vs-HD
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:51 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbX-0003PE-AR
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70aec66c936so230594b3a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268645; x=1721873445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbcGfVlcPRccLSn7cW2XGxYbsQ71fb9UaUPwLrj6Rew=;
 b=NmQ49BesJc5mfzMT/BXKDuEkC6JaGVTL8RrtnF2Y/whMl4fpYZKI8pkY9Tl7fI24zx
 tk+8/AB5CHDrwIFhghCdh9N7srhdvkm9zBFtJEgHbM4psWXXtMTL8t8m5RsoqmnVJ+Y4
 Dh/fzMzAvWQSqACWRpxRfGfe9AP//GQyhsi+BPbzbNWf1wXrpWZYwq2v/R3+YbN/EP9f
 KkV8p5rxNWEI3cwZUR11eC97JvN5pPYKjmOArPYCFTJnvKZ3sUVuEDErUhbq4TBbml12
 rHZa7ygbfuPpisOk6m7TxrfIq3/eZa9duJFyxx6CRjE8oaNANktrWvTDN6Tzqrzi1YCM
 pC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268645; x=1721873445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VbcGfVlcPRccLSn7cW2XGxYbsQ71fb9UaUPwLrj6Rew=;
 b=sY83pm2g/8XvojOUwaRziwePh2Xla6jFLfh/HBHGFLwIba+QVYlMVSGKxLcrOQuUT6
 HwejHO5whLeVDTmsmU+1KSYOsYq8IBlishLXlgnJ429tYRGc/3Al+XH50zEA6GzJuXj6
 z3SGyQfyS0qP2vBEvJArrXg5XOsG1lI8E9vpXElZj1JODsCcHYZRUsT2st9X5BXAlX0T
 0AEVbqgNrBaMG41OSgutLrxRFeQAEbzXvvVSijXAghTMSOdWTLuXTAknW3+TbriO5IV9
 aPWwwEfWjmP8W8GX0QmfXZ35lI/BBsp3M41nOEjEKVJWmIvJ34Oye7ZduAvvOuH93BHX
 9d8A==
X-Gm-Message-State: AOJu0YzjfWOwVguYyv9VDNcnO1ih8SS9jqfElDdQkNKUBOLRhGINEaAj
 Q7bfoIYN8fBdPnr1T7xjNzkwHaGBVRw/EzI5p/RdGEF3pd/eqf45yfSdKP/v
X-Google-Smtp-Source: AGHT+IFmOXxiSL1X/WCh6uRJp8RSkKboVafbohR81AtrcaldDXsu51Capm/1TwJNgtdZkMArql9GBA==
X-Received: by 2002:a05:6a20:258d:b0:1be:c753:dc65 with SMTP id
 adf61e73a8af0-1c3fdc976camr4593963637.18.1721268645539; 
 Wed, 17 Jul 2024 19:10:45 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:10:45 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/30] target/riscv: Add AMO instructions for Zabha
Date: Thu, 18 Jul 2024 12:09:49 +1000
Message-ID: <20240718021012.2057986-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240709113652.1239-8-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                      |   1 +
 target/riscv/insn32.decode                  |  20 +++
 target/riscv/translate.c                    |   4 +-
 target/riscv/insn_trans/trans_rvzabha.c.inc | 131 ++++++++++++++++++++
 4 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzabha.c.inc

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index ddbfae37e5..120905a254 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -84,6 +84,7 @@ struct RISCVCPUConfig {
     bool ext_zaamo;
     bool ext_zacas;
     bool ext_zama16b;
+    bool ext_zabha;
     bool ext_zalrsc;
     bool ext_zawrs;
     bool ext_zfa;
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 60da673153..3bad6372f2 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1021,3 +1021,23 @@ amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
 # *** Zimop may-be-operation extension ***
 mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
 mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
+
+# *** Zabhb Standard Extension ***
+amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
+amoadd_b   00000 . . ..... ..... 000 ..... 0101111 @atom_st
+amoxor_b   00100 . . ..... ..... 000 ..... 0101111 @atom_st
+amoand_b   01100 . . ..... ..... 000 ..... 0101111 @atom_st
+amoor_b    01000 . . ..... ..... 000 ..... 0101111 @atom_st
+amomin_b   10000 . . ..... ..... 000 ..... 0101111 @atom_st
+amomax_b   10100 . . ..... ..... 000 ..... 0101111 @atom_st
+amominu_b  11000 . . ..... ..... 000 ..... 0101111 @atom_st
+amomaxu_b  11100 . . ..... ..... 000 ..... 0101111 @atom_st
+amoswap_h  00001 . . ..... ..... 001 ..... 0101111 @atom_st
+amoadd_h   00000 . . ..... ..... 001 ..... 0101111 @atom_st
+amoxor_h   00100 . . ..... ..... 001 ..... 0101111 @atom_st
+amoand_h   01100 . . ..... ..... 001 ..... 0101111 @atom_st
+amoor_h    01000 . . ..... ..... 001 ..... 0101111 @atom_st
+amomin_h   10000 . . ..... ..... 001 ..... 0101111 @atom_st
+amomax_h   10100 . . ..... ..... 001 ..... 0101111 @atom_st
+amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
+amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 133550d6e2..4a3e786560 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1083,8 +1083,9 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
 {
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    MemOp size = mop & MO_SIZE;
 
-    if (ctx->cfg_ptr->ext_zama16b) {
+    if (ctx->cfg_ptr->ext_zama16b && size >= MO_32) {
         mop |= MO_ATOM_WITHIN16;
     } else {
         mop |= MO_ALIGN;
@@ -1118,6 +1119,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvb.c.inc"
 #include "insn_trans/trans_rvzicond.c.inc"
 #include "insn_trans/trans_rvzacas.c.inc"
+#include "insn_trans/trans_rvzabha.c.inc"
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
 #include "insn_trans/trans_rvzimop.c.inc"
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/insn_trans/trans_rvzabha.c.inc
new file mode 100644
index 0000000000..9093a1cfc1
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
@@ -0,0 +1,131 @@
+/*
+ * RISC-V translation routines for the Zabha Standard Extension.
+ *
+ * Copyright (c) 2024 Alibaba Group
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
+#define REQUIRE_ZABHA(ctx) do {           \
+    if (!ctx->cfg_ptr->ext_zabha) {       \
+        return false;                     \
+    }                                     \
+} while (0)
+
+static bool trans_amoswap_b(DisasContext *ctx, arg_amoswap_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SB);
+}
+
+static bool trans_amoadd_b(DisasContext *ctx, arg_amoadd_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SB);
+}
+
+static bool trans_amoxor_b(DisasContext *ctx, arg_amoxor_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SB);
+}
+
+static bool trans_amoand_b(DisasContext *ctx, arg_amoand_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SB);
+}
+
+static bool trans_amoor_b(DisasContext *ctx, arg_amoor_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SB);
+}
+
+static bool trans_amomin_b(DisasContext *ctx, arg_amomin_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SB);
+}
+
+static bool trans_amomax_b(DisasContext *ctx, arg_amomax_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SB);
+}
+
+static bool trans_amominu_b(DisasContext *ctx, arg_amominu_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SB);
+}
+
+static bool trans_amomaxu_b(DisasContext *ctx, arg_amomaxu_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SB);
+}
+
+static bool trans_amoswap_h(DisasContext *ctx, arg_amoswap_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESW);
+}
+
+static bool trans_amoadd_h(DisasContext *ctx, arg_amoadd_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TESW);
+}
+
+static bool trans_amoxor_h(DisasContext *ctx, arg_amoxor_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TESW);
+}
+
+static bool trans_amoand_h(DisasContext *ctx, arg_amoand_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TESW);
+}
+
+static bool trans_amoor_h(DisasContext *ctx, arg_amoor_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TESW);
+}
+
+static bool trans_amomin_h(DisasContext *ctx, arg_amomin_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TESW);
+}
+
+static bool trans_amomax_h(DisasContext *ctx, arg_amomax_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TESW);
+}
+
+static bool trans_amominu_h(DisasContext *ctx, arg_amominu_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TESW);
+}
+
+static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESW);
+}
-- 
2.45.2


