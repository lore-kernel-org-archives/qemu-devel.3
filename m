Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4461DD232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RG-0005wK-LB; Fri, 09 Jan 2026 01:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Q5-0004q1-3D
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:28 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Q2-0002tO-Qg
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:24 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so2435280b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941781; x=1768546581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OGp2STDkhe7ThW6Dm/4DOuMnh+2aTViHI4xdpXEzOs=;
 b=m8LTQt675IDaXEtQFkE3VbtM7JsJlGjXTZIDP3buD33QgezJsP1Ltq3aiX+rsEBb6K
 tIr/smlZ9S6j2Ta/14VyUgEa855HNbqoq0F8P1aoIGKHwqvoBzjmAVIMNgkenBr1CriD
 /0kl74RQcWxK4ghGqnz/etMHYj6aZoEJtK4mvGP67MPz2w1H78SH1GFYE0H7nmPVkQHb
 tcCtfrDeojS85n9UMQQ4x/f7sjNm6B9XS8HTSFakZtAVLLtCJI+Rl7pWRi8j98TW/MkD
 zakdw/oatvj4XbSwaTelNNYrWsaBrmFsW6uhp6RGxrXyNC5XqauxVfU4Apa1Uivt2v6d
 hPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941781; x=1768546581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8OGp2STDkhe7ThW6Dm/4DOuMnh+2aTViHI4xdpXEzOs=;
 b=HWbJfU2YPMcI7GjDaqsyqvMw7SRPjbJ7BObhCD7LbqLvM+JKiMsSP62gxuelrzKK6S
 4WXwsyKgR5Rjxc3/RFFMRpdxvju13hEpsi9UeUpnQmAsTQYuUlCagVfyphm9AAYJttZV
 5iKBTeT1eByLPZ0jingNGCMcDREp99w/WcTyB1zYpeqKt6rQXs+kvr+zXtiLinpEYHdo
 PwxC9g3FmFCrwPhhbMclps5wb0e93a5gGx1Sp5OBU6usEd9R00uDecRveJhSJ2cSdELS
 h8Z2Lv0Xjzuk70FIj/mkIHO1MQbZVqDSnY7s3zvL8Y1j1SBLBDPfDtbkurLC4vsqFIBi
 yicA==
X-Gm-Message-State: AOJu0YyVSz/JUSjbYFimbBucqsFqqxsK78mWQGpPtlAgwgfGh0Gt7NiE
 U0VOMa91yD4XRTZJr8/7FP1IFC1i+W3kB/HpnMu2Fuv8Uc+b/b5qCbjZDN3p4Q==
X-Gm-Gg: AY/fxX6xPD1tOdspoBPn76CKH0uYItkuJ6gyZ9oorKpdyBp9KJuH6j0noBYi96qonMk
 sUoQ3Yn+qe3npJ4BTU+yQsZ8Oq5lX79qobyELxRPvqEbjzON3jpvDibsrvPyeQi7xsXWu/Ze60N
 ihnqTvDLuU9PB3o2DHRK6iqsulHmF1JTFO4u0XomGtIMCu0qshqg8TgxapBWBcI4OjgwgJhxIjh
 an2xTi47Mdp5N+JwM6nz7dZeqvwG1IxpukM1nktr9+vrBssxiPYp+WI6IGKzbj+5i/AwVYmt7mA
 0G9D4tISE9Ij3JACzLAjG+FvTXxK7ClGnWRwM5O/4HBYuQeCi5bQDwsTha3ItoAqmkvrn01M0Lo
 iA/aSED7RX7R+Im+bs4Wak2IqNXlILTvQzTC67pVE8Sa/H/z+NAJ3tDl3t1Z9WKtWSYzA9wqfG2
 amjSXh6SKPlyfxfAKML2SrrOg8u29Bl97TmuMakyjbfoBSVD73sxqKsmw7m1pOSESKI9ECQDUxE
 FwgW10ApGax9eOQfAo=
X-Google-Smtp-Source: AGHT+IHtFcAcWLqxxC7kCJuVp2/Wjk6TrRkJr5EGjYkQRrRnAkiMY0AZtJHsAHQAEZvenFbFftkGHw==
X-Received: by 2002:a05:6a21:3291:b0:35f:5fc4:d896 with SMTP id
 adf61e73a8af0-3898f906a35mr8158582637.20.1767941780856; 
 Thu, 08 Jan 2026 22:56:20 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:20 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Roan Richmond <roan.richmond@codethink.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/34] Add RISCV ZALASR extension
Date: Fri,  9 Jan 2026 16:54:47 +1000
Message-ID: <20260109065459.19987-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Roan Richmond <roan.richmond@codethink.co.uk>

This is based on version v0.9 of the ZALASR specification [1].
The specification is listed as in Ratified state [2].

[1]: https://github.com/riscv/riscv-zalasr/tree/v0.9
[2]: https://lf-riscv.atlassian.net/wiki/spaces/HOME/pages/16154882/All+RISC-V+Specifications+Under+Active+Development

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
Message-ID: <20251112162923.311714-1-roan.richmond@codethink.co.uk>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg_fields.h.inc            |   1 +
 target/riscv/insn32.decode                   |  10 ++
 target/riscv/cpu.c                           |   2 +
 target/riscv/translate.c                     |   1 +
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 113 +++++++++++++++++++
 5 files changed, 127 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 0a12ccd6cd..f4ff4f3f96 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -67,6 +67,7 @@ BOOL_FIELD(ext_zaamo)
 BOOL_FIELD(ext_zacas)
 BOOL_FIELD(ext_zama16b)
 BOOL_FIELD(ext_zabha)
