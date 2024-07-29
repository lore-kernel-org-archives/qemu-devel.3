Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC39C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZ6-0004lP-LB; Mon, 29 Jul 2024 13:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZ4-0004cC-5U
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:42 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZ1-0000Hx-QC
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:41 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fd65aaac27so20903925ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275618; x=1722880418;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iy2RtCvQM5Izk8U1ElO9Cl5d6+0t6yQiX5e7wEg0d5I=;
 b=SBLiSoXeIBP05WRWdK7K8wKCZa2CgEDaHf3p0Iqqp1EUCV2yNE6Lq7X/+vaG6Lu51d
 yazBY7oxKTmzPD8dnw4ucJ2WvD0nOy2Ieuwh905mzZF8GKAazqwP0b82ZAb6gtThKflq
 katMkYKr1F0p1+vdXL9LjbjDWQhIgBmw0gaIxlp986H95x7Loq8MHw/fD4KxRZY9jUfZ
 VAWGo2/bhy86BpXrYkW61LGG983IKBtlkJsmqtfqY9kwDQuvGOXSLhmAzLme8fAu8+k+
 Y04uIJQDOSsTBRjfLHsqj6qjBonWxXC79e89uhc0mwbZRjVayBoQvyT4YE4HPviXYLP5
 R2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275618; x=1722880418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iy2RtCvQM5Izk8U1ElO9Cl5d6+0t6yQiX5e7wEg0d5I=;
 b=fHaITwFjnWOwWC6cSduJrIfK9fBr++o/xMnKcD0tb049OoD3tel37suHCrtkKW5x1x
 KjtbDGOEFjEI60l4z98hULncBsXBBc5ZFsZ0y4LAQeWXGEoMInc+or3IFUXGXdsNeSxS
 jpNG3tWJZ3jtUjmfFD260/6usIVtpu+vbOkxLLrcKrIhPXcyb4OjecLwEwXrzBNPDlOY
 o33EKs4Rz+xyBHU3qXmXh0tvUAGIRascZrI9hJfFvFMJjaCMOfnuruUaQc8sHD8/FguT
 T21SVbvqV2gA0Sf9o3w1ayzPp0l6Yfw8M8BeSZ3MK8dMvdH2ZH8r9I5K3HLoL/s5b9ny
 sJxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXucsq0VHcRnX0TkLPp29DrEzzKW0+ARMAVwVMuGE1MXugKl/+H0ssty37HcrCNSyWu/ADBwi5UYRt/N81cHvmm++uSo9s=
X-Gm-Message-State: AOJu0YxsJTVZ8TL5+IteBgY8GdV3AL/MNiV6BASNcQdAqD92to119Cue
 gHFuQ7v5Y7ZtoKUq2B3cK0hTuKAe58QDcsY/4hZPbYIHqtD7mGdLK5FmJ1Lx+zGYsfto+PVTL0H
 v
X-Google-Smtp-Source: AGHT+IH7x9EeIVkxkPjXDWDdDQNV1xat4qEErQtfbTIhCeLJchIODCDExsUOLjqJa81vm6QtoqcshA==
X-Received: by 2002:a17:90a:ec0c:b0:2cb:5883:8fb0 with SMTP id
 98e67ed59e1d1-2cf7cf7fd03mr13233126a91.14.1722275618370; 
 Mon, 29 Jul 2024 10:53:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:38 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 06/24] target/riscv: zicfilp `lpad` impl and branch tracking
Date: Mon, 29 Jul 2024 10:53:08 -0700
Message-ID: <20240729175327.73705-7-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 target/riscv/helper.h                   |  4 ++
 target/riscv/insn32.decode              |  6 ++-
 target/riscv/insn_trans/trans_rvi.c.inc | 51 +++++++++++++++++++++++++
 target/riscv/op_helper.c                | 32 ++++++++++++++++
 5 files changed, 93 insertions(+), 1 deletion(-)

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
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 451261ce5a..ab55bbbf73 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -121,6 +121,10 @@ DEF_HELPER_2(cbo_clean_flush, void, env, tl)
 DEF_HELPER_2(cbo_inval, void, env, tl)
 DEF_HELPER_2(cbo_zero, void, env, tl)
 
+/* Forward CFI label checking */
+DEF_HELPER_2(cfi_jalr, void, env, int)
+DEF_HELPER_2(cfi_check_landing_pad, void, env, int)
+
 /* Special functions */
 DEF_HELPER_2(csrr, tl, env, int)
 DEF_HELPER_3(csrw, void, env, int, tl)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c45b8fa1d8..c963c59c8e 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -40,6 +40,7 @@
 %imm_z6   26:1 15:5
 %imm_mop5 30:1 26:2 20:2
 %imm_mop3 30:1 26:2
