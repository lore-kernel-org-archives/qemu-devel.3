Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C53BC021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnu7-0003tl-IA; Sun, 16 Feb 2025 18:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntH-0002ei-N9
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:37 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntF-00063E-2f
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:35 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220c4159f87so49450695ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747851; x=1740352651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UyRltsK6Zck88z+9pqTT5EjUKOqG7aOoyYe1ovHeKls=;
 b=p9HCZGE+XTnl13MoiRyhGNsFJEHZjhfxWTpy/yzer6aFDNYYChtIuDRw24EWXrMAuY
 zq6lL/EEDmaZkb3b5YTSHynp126/poaSISuu9DUm8CIkRsiNVanKAfi9JfnlOpX46y42
 4moIv1VZriY1WoLJb/A/2b+gdXMCitOlNe0BTOvpRoC/wx8pVKHE74uzDY7++EaN1zHq
 OC/gEjSLRguCB59WceyP8fSXuQYUPIy8BH8AM//3PocTJtzqhUTRmYMjDkWkLBbDUbu9
 MM3irSJIYZKzkIyK42dsjanhwmch//ZtCWxW8XaN8LJYTR09Ps2g7wOzrpAfdyYGmnbB
 9cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747851; x=1740352651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UyRltsK6Zck88z+9pqTT5EjUKOqG7aOoyYe1ovHeKls=;
 b=Q1aDrjkE3N4cOb1DlTRFvkSUdV9TNbOYIQR3l80Aj8JI8ykisrt7EugucdZ0pI8TG3
 lm72UQ9r+cD7fmx9dUzgOIxykLBj5ri7+tPVFHPd1e2T7rEQKlPN0CEA8zbVTdzJbp+x
 y/fXRltoQgH2ZPIHQW8VoxxoBfjkxpkRqbgmZjnT+9lIr/hJudyKbTbCVtg7AU70rhfr
 vIrUyDLr5mhv7174gCIDOueXSg+C8vopzk8IKw3ZVgcnV31OWz0+corX1GvPgPp6fE2O
 Y2z7LzEdxrdCkeF/mP5/H/H+4d1d+0lAwfXyvqZs6YuSLt7720oJqQs/W7ii91sgPGW8
 H8Jg==
X-Gm-Message-State: AOJu0Yzx/koxl0bVdbvhYw4Pq5vY8LLn8hmIH3WwAoMR816oVhjkuB51
 8fwGw6p/p9ckPvbgo4YjtKOdWLcqH9FYW+6iNZ2EMIVlgdjq/iFTTwc1/K/H8XD7GIvSTa8Ne4l
 B
X-Gm-Gg: ASbGncs2CcRgW/5aJypFwisPMz29EaochWr0pcij4vZo/U9Qh2vhhJjCPiIsbuPzlse
 wxdqsn+SlrohdhZsxqQKn0j5E+PNV1wLwrI2NevVifTHumew5dNAzwLn57UJ7Q4w+wfzGaLz/2d
 DbsvBuk8QTrUJO/JY2cEBH1w1chts8l1+MBrBpEluqIsB2REDgcDyKbaMn25TTZZw/vU67fp7eq
 Ge+RM4Gam9wvKmr8QOwtyt0loErUIeyRRIfQi1L2xj0KbTrJWbHbOwxuXqYtenWvH89lszZLRQ9
 5do1DyNir1brMReyz7oyFcOrEoEiSWeS6pHmFG/G/ULiYgs=
X-Google-Smtp-Source: AGHT+IH0d4aiRBxgI1FykdJjESKIcgS9Fvko+Jheep05hB1F+L91XpouNcAGyr7z0rptEoRPROJV2w==
X-Received: by 2002:a17:903:41c3:b0:21f:ba77:c45e with SMTP id
 d9443c01a7336-221040d8192mr109672955ad.45.1739747851250; 
 Sun, 16 Feb 2025 15:17:31 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 102/162] tcg: Merge INDEX_op_deposit_{i32,i64}
Date: Sun, 16 Feb 2025 15:09:11 -0800
Message-ID: <20250216231012.2808572-103-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-opc.h    | 3 +--
 tcg/optimize.c           | 2 +-
 tcg/tcg-op.c             | 8 ++++----
 tcg/tcg.c                | 9 +++------
 tcg/tci.c                | 6 ++----
 docs/devel/tcg-ops.rst   | 6 ++++--
 tcg/tci/tcg-target.c.inc | 2 +-
 7 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 4ace1f85c4..c6848b3c63 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -49,6 +49,7 @@ DEF(bswap64, 1, 1, 1, TCG_OPF_INT)
 DEF(clz, 1, 2, 0, TCG_OPF_INT)
 DEF(ctpop, 1, 1, 0, TCG_OPF_INT)
 DEF(ctz, 1, 2, 0, TCG_OPF_INT)
