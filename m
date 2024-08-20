Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592FEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCKf-00023q-Gn; Mon, 19 Aug 2024 20:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCKH-0000pZ-54
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:18 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCK1-0001DB-81
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:08 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-202146e93f6so33532805ad.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 17:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724112104; x=1724716904;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sUdGw331BtOtsxAQevJumdwhpuJIG1zb3MyTH0Y1bkQ=;
 b=XvZEto2ZNmJ8d66g4Gr8BXWoZF22GJJZivIY5lbzxRJFDhTetM1TEP7V5C1sxRo/eG
 9hrmuXwfuvPy3B0GNmi8X5yVtZDzKxySz9+elSt3JEnocfz2ZBTzwWIvi1OnoC7yeV1s
 OXuDvEqzqKZFJ1ZyCQDANyxaoZo8sV3FBJprz501hnWxbHBLmpAs6PF8xTemOnM+qfxb
 /VwOBrxqy7JHJyeFqspPyYWsgSdPDHu0DdLnnSIs2DaEWoxoOrlhpflLiGSCFfRzOpOA
 pp9PrARnxXUkFNaZedB8AuMbF4daxkf/sazaAVCs4DHGHZl4lIf0vCFP5W12+7R/1JTa
 itcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724112104; x=1724716904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sUdGw331BtOtsxAQevJumdwhpuJIG1zb3MyTH0Y1bkQ=;
 b=T449Phx5Df23hAXIfF3TT9MpukLeN6Xg5LI6Ltqmg9Zqcx4+x9ZyvzBbW34s84qJ33
 hl/+yxiHsmGzqSUhbPWXm++1bTXs8CBVuUmkvEV88bOvCGFrVJL3rbVXPcyZdgmr7vzi
 18d5tP+wRQGSgZZuT0pcDtw5o+QQT31yiP+NfwPmSNdRZDXBpsD+bCcEkC7tiG5NC9Oe
 VS+SCGFn467be9W4iQMG7o3c6Nu9tQ/ASEk/bFj8pzR3ometpJKinzHaFxK2Kuw4N90C
 GTtLoqQJWoTFw5TcKm9pJYEqlHAqgVk73B6kpFOfUIaSWFdyVN3p2oeZDNx8L2sIaVen
 o7iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZyL+LdvZG8Q/Wxhv+qXfSewaPEGYe1cV4gH0tGadIIkZqH3x25i3jJzB8lfMeRd7oSrkF4N4foNUjB+dP4d5EvOaDc6Y=
X-Gm-Message-State: AOJu0Yxn8GaLmydAT1/4jAcZOf09CHO+YpAbp1D71xf2D1lld1uTXNE0
 LHJaCxdMeWmI/l1qxHuN2spDIt2ZHvAYjVOPOV/4CAZI0Zc0IoOa5Oepu1cdkt0=
X-Google-Smtp-Source: AGHT+IE6OR5IsL4tpfpcwFcQ7Xbj+L3DV7InDTzboaNYeGesvRFUcqjfjnaTj5W3DyBCOdNUn73+Rg==
X-Received: by 2002:a17:902:c409:b0:1ff:393d:5e56 with SMTP id
 d9443c01a7336-20203ec574amr118154375ad.36.1724112102658; 
 Mon, 19 Aug 2024 17:01:42 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a779sm67477445ad.188.2024.08.19.17.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:01:42 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v5 06/15] target/riscv: zicfilp `lpad` impl and branch tracking
Date: Mon, 19 Aug 2024 17:01:20 -0700
Message-ID: <20240820000129.3522346-7-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240820000129.3522346-1-debug@rivosinc.com>
References: <20240820000129.3522346-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Implements setting lp expected when `jalr` is encountered and implements
`lpad` instruction of zicfilp. `lpad` instruction is taken out of
auipc x0, <imm_20>. This is an existing HINTNOP space. If `lpad` is
target of an indirect branch, cpu checks for 20 bit value in x7 upper
with 20 bit value embedded in `lpad`. If they don't match, cpu raises a
sw check exception with tval = 2.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu_user.h                 |  1 +
 target/riscv/insn32.decode              |  5 ++-
 target/riscv/insn_trans/trans_rvi.c.inc | 55 +++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_user.h b/target/riscv/cpu_user.h
index 02afad608b..e6927ff847 100644
--- a/target/riscv/cpu_user.h
+++ b/target/riscv/cpu_user.h
@@ -15,5 +15,6 @@
 #define xA6 16
 #define xA7 17  /* syscall number for RVI ABI */
 #define xT0 5   /* syscall number for RVE ABI */
+#define xT2 7
 
 #endif
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c45b8fa1d8..6533cb0758 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -123,7 +123,10 @@ sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
-auipc    ....................       ..... 0010111 @u
+{
+  lpad     label:20                   00000 0010111
+  auipc    ....................       ..... 0010111 @u
+}
 jal      ....................       ..... 1101111 @j
 jalr     ............     ..... 000 ..... 1100111 @i
 beq      ....... .....    ..... 000 ..... 1100011 @b
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 98e3806d5e..b427f3a939 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -36,6 +36,49 @@ static bool trans_lui(DisasContext *ctx, arg_lui *a)
     return true;
 }
 
+static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
+{
+    /*
+     * fcfi_lp_expected can set only if fcfi was eanbled.
+     * translate further only if fcfi_lp_expected set.
+     * lpad comes from NOP space anyways, so return true if
+     * fcfi_lp_expected is false.
+     */
+    if (!ctx->fcfi_lp_expected) {
+        return true;
+    }
+
+    ctx->fcfi_lp_expected = false;
+    if ((ctx->base.pc_next) & 0x3) {
+        /*
+         * misaligned, according to spec we should raise sw check exception
+         */
+        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                      tcg_env, offsetof(CPURISCVState, sw_check_code));
+        gen_helper_raise_exception(tcg_env,
+                      tcg_constant_i32(RISCV_EXCP_SW_CHECK));
+        return true;
+    }
+
+    /* per spec, label check performed only when embedded label non-zero */
+    if (a->label != 0) {
+        TCGLabel *skip = gen_new_label();
+        TCGv tmp = tcg_temp_new();
+        tcg_gen_extract_tl(tmp, get_gpr(ctx, xT2, EXT_NONE), 12, 20);
+        tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->label, skip);
+        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                      tcg_env, offsetof(CPURISCVState, sw_check_code));
+        gen_helper_raise_exception(tcg_env,
+                      tcg_constant_i32(RISCV_EXCP_SW_CHECK));
+        gen_set_label(skip);
+    }
+
+    tcg_gen_st8_tl(tcg_constant_tl(0), tcg_env,
+                  offsetof(CPURISCVState, elp));
+
+    return true;
+}
+
 static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
 {
     TCGv target_pc = dest_gpr(ctx, a->rd);
@@ -75,6 +118,18 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
     gen_set_gpr(ctx, a->rd, succ_pc);
 
     tcg_gen_mov_tl(cpu_pc, target_pc);
+    if (ctx->fcfi_enabled) {
+        /*
+         * return from functions (i.e. rs1 == xRA || rs1 == xT0) are not
+         * tracked. zicfilp introduces sw guarded branch as well. sw guarded
+         * branch are not tracked. rs1 == xT2 is a sw guarded branch.
+         */
+        if (a->rs1 != xRA && a->rs1 != xT0 && a->rs1 != xT2) {
+            tcg_gen_st8_tl(tcg_constant_tl(1),
+                          tcg_env, offsetof(CPURISCVState, elp));
+        }
+    }
+
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
-- 
2.44.0


