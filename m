Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B87C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 01:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRK-0001D1-Po; Thu, 15 Aug 2024 21:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRC-0000qw-M3
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:32 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selR8-0002Jx-Pm
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:29 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d28023accso1234890b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770445; x=1724375245;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qQqMw29kr8RRcWwDfcCzlSvT+m1hv7vDf+V1pVMjGo=;
 b=G10KBHNtUlnmu7pGZKJZN63OVfEm62cSLsCB1vwuo8BnkihX51HbhHfyBTkon76dVZ
 356/pSPet8/M38lSiUsGTOsymwl0pP1e/HwQObLJbPToqGUUejS66RtgsBOSF4KrB/7m
 bW1Qnmid2LFSuDj1t+CihlR0z0jd8qmq6vXwa5QeRcyechd7tihcpOZ8LlsImF2YRXR1
 H14QDj2M70OKpmKgNT+wZamXHth02KmaHuKN6tq2R0nkJ30dF74rtHO0ve0axuaucKbn
 MjrK9GkntZPIz4rkUvG6x0+AZet9VRsZJzNcAh8Is5zNF/N6QPYOjrJguEuellz4eI9/
 YGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770445; x=1724375245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3qQqMw29kr8RRcWwDfcCzlSvT+m1hv7vDf+V1pVMjGo=;
 b=kafiOI9OI4aD4czGVG904zuZ+AmR3fIkVfSp9TqGSUSD493Ku79VNM8avVUg/gAa2L
 Lc90rFp+3qTDyIV6LzfXglQcK7WUbr7TXAN3tdB/UFbGlxL92NbMwfbc7/5E9XIvvLIe
 YAivezUgirLQEgPjZ7xoZS/HYFxp27TB2IW4iwom+Aa2xv3J0svvH/GL/yUookiqKxCg
 aPv0v8YzVxTLg2uFpl9nPkQ45iYDnkpsDjh/PVo7DQfB6nsXlRYpRj0Vr5+8+/9dNVXj
 kF8pd6G4GkqFjEuH3NmW2S+6HFc93czhCQxTcWupBCviACZD9PaSOBZaKpws8NUKGJfk
 L1WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsqFGy+mojlAN86FPw6T/gnS51tMcMmidrC6HW9bJbhnCZ1iVvbxciP2iRcLbnOZBowetMnsXk1rQItAFdUg9ea3gpoG4=
X-Gm-Message-State: AOJu0YzkMJrV5zhXwaXX7SZPq+ZoEF3g7cSmrmQ65dqrRiTTfaDRX1j0
 l6RWZyaLHRaCbVRT1Ry32sqPDECUl/TGsLBJhtKkYgvMoFBtew8Y8kvD9vQySV0=
X-Google-Smtp-Source: AGHT+IEc1WTFQvgO1navmol9XWIzbisd9Dq7qsV97VGoMXvYDVo9kC0X4LYXCoB1lp+HAWZFk9Umjw==
X-Received: by 2002:a05:6a00:189d:b0:70d:2455:1743 with SMTP id
 d2e1a72fcca58-713c528b93emr1391886b3a.29.1723770445284; 
 Thu, 15 Aug 2024 18:07:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:24 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 06/16] target/riscv: zicfilp `lpad` impl and branch tracking
Date: Thu, 15 Aug 2024 18:07:00 -0700
Message-ID: <20240816010711.3055425-7-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816010711.3055425-1-debug@rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x430.google.com
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
 target/riscv/insn_trans/trans_rvi.c.inc | 53 +++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

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
index c45b8fa1d8..494b6cdcc6 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -123,7 +123,10 @@ sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
-auipc    ....................       ..... 0010111 @u
+{
+  lpad     label:20 00000 0010111
+  auipc    ....................       ..... 0010111 @u
+}
 jal      ....................       ..... 1101111 @j
 jalr     ............     ..... 000 ..... 1100111 @i
 beq      ....... .....    ..... 000 ..... 1100011 @b
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 98e3806d5e..936b430282 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -36,6 +36,47 @@ static bool trans_lui(DisasContext *ctx, arg_lui *a)
     return true;
 }
 
+static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
+{
+    bool lp_expected = ctx->fcfi_lp_expected;
+    /*
+     * If zicfilp not present, the encoding is a nop.
+     * If forward cfi is not enabled, implementation is a nop.
+     */
+    if (!ctx->fcfi_enabled) {
+        return true;
+    }
+
+    if (ctx->base.pc_next == ctx->base.pc_first) {
+        ctx->fcfi_lp_expected = false;
+        /* If landing pad was expected, PC must be 4 byte aligned */
+        if (lp_expected && ((ctx->base.pc_next) & 0x3)) {
+            /*
+             * misaligned, according to spec we should raise sw check exception
+             */
+            gen_helper_raise_sw_check_excep(tcg_env,
+                tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL));
+            return true;
+        }
+    }
+
+    /* if lp was expected and lpad_label non-zero, do label check */
+    if (lp_expected && (a->label != 0)) {
+        TCGLabel *skip = gen_new_label();
+        TCGv tmp = tcg_temp_new();
+        tcg_gen_extract_tl(tmp, get_gpr(ctx, xT2, EXT_NONE), 12, 20);
+        tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->label, skip);
+        gen_helper_raise_sw_check_excep(tcg_env,
+            tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL));
+        gen_set_label(skip);
+    }
+
+    tcg_gen_st_tl(tcg_constant_tl(0), tcg_env,
+                  offsetof(CPURISCVState, elp));
+
+    return true;
+}
+
 static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
 {
     TCGv target_pc = dest_gpr(ctx, a->rd);
@@ -75,6 +116,18 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
     gen_set_gpr(ctx, a->rd, succ_pc);
 
     tcg_gen_mov_tl(cpu_pc, target_pc);
+    if (ctx->fcfi_enabled) {
+        /*
+         * return from functions (i.e. rs1 == xRA || rs1 == xT0) are not
+         * tracked. zicfilp introduces sw guarded branch as well. sw guarded
+         * branch are not tracked. rs1 == xT2 is a sw guarded branch.
+         */
+        if (a->rs1 != xRA && a->rs1 != xT0 && a->rs1 != xT2) {
+            tcg_gen_st_tl(tcg_constant_tl(1),
+                          tcg_env, offsetof(CPURISCVState, elp));
+        }
+    }
+
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
-- 
2.44.0


