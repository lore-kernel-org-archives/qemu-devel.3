Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B0E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfH-0002Ay-3w; Thu, 02 Jan 2025 13:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPep-0007iG-Pm
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:56 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPen-0006IN-03
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:55 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2164b662090so138828175ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841452; x=1736446252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ELrxzB/Uie1U8CwISVxbS/yTjLnqIUH5nl+LDIAO9uc=;
 b=g6DQXIaMxSxXn1vDDAJm+fiwANwSDHA/6VUE/zDMUV1gnd0ek1NA8CkUGWBLAIQR7V
 6h/XjVVCC8sS5RU+dKknTG+kcEuMN7gm9mvK1193uPsrvqyxxFvWjJxvrx1jh80yyfwD
 sc/nG4qnbr84xVPFlO0R2xG6Hj2OC25+l9aKJPwh1++1O04LAk037llveeb7FBigYOed
 rhaK3XyMYaV3AoubKjzQxmXHrCyipB7ShzbTyO3CQy6BDyUGSHRnVzbCniaS+DdSAL1f
 emKix2HFHiBZR+THWFUzZ1wpyPhR3yaaJDZJdlFyJ+2/0uLgAnPastC6EQxekC+c81ZV
 YQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841452; x=1736446252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELrxzB/Uie1U8CwISVxbS/yTjLnqIUH5nl+LDIAO9uc=;
 b=TL2hVfLPFEOhMrBATTDqie7y+JP9KJOw4laL/PyH/tlSRrMWfLYtnvjKWLfuV6epjP
 1Gjlh9k5mU7sS2uPecGwCsHiwbPH0OeagPekjf+PylYNGry0rAzJ5fxRqcbO1X9pXdyk
 57/Jt7g+jRmXkxzLMP8ils5mVeThsIQFgphAXFNsIyRr3otboqDKXOe5fEHLjSayUYDz
 jvp2ZWuqHgdkI1vtge2yDvQFTo8fSyyaO00XeXytaSS8guKKjl+EFXu+RcrFfToOXR0B
 +zVcADa3LFPLed4DFfXcBKX9e+UEY8Sxasiylwkv13TVAft5Biw+VaZiA8dq5c3d0sYg
 KrKg==
X-Gm-Message-State: AOJu0YyQ5qkfjbgIdKSQqW49T7AuAOeQtPPk0Wy+NFCuBCXerar71HTC
 abkVRdnL1xh1mdBmVYxsIpPjH51Ki1CJQX/SKttil2LXz1mY7CmgmD7bw55491J5sjnhrbPIeq2
 v
X-Gm-Gg: ASbGnctYBys0bwpqpMjKsS8UAxymW7OCWwqSfMr7KRcKtmQONT0mQzbpbw2iT6sG0Qt
 vfoCo3KeLS1cX+gayPWF77/btSS4aGLouiLSfk1R5ZB3uB+TRfZwlnNpJZrLciriNiLSCu5A6k9
 yY/hPYg/RXBq2OH2D42vtES677IoX1cOBP7MqJ5xSDvA8Vlku/2izdy5JpB8qNZuVEisbCPA9Z+
 A0hHPmZtmf635CnEHkmv4GoAu2tkuscGhWose+d4jduoqTDzAaKj8JNK+uTag==
X-Google-Smtp-Source: AGHT+IHehYcGKU7xdo/Em6ck4dotMeNQrQfeECUOnek6vqAV7znNfRQ0x9JIG5a9/skSJeBhxnFOvA==
X-Received: by 2002:a05:6a00:6c88:b0:729:cc5:fa42 with SMTP id
 d2e1a72fcca58-72abdeac3d1mr74909751b3a.20.1735841451656; 
 Thu, 02 Jan 2025 10:10:51 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 72/73] tcg: Merge bswap operations
