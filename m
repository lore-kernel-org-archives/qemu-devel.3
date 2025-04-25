Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8D7C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R1A-0007cM-PQ; Fri, 25 Apr 2025 17:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R10-0007Wx-5K
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:22 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0x-0000ZF-QK
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:21 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so2257956b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618118; x=1746222918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRTrBoRoZTVV4G7EslYz6Kfj55GebgY7L5cZRE11aFU=;
 b=Uvan/5jcCCFkhXppJvd6zuFR6J95D1U8faV6Yn+BHZ6F/AUFTiYZasmsRn2tTerseI
 R+Ncm3JbZaDJWLv017DBgiU86/E9wqbc1urED386UtRBF+h+Gelbacx9Vw4aeo/XFFft
 zY6t8qDKTen/wCyC6nOH+z0DzP9NHIaH0FT4E4CC4kC+FV6zmzTqBxFxWYRFbmleHNB7
 AX9NyNklfNylVx8jnuhblEqF6wEW+frx/apqRhXH7Vq0iz5Hx1yCGcsoDaVBMigPd/QJ
 B5lUnOt2CaJqbBRRgbVNQzfflJGaW4Bb8zXxslEYxFYBJVqiAkjMJzuV9zv4cgPMaN16
 79dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618118; x=1746222918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRTrBoRoZTVV4G7EslYz6Kfj55GebgY7L5cZRE11aFU=;
 b=bMlXkJlGILkpYu2Es1LZJRm+C7YFQ8qdW91VKb77XzZYO9TrFKojE8cg01BJj+dx81
 HMLjX2+ulDYzPA8y0ZHFP7lxCm6aT5Zn2dQbOT4sgcxUw/m99gI6+LksK44oPNzccu1f
 fZtFcJsq9PvdiMpTgZBzNW3uCrNoo0X6PzB/bt4yGqATtOw4F1CUPebvqJehSErypZBY
 IR5XmIDaTfwJdNCDmp6ieCLMhTBUBnU403HRJDymxWOUa+ruy/lE1SoTwAUWPZsrXmJU
 YxqsZ+GxrrfMOhBa3z7GorJlIL9I2/ZqBV8Qp+W7SsHJYGqyL9IbfsZVbua/XS7bEKJG
 ciCQ==
X-Gm-Message-State: AOJu0YwHb+B7KAZf54wDTuHcPo8LiwKaGLgf4UErMB2xnYjxfiJOSgkY
 KyPnjCHB+ig4kDTiJRNeki8BycI/NnE9NVWhQClBKrrETQJyiRn54YsCPXfsWGXN5xTsYU2zi1c
 x
X-Gm-Gg: ASbGncu3eiLyWom/eOQRJX9dOURwAfX+9HJrlEBMCXek03JJ9APcaJZ8I8AuIMuMlQx
 qLeACN8DjMxWfYGrn5o4IeKpAd3kIoKhLRdPZV18rnbBEzzdvkKtMxl5QszKpRImzx4RIQvLd1A
 G1mDfUjvGIl2jj4/efbihIWsSc0Y0n+gBdE0q/j7QEaupXhEgktLLKeNfpDP0Edtj5mpzqliN8l
 zR0sGiOVsX1yIuxcNe+KdEGZtxmW0GEteQ4tX2hElIvZljbvkJXTfLyKvxwTJyPDTKesY29bU8B
 Sq5x41KSMUSqt1Wrxwu4HLjIJyQ8z874p2idR3sQ8QEv2cEy1KxDjs2WD5MA2nMlTC0NmTaCqHw
 =
X-Google-Smtp-Source: AGHT+IFrRKPLFi674D2aTJMZRFPu3gLyX9/K5qOhGh9839BQrNPFsXcSYOHUebHFdfFHWy5dd3QIbA==
X-Received: by 2002:a05:6a21:1510:b0:1f5:80a3:b003 with SMTP id
 adf61e73a8af0-2045b9d92cdmr6374895637.37.1745618118096; 
 Fri, 25 Apr 2025 14:55:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 031/159] tcg: Merge INDEX_op_nor_{i32,i64}
Date: Fri, 25 Apr 2025 14:52:45 -0700
Message-ID: <20250425215454.886111-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 3 +--
 tcg/optimize.c           | 6 ++++--
 tcg/tcg-op.c             | 8 ++++----
 tcg/tcg.c                | 6 ++----
 tcg/tci.c                | 5 ++---
 docs/devel/tcg-ops.rst   | 2 +-
 tcg/tci/tcg-target.c.inc | 2 +-
 7 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 1acdd7cfda..aa9ed393c9 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -44,6 +44,7 @@ DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
+DEF(nor, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
@@ -95,7 +96,6 @@ DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(nor_i32, 1, 2, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
@@ -147,7 +147,6 @@ DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
 DEF(neg_i64, 1, 1, 0, 0)
-DEF(nor_i64, 1, 2, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index e8e6a0c2ce..e4c319fe45 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -497,7 +497,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_nand_vec:
         return ~(x & y);
 
-    CASE_OP_32_64_VEC(nor):
+    case INDEX_op_nor:
+    case INDEX_op_nor_vec:
         return ~(x | y);
 
     case INDEX_op_clz_i32:
@@ -3000,7 +3001,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(neg):
             done = fold_neg(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(nor):
+        case INDEX_op_nor:
+        case INDEX_op_nor_vec:
             done = fold_nor(&ctx, op);
             break;
         CASE_OP_32_64_VEC(not):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ac939bb4ea..228aa8f088 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -700,8 +700,8 @@ void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_nor_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nor_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_nor, ret, arg1, arg2);
     } else {
         tcg_gen_or_i32(ret, arg1, arg2);
         tcg_gen_not_i32(ret, ret);
@@ -2305,8 +2305,8 @@ void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_nor_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_nor_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_nor_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nor_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_nor, ret, arg1, arg2);
     } else {
         tcg_gen_or_i64(ret, arg1, arg2);
         tcg_gen_not_i64(ret, ret);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d9807b77dc..c0178030ce 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1009,8 +1009,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
-    OUTOP(INDEX_op_nor_i32, TCGOutOpBinary, outop_nor),
-    OUTOP(INDEX_op_nor_i64, TCGOutOpBinary, outop_nor),
+    OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -5432,8 +5431,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_eqv:
     case INDEX_op_nand:
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
+    case INDEX_op_nor:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index 3ea93fa5a6..ff129266c2 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -563,7 +563,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] & regs[r2]);
             break;
-        CASE_32_64(nor)
+        case INDEX_op_nor:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] | regs[r2]);
             break;
@@ -1077,6 +1077,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_andc:
     case INDEX_op_eqv:
     case INDEX_op_nand:
+    case INDEX_op_nor:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
@@ -1084,8 +1085,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
     case INDEX_op_div_i32:
     case INDEX_op_div_i64:
     case INDEX_op_rem_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 7703dfbc51..26d464fa38 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -331,7 +331,7 @@ Logical
 
      - | *t0* = ~(*t1* & *t2*)
 
-   * - nor_i32/i64 *t0*, *t1*, *t2*
+   * - nor *t0*, *t1*, *t2*
 
      - | *t0* = ~(*t1* | *t2*)
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index a0f4c58be8..dec51692f0 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -681,7 +681,7 @@ static const TCGOutOpBinary outop_nand = {
 static void tgen_nor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_nor_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_nor, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_nor = {
-- 
2.43.0