+BOOL_FIELD(ext_zalasr)
 BOOL_FIELD(ext_zalrsc)
 BOOL_FIELD(ext_zawrs)
 BOOL_FIELD(ext_zfa)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b341832e41..6e35c4b1e6 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1074,3 +1074,13 @@ amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
 amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
 amocas_b    00101 . . ..... ..... 000 ..... 0101111 @atom_st
 amocas_h    00101 . . ..... ..... 001 ..... 0101111 @atom_st
+
+# *** Zalasr Standard Extension ***
+lb_aqrl  00110 . . ..... ..... 000 ..... 0101111 @atom_st
+lh_aqrl  00110 . . ..... ..... 001 ..... 0101111 @atom_st
+lw_aqrl  00110 . . ..... ..... 010 ..... 0101111 @atom_st
+ld_aqrl  00110 . . ..... ..... 011 ..... 0101111 @atom_st
+sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
+sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
+sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
+sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d48ff50232..f22b504772 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -128,6 +128,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
+    ISA_EXT_DATA_ENTRY(zalasr, PRIV_VERSION_1_12_0, ext_zalasr),
     ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
     ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
@@ -1230,6 +1231,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zama16b", ext_zama16b, false),
     MULTI_EXT_CFG_BOOL("zabha", ext_zabha, false),
     MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
+    MULTI_EXT_CFG_BOOL("zalasr", ext_zalasr, false),
     MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
     MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
     MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 280ce48a1e..0d61420b46 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1199,6 +1199,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvzicond.c.inc"
 #include "insn_trans/trans_rvzacas.c.inc"
 #include "insn_trans/trans_rvzabha.c.inc"
+#include "insn_trans/trans_rvzalasr.c.inc"
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
 #include "insn_trans/trans_rvzimop.c.inc"
diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/insn_trans/trans_rvzalasr.c.inc
new file mode 100644
index 0000000000..bf86805cef
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
@@ -0,0 +1,113 @@
+/*
+ * RISC-V translation routines for the ZALASR (Load-Aquire and Store-Release)
+ * Extension.
+ *
+ * Copyright (c) 2025 Roan Richmond, roan.richmond@codethink.co.uk
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The documentation of the ISA extension can be found here:
+ *   https://github.com/riscv/riscv-zalasr/tree/v0.9
+ */
+
+#define REQUIRE_ZALASR(ctx) do {     \
+    if (!ctx->cfg_ptr->ext_zalasr) { \
+        return false;                \
+    }                                \
+} while (0)
+
+static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp memop)
+{
+    decode_save_opc(ctx, 0);
+
+    TCGv addr = get_address(ctx, a->rs1, 0);
+    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGBar bar = (a->rl) ? TCG_BAR_STRL : 0;
+
+    /* Check that AQ is set, as this is mandatory */
+    if (!a->aq) {
+        return false;
+    }
+
+    memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
+
+    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
+    gen_set_gpr(ctx, a->rd, dest);
+
+    /* Add a memory barrier implied by AQ (mandatory) and RL (optional) */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ | bar);
+
+    return true;
+}
+
+static bool trans_lb_aqrl(DisasContext *ctx, arg_lb_aqrl *a)
+{
+    REQUIRE_ZALASR(ctx);
+    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_SB));
+}
+
+static bool trans_lh_aqrl(DisasContext *ctx, arg_lh_aqrl *a)
+{
+    REQUIRE_ZALASR(ctx);
+    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_lw_aqrl(DisasContext *ctx, arg_lw_aqrl *a)
+{
+    REQUIRE_ZALASR(ctx);
+    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_ld_aqrl(DisasContext *ctx, arg_ld_aqrl *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_ZALASR(ctx);
+    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TEUQ));
+}
+
+static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
+{
+    decode_save_opc(ctx, 0);
+
+    TCGv addr = get_address(ctx, a->rs1, 0);
+    TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGBar bar = (a->aq) ? TCG_BAR_LDAQ : 0;
+
+    /* Check that RL is set, as this is mandatory */
+    if (!a->rl) {
+        return false;
+    }
+
+    memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
+
+    /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL | bar);
+
+    tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
+    return true;
+}
+
+static bool trans_sb_aqrl(DisasContext *ctx, arg_sb_aqrl *a)
+{
+    REQUIRE_ZALASR(ctx);
+    return gen_store_release(ctx, a, (MO_ALIGN | MO_SB));
+}
+
+static bool trans_sh_aqrl(DisasContext *ctx, arg_sh_aqrl *a)
+{
+    REQUIRE_ZALASR(ctx);
+    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_sw_aqrl(DisasContext *ctx, arg_sw_aqrl *a)
+{
+    REQUIRE_ZALASR(ctx);
+    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_sd_aqrl(DisasContext *ctx, arg_sd_aqrl *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_ZALASR(ctx);
+    return gen_store_release(ctx, a, (MO_ALIGN | MO_TEUQ));
+}
-- 
2.52.0