Date: Thu,  2 Jan 2025 10:06:52 -0800
Message-ID: <20250102180654.1420056-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  9 ++++-----
 tcg/optimize.c                   | 20 +++++++++-----------
 tcg/tcg-op.c                     | 10 +++++-----
 tcg/tcg.c                        | 19 +++++++------------
 tcg/tci.c                        | 14 ++++++--------
 tcg/aarch64/tcg-target.c.inc     | 18 ++++++------------
 tcg/arm/tcg-target.c.inc         |  8 ++++----
 tcg/i386/tcg-target.c.inc        | 14 ++++++--------
 tcg/loongarch64/tcg-target.c.inc | 22 ++++++++--------------
 tcg/mips/tcg-target.c.inc        | 18 ++++++------------
 tcg/ppc/tcg-target.c.inc         | 18 ++++++------------
 tcg/riscv/tcg-target.c.inc       | 18 ++++++------------
 tcg/s390x/tcg-target.c.inc       | 32 +++++++++-----------------------
 tcg/tci/tcg-target.c.inc         | 18 ++++++------------
 14 files changed, 88 insertions(+), 150 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index badc587af9..33c630e223 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -74,6 +74,10 @@ DEF(sextract, 1, 1, 2, TCG_OPF_INT)
 DEF(deposit, 1, 2, 2, TCG_OPF_INT)
 DEF(extract2, 1, 2, 1, TCG_OPF_INT)
 
+DEF(bswap16, 1, 1, 1, TCG_OPF_INT)
+DEF(bswap32, 1, 1, 1, TCG_OPF_INT)
+DEF(bswap64, 1, 1, 1, TCG_OPF_INT)
+
 DEF(brcond, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | TCG_OPF_INT)
 DEF(setcond, 1, 2, 1, TCG_OPF_INT)
 DEF(negsetcond, 1, 2, 1, TCG_OPF_INT)
@@ -82,8 +86,6 @@ DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
-DEF(bswap16_i32, 1, 1, 1, 0)
-DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
@@ -94,9 +96,6 @@ DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(bswap16_i64, 1, 1, 1, 0)
-DEF(bswap32_i64, 1, 1, 1, 0)
-DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index e29fa9b940..0b7a4b1aad 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -504,15 +504,15 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type, uint64_t x, ui
     case INDEX_op_ctpop_i64:
         return ctpop64(x);
 
-    CASE_OP_32_64(bswap16):
+    case INDEX_op_bswap16:
         x = bswap16(x);
         return y & TCG_BSWAP_OS ? (int16_t)x : x;
 
-    CASE_OP_32_64(bswap32):
+    case INDEX_op_bswap32:
         x = bswap32(x);
         return y & TCG_BSWAP_OS ? (int32_t)x : x;
 
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap64:
         return bswap64(x);
 
     case INDEX_op_ext_i32_i64:
@@ -1538,17 +1538,15 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
 
     z_mask = t1->z_mask;
     switch (op->opc) {
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap16:
         z_mask = bswap16(z_mask);
         sign = INT16_MIN;
         break;
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap32:
         z_mask = bswap32(z_mask);
         sign = INT32_MIN;
         break;
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap64:
         z_mask = bswap64(z_mask);
         sign = INT64_MIN;
         break;
@@ -2734,9 +2732,9 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_brcond2_i32:
             done = fold_brcond2(&ctx, op);
             break;
-        CASE_OP_32_64(bswap16):
-        CASE_OP_32_64(bswap32):
-        case INDEX_op_bswap64_i64:
+        case INDEX_op_bswap16:
+        case INDEX_op_bswap32:
+        case INDEX_op_bswap64:
             done = fold_bswap(&ctx, op);
             break;
         CASE_OP_32_64(clz):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 34b97754a6..4f1b7605aa 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1250,7 +1250,7 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
 
     if (TCG_TARGET_HAS_bswap(TCG_TYPE_I32)) {
-        tcg_gen_op3i_i32(INDEX_op_bswap16_i32, ret, arg, flags);
+        tcg_gen_op3i_i32(INDEX_op_bswap16, ret, arg, flags);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
@@ -1287,7 +1287,7 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (TCG_TARGET_HAS_bswap(TCG_TYPE_I32)) {
-        tcg_gen_op3i_i32(INDEX_op_bswap32_i32, ret, arg, 0);
+        tcg_gen_op3i_i32(INDEX_op_bswap32, ret, arg, 0);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
@@ -2102,7 +2102,7 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         }
     } else if (TCG_TARGET_HAS_bswap(TCG_TYPE_I64)) {
-        tcg_gen_op3i_i64(INDEX_op_bswap16_i64, ret, arg, flags);
+        tcg_gen_op3i_i64(INDEX_op_bswap16, ret, arg, flags);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
@@ -2152,7 +2152,7 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         }
     } else if (TCG_TARGET_HAS_bswap(TCG_TYPE_I64)) {
-        tcg_gen_op3i_i64(INDEX_op_bswap32_i64, ret, arg, flags);
+        tcg_gen_op3i_i64(INDEX_op_bswap32, ret, arg, flags);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
@@ -2199,7 +2199,7 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
     } else if (TCG_TARGET_HAS_bswap(TCG_TYPE_I64)) {
-        tcg_gen_op3i_i64(INDEX_op_bswap64_i64, ret, arg, 0);
+        tcg_gen_op3i_i64(INDEX_op_bswap64, ret, arg, 0);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d3ed9d7be4..f0f733f189 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2214,6 +2214,10 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return has_type && TCG_TARGET_HAS_add2(type);
     case INDEX_op_andc:
         return has_type && TCG_TARGET_HAS_andc(type);
+    case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
+    case INDEX_op_bswap64:
+        return has_type && TCG_TARGET_HAS_bswap(type);
     case INDEX_op_div:
     case INDEX_op_divu:
         return has_type && TCG_TARGET_HAS_div(type);
@@ -2251,9 +2255,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_sub2:
         return has_type && TCG_TARGET_HAS_sub2(type);
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap32_i32:
-        return TCG_TARGET_HAS_bswap(TCG_TYPE_I32);
     case INDEX_op_clz_i32:
         return TCG_TARGET_HAS_clz(TCG_TYPE_I32);
     case INDEX_op_ctz_i32:
@@ -2267,10 +2268,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_extrh_i64_i32:
         return TCG_TARGET_REG_BITS == 64;
 
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap32_i64:
-    case INDEX_op_bswap64_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_bswap(TCG_TYPE_I64);
     case INDEX_op_clz_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_clz(TCG_TYPE_I64);
     case INDEX_op_ctz_i64:
@@ -2846,11 +2843,9 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                     i = 2;
                 }
                 break;