+DEF(deposit, 1, 2, 2, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
 DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
@@ -90,7 +91,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(deposit_i32, 1, 2, 2, 0)
 DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(add2_i32, 2, 4, 0, 0)
@@ -111,7 +111,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(deposit_i64, 1, 2, 2, 0)
 DEF(extract2_i64, 1, 2, 1, 0)
 
 /* size changing ops */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index d19bc19209..f1adea829b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2846,7 +2846,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_ctpop:
             done = fold_ctpop(&ctx, op);
             break;
-        CASE_OP_32_64(deposit):
+        case INDEX_op_deposit:
             done = fold_deposit(&ctx, op);
             break;
         case INDEX_op_divs:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b88f411ece..961a39f446 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -915,7 +915,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
         return;
     }
     if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, arg1, arg2, ofs, len);
+        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
         return;
     }
 
@@ -961,7 +961,7 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
     } else if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
         TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len);
+        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, zero, arg, ofs, len);
     } else {
         /*
          * To help two-operand hosts we prefer to zero-extend first,
@@ -2533,7 +2533,7 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
 
     if (TCG_TARGET_REG_BITS == 64) {
         if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
-            tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, arg1, arg2, ofs, len);
+            tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
             return;
         }
     } else {
@@ -2594,7 +2594,7 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     } else if (TCG_TARGET_REG_BITS == 64 &&
                TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
         TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, zero, arg, ofs, len);
+        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
     } else {
         if (TCG_TARGET_REG_BITS == 32) {
             if (ofs >= 32) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f45d7374b6..0ee12c5a08 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1133,8 +1133,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
-    OUTOP(INDEX_op_deposit_i32, TCGOutOpDeposit, outop_deposit),
-    OUTOP(INDEX_op_deposit_i64, TCGOutOpDeposit, outop_deposit),
+    OUTOP(INDEX_op_deposit, TCGOutOpDeposit, outop_deposit),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
@@ -2379,6 +2378,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_brcond:
+    case INDEX_op_deposit:
     case INDEX_op_extract:
     case INDEX_op_mov:
     case INDEX_op_movcond:
@@ -2397,7 +2397,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_deposit_i32:
         return true;
 
     case INDEX_op_extract2_i32:
@@ -2426,7 +2425,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
     case INDEX_op_extract2_i64:
@@ -5537,8 +5535,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
+    case INDEX_op_deposit:
         {
             const TCGOutOpDeposit *out = &outop_deposit;
 
diff --git a/tcg/tci.c b/tcg/tci.c
index 595416a192..dc916eb112 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -655,8 +655,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ror32(regs[r1], regs[r2] & 31);
             break;
-        case INDEX_op_deposit_i32:
-        case INDEX_op_deposit_i64:
+        case INDEX_op_deposit:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit_tr(regs[r1], pos, len, regs[r2]);
             break;
@@ -1042,8 +1041,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), str_r(r2));
         break;
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
+    case INDEX_op_deposit:
         tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %d, %d",
                            op_name, str_r(r0), str_r(r1), str_r(r2), pos, len);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index ca7550f68c..aea8a897bd 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -442,7 +442,7 @@ Misc
      - | Indicate that the value of *t0* won't be used later. It is useful to
          force dead code elimination.
 
-   * - deposit_i32/i64 *dest*, *t1*, *t2*, *pos*, *len*
+   * - deposit *dest*, *t1*, *t2*, *pos*, *len*
 
      - | Deposit *t2* as a bitfield into *t1*, placing the result in *dest*.
        |
@@ -451,10 +451,12 @@ Misc
        |     *len* - the length of the bitfield
        |     *pos* - the position of the first bit, counting from the LSB
        |
-       | For example, "deposit_i32 dest, t1, t2, 8, 4" indicates a 4-bit field
+       | For example, "deposit dest, t1, t2, 8, 4" indicates a 4-bit field
          at bit 8. This operation would be equivalent to
        |
        |     *dest* = (*t1* & ~0x0f00) | ((*t2* << 8) & 0x0f00)
+       |
+       | on TCG_TYPE_I32.
 
    * - extract *dest*, *t1*, *pos*, *len*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 566c2fb0d0..ef14e81609 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -622,7 +622,7 @@ static const TCGOutOpBinary outop_ctz = {
 static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          TCGReg a2, unsigned ofs, unsigned len)
 {
-    tcg_out_op_rrrbb(s, INDEX_op_deposit_i64, a0, a1, a2, ofs, len);
+    tcg_out_op_rrrbb(s, INDEX_op_deposit, a0, a1, a2, ofs, len);
 }
 
 static const TCGOutOpDeposit outop_deposit = {
-- 
2.43.0