+%imm_cfi20 12:20
 
 # Argument sets:
 &empty
@@ -123,7 +124,10 @@ sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
-auipc    ....................       ..... 0010111 @u
+{
+  lpad     ....................       00000 0010111 %imm_cfi20
+  auipc    ....................       ..... 0010111 @u
+}
 jal      ....................       ..... 1101111 @j
 jalr     ............     ..... 000 ..... 1100111 @i
 beq      ....... .....    ..... 000 ..... 1100011 @b
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 98e3806d5e..ee868c5fcb 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -36,6 +36,44 @@ static bool trans_lui(DisasContext *ctx, arg_lui *a)
     return true;
 }
 
+static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
+{
+    /* zicfilp only supported on 32bit and 64bit */
+    if (get_xl(ctx) != MXL_RV32 && get_xl(ctx) != MXL_RV64) {
+        return false;
+    }
+
+    /* forward cfi not enabled, return false */
+    if (!ctx->fcfi_enabled) {
+        return false;
+    }
+
+    /*
+     * If this is the first instruction of the TB, let the translator
+     * know the landing pad requirement was satisfied. No need to bother
+     * checking for CFI feature or enablement.
+     */
+
+    if (ctx->base.pc_next == ctx->base.pc_first) {
+        ctx->fcfi_lp_expected = false;
+        /* PC must be 4 byte aligned */
+        if (ctx->fcfi_enabled && ((ctx->base.pc_next) & 0x3)) {
+            /*
+             * misaligned, according to spec we should raise sw check exception
+             */
+            tcg_gen_st_tl(
+                    tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                    tcg_env, offsetof(CPURISCVState, sw_check_code));
+            generate_exception(ctx, RISCV_EXCP_SW_CHECK);
+            return true;
+        }
+    }
+
+    /* use helper to do label check */
+    gen_helper_cfi_check_landing_pad(tcg_env, tcg_constant_i32(a->imm_cfi20));
+    return true;
+}
+
 static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
 {
     TCGv target_pc = dest_gpr(ctx, a->rd);
@@ -75,6 +113,19 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
     gen_set_gpr(ctx, a->rd, succ_pc);
 
     tcg_gen_mov_tl(cpu_pc, target_pc);
+    if (ctx->cfg_ptr->ext_zicfilp) {
+        /*
+         * Rely on a helper to check the forward CFI enable for the
+         * current process mode. The alternatives would be (1) include
+         * "fcfi enabled" in the cflags or (2) maintain a "fcfi
+         * currently enabled" in tcg_env and emit TCG code to access
+         * and test it.
+         */
+        if (a->rs1 != xRA && a->rs1 != xT0 && a->rs1 != xT2) {
+            gen_helper_cfi_jalr(tcg_env, tcg_constant_i32(LP_EXPECTED));
+        }
+    }
+
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 488116cc2e..2d152f0a00 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -259,6 +259,38 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
     /* We don't emulate the cache-hierarchy, so we're done. */
 }
 
+void helper_cfi_jalr(CPURISCVState *env, int elp)
+{
+    /*
+     * The translation routine doesn't know if forward CFI is enabled
+     * in the current processor mode or not. It's not worth burning a
+     * cflags bit to encode this, or tracking the current-mode-fcfi
+     * enable in a dedicated member of 'env'. Just come out to a helper
+     * for jump/call on a core with CFI.
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = elp;
+    }
+}
+
+void helper_cfi_check_landing_pad(CPURISCVState *env, int lbl)
+{
+    if ((env->elp == LP_EXPECTED) && cpu_get_fcfien(env)) {
+        /*
+         * Check for the 20bit label match. We already checked 4 byte
+         * alignment in tcg
+         * High 20bits (b31:12) in x7/t2 hold label. We need drop bits
+         * greater than 31 and then shift 12 right
+         */
+        if (lbl && (lbl != ((env->gpr[xT2] & 0xFFFFFFFF) >> 12))) {
+            env->sw_check_code = RISCV_EXCP_SW_CHECK_FCFI_TVAL;
+            riscv_raise_exception(env, RISCV_EXCP_SW_CHECK, GETPC());
+        }
+
+        env->elp = NO_LP_EXPECTED;
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 
 target_ulong helper_sret(CPURISCVState *env)
-- 
2.44.0