-            case INDEX_op_bswap16_i32:
-            case INDEX_op_bswap16_i64:
-            case INDEX_op_bswap32_i32:
-            case INDEX_op_bswap32_i64:
-            case INDEX_op_bswap64_i64:
+            case INDEX_op_bswap16:
+            case INDEX_op_bswap32:
+            case INDEX_op_bswap64:
                 {
                     TCGArg flags = op->args[k];
                     const char *name = NULL;
diff --git a/tcg/tci.c b/tcg/tci.c
index 14d4b3808c..ba47497f4e 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -709,11 +709,11 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
 #endif
             break;
-        CASE_32_64(bswap16)
+        case INDEX_op_bswap16:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap16(regs[r1]);
             break;
-        CASE_32_64(bswap32)
+        case INDEX_op_bswap32:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap32(regs[r1]);
             break;
@@ -769,7 +769,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (uint32_t)regs[r1];
             break;
-        case INDEX_op_bswap64_i64:
+        case INDEX_op_bswap64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap64(regs[r1]);
             break;
@@ -1024,11 +1024,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
+    case INDEX_op_bswap64:
     case INDEX_op_neg:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 404c5a5c15..5c8d490fa4 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2383,20 +2383,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_qemu_ldst_i128(s, REG0(0), REG0(1), a2, args[3], false);
         break;
 
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap64:
         tcg_out_rev(s, TCG_TYPE_I64, MO_64, a0, a1);
         break;
-    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap32:
         tcg_out_rev(s, TCG_TYPE_I32, MO_32, a0, a1);
         if (a2 & TCG_BSWAP_OS) {
             tcg_out_ext32s(s, a0, a0);
         }
         break;
-    case INDEX_op_bswap32_i32:
-        tcg_out_rev(s, TCG_TYPE_I32, MO_32, a0, a1);
-        break;
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap16:
         tcg_out_rev(s, TCG_TYPE_I32, MO_16, a0, a1);
         if (a2 & TCG_BSWAP_OS) {
             /* Output must be sign-extended. */
@@ -2913,11 +2909,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ld:
     case INDEX_op_neg:
     case INDEX_op_not:
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap32_i64:
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
+    case INDEX_op_bswap64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 890fd84068..55fc420b7c 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2116,10 +2116,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                         args[4], TCG_TYPE_I64);
         break;
 
-    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap16:
         tcg_out_bswap16(s, COND_AL, args[0], args[1], args[2]);
         break;
-    case INDEX_op_bswap32_i32:
+    case INDEX_op_bswap32:
         tcg_out_bswap32(s, COND_AL, args[0], args[1]);
         break;
 
@@ -2184,8 +2184,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ld:
     case INDEX_op_neg:
     case INDEX_op_not:
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap32_i32:
+    case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
     case INDEX_op_extract:
     case INDEX_op_sextract:
         return C_O1_I1(r, r);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index b346f73ea3..5285d2eddd 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2873,7 +2873,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_movcond(s, rexw, args[5], a0, a1, a2, const_a2, args[3]);
         break;
 
-    OP_32_64(bswap16):
+    case INDEX_op_bswap16:
         if (a2 & TCG_BSWAP_OS) {
             /* Output must be sign-extended. */
             if (rexw) {
@@ -2891,7 +2891,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out_rolw_8(s, a0);
         }
         break;
-    OP_32_64(bswap32):
+    case INDEX_op_bswap32:
         tcg_out_bswap32(s, a0);
         if (rexw && (a2 & TCG_BSWAP_OS)) {
             tcg_out_ext32s(s, a0, a0);
@@ -3002,7 +3002,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_setcond2(s, args, const_args);
         break;
 #else /* TCG_TARGET_REG_BITS == 64 */
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap64:
         tcg_out_bswap64(s, a0);
         break;
     case INDEX_op_extrh_i64_i32:
@@ -3705,11 +3705,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_brcond:
         return C_O0_I2(r, reT);
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
+    case INDEX_op_bswap64:
     case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 237cfd634b..119823067a 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1400,8 +1400,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap16:
         tcg_out_opc_revb_2h(s, a0, a1);
         if (a2 & TCG_BSWAP_OS) {
             tcg_out_ext16s(s, TCG_TYPE_REG, a0, a0);
@@ -1410,20 +1409,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_bswap32_i32:
-        /* All 32-bit values are computed sign-extended in the register.  */
-        a2 = TCG_BSWAP_OS;
-        /* fallthrough */
-    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap32:
         tcg_out_opc_revb_2w(s, a0, a1);
-        if (a2 & TCG_BSWAP_OS) {
+        /* All 32-bit values are computed sign-extended in the register.  */
+        if (type == TCG_TYPE_I32 || (a2 & TCG_BSWAP_OS)) {
             tcg_out_ext32s(s, a0, a0);
         } else if ((a2 & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
             tcg_out_ext32u(s, a0, a0);
         }
         break;
 
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap64:
         tcg_out_opc_revb_d(s, a0, a1);
         break;
 
@@ -2230,11 +2226,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_not:
     case INDEX_op_extract:
     case INDEX_op_sextract:
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
+    case INDEX_op_bswap64:
     case INDEX_op_ld:
     case INDEX_op_qemu_ld_a32_i32:
     case INDEX_op_qemu_ld_a64_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 541e68e9bf..2f2e37d7a4 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1926,17 +1926,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_reg(s, i1, a0, TCG_REG_ZERO, a1);
         break;
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap16:
         tcg_out_bswap16(s, a0, a1, a2);
         break;
-    case INDEX_op_bswap32_i32:
-        tcg_out_bswap32(s, a0, a1, 0);
-        break;
-    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap32:
         tcg_out_bswap32(s, a0, a1, a2);
         break;
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap64:
         tcg_out_bswap64(s, a0, a1);
         break;
     case INDEX_op_extrh_i64_i32:
@@ -2145,13 +2141,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ld:
     case INDEX_op_neg:
     case INDEX_op_not:
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap32_i32:
     case INDEX_op_extract:
     case INDEX_op_sextract:
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap32_i64:
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
+    case INDEX_op_bswap64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 96a492cbe2..339badea42 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3337,17 +3337,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_setcond2(s, args, const_args);
         break;
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap16:
         tcg_out_bswap16(s, args[0], args[1], args[2]);
         break;
-    case INDEX_op_bswap32_i32:
-        tcg_out_bswap32(s, args[0], args[1], 0);
-        break;
-    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap32:
         tcg_out_bswap32(s, args[0], args[1], args[2]);
         break;
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap64:
         tcg_out_bswap64(s, args[0], args[1]);
         break;
 
@@ -4090,8 +4086,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ctpop_i32:
     case INDEX_op_neg:
     case INDEX_op_not:
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap32_i32:
     case INDEX_op_extract:
     case INDEX_op_sextract:
     case INDEX_op_ctpop_i64:
@@ -4099,9 +4093,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap32_i64:
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
+    case INDEX_op_bswap64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 5135af5473..28c1afca65 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2215,13 +2215,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap64:
         tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
         break;
-    case INDEX_op_bswap32_i32:
-        a2 = 0;
-        /* fall through */
-    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap32:
         tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
         if (a2 & TCG_BSWAP_OZ) {
             tcg_out_opc_imm(s, OPC_SRLI, a0, a0, 32);
@@ -2229,8 +2226,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out_opc_imm(s, OPC_SRAI, a0, a0, 32);
         }
         break;
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap16:
         tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
         if (a2 & TCG_BSWAP_OZ) {
             tcg_out_opc_imm(s, OPC_SRLI, a0, a0, 48);
@@ -2594,11 +2590,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extract:
     case INDEX_op_sextract:
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap32_i64:
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
+    case INDEX_op_bswap64:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index edf7c0e92c..d6e6418403 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2514,16 +2514,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_bswap16_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        tcg_out_insn(s, RRE, LRVR, a0, a1);
-        if (a2 & TCG_BSWAP_OS) {
-            tcg_out_sh32(s, RS_SRA, a0, TCG_REG_NONE, 16);
-        } else {
-            tcg_out_sh32(s, RS_SRL, a0, TCG_REG_NONE, 16);
-        }
-        break;
-    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap16:
         a0 = args[0], a1 = args[1], a2 = args[2];
         tcg_out_insn(s, RRE, LRVGR, a0, a1);
         if (a2 & TCG_BSWAP_OS) {
@@ -2533,10 +2524,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_bswap32_i32:
-        tcg_out_insn(s, RRE, LRVR, args[0], args[1]);
-        break;
-    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap32:
         a0 = args[0], a1 = args[1], a2 = args[2];
         tcg_out_insn(s, RRE, LRVR, a0, a1);
         if (a2 & TCG_BSWAP_OS) {
@@ -2546,6 +2534,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
+    case INDEX_op_bswap64:
+        tcg_out_insn(s, RRE, LRVGR, args[0], args[1]);
+        break;
+
     case INDEX_op_add2:
         if (type == TCG_TYPE_I32) {
             if (const_args[4]) {
@@ -2635,10 +2627,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_bswap64_i64:
-        tcg_out_insn(s, RRE, LRVGR, args[0], args[1]);
-        break;
-
     case INDEX_op_mulu2:
         tcg_debug_assert(args[0] == args[2]);
         tcg_debug_assert((args[1] & 1) == 0);
@@ -3211,11 +3199,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
                 ? C_O0_I2(r, ri)
                 : C_O0_I2(r, rC));
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
+    case INDEX_op_bswap64:
     case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 472c6ea87f..e996b5e23c 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -49,11 +49,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
+    case INDEX_op_bswap64:
     case INDEX_op_extract:
     case INDEX_op_sextract:
     case INDEX_op_ctpop_i32:
@@ -761,18 +759,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_neg:
     case INDEX_op_not:
     CASE_32_64(ctpop)    /* Optional (TCG_TARGET_HAS_ctpop_*). */
-    case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap). */
-    case INDEX_op_bswap64_i64: /* Optional (TCG_TARGET_HAS_bswap). */
+    case INDEX_op_bswap64:
         tcg_out_op_rr(s, opc, args[0], args[1]);
         break;
 
-    case INDEX_op_bswap16_i32: /* Optional (TCG_TARGET_HAS_bswap). */
+    case INDEX_op_bswap16:
         width = 16;
         goto do_bswap;
-    case INDEX_op_bswap16_i64: /* Optional (TCG_TARGET_HAS_bswap). */
-        width = 16;
-        goto do_bswap;
-    case INDEX_op_bswap32_i64: /* Optional (TCG_TARGET_HAS_bswap). */
+    case INDEX_op_bswap32:
         width = 32;
     do_bswap:
         /* The base tci bswaps zero-extend, and ignore high bits. */
-- 
2.43.0


