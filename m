Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173F6C021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmk-0005fh-FW; Sun, 16 Feb 2025 18:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmU-0005Yy-Di
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:34 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmS-0005Fv-Ht
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:34 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220c8eb195aso78700015ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747431; x=1740352231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ixgGA88LjqD1TSMnYNBgq9g4EzSr5G5IRn41gX5YwY=;
 b=K6WAjnVjKnbNCFwrl77FREA/31YpkIZ2XHXCpOwBHlqIQGRXmvwdg8N989fV/GzCQ5
 84PHtiy3azqoyvl3E9XgK2umKdo3aOsmhRqyWzLFc9sXIkMnpVEWaL/IWXnNmlruaOS5
 anxG7otZINzvFYvB3KWiSV5S+ssWnVcTQoKYYmfevRI+Tg2ex3Qg6f8t0Dor1a1chnZe
 UAPO5JrzockzKg2pt5CQC57n+v1i2hyC95P8SZtTh9kPZOVdXzOEezb/cKcZgausHN7K
 munFa4dy8QNEJF6yGLDLN4HvjLt9lqc8Ktk0unDLG/n2Sh919hgILfMx8xxcsIvQ0FIT
 bRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747431; x=1740352231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ixgGA88LjqD1TSMnYNBgq9g4EzSr5G5IRn41gX5YwY=;
 b=LyK88t2cdoEBw/fHmO4T8tW6R74bU3+XgG4Ap0t5If4+CX5h8tyHXMWp1qf7hMXftn
 VsCwXx7lNdq5+Yp9ZZmFU5XOD1EVlWCswxQegvppzxbje9H7tl+lHS+gdhT+OXimJTQT
 7m64D+8Y+wA+QOr7Z8gFpF69LkQi67RgAiNYyctS5/C9kg+SeY3TkdvPRbIdekaQgls1
 AacznbY76Du/7TsMEmdLef6SYCxWOAAlSpbZIHsq4VhaHMsdaV31+k+7bRe3qzVEpIDJ
 xrwsjhty3K1pxdY5DYC817ZEXwQmyCeDYRLgIdKWv5yT6AguiHs3rjbT7RBZ5IyvAffk
 E+3Q==
X-Gm-Message-State: AOJu0YzcT03fv9dD1QI9hAjRXkGB/FZVZ6tX4K5wPAKUS8o7BoGqBa7r
 0YJ2/qBhcy032irP2HVjLMon2zhrORzZvPqvnGL04573L4y9E186arklIX3/sISyKnXj6daGPaN
 O
X-Gm-Gg: ASbGncssfpxTL4SAp+yGC2GKYuLu6KHlUhC6xG5H/LFj5ylHCQDySb/0zsBg/LmYSab
 mcnFIxGrryPiPuVn/0GcUxR1peHWWW13wgtE0i3QgwTXT9l9Nw6nV4dwDbyqD6oMQE9q2Y38/9W
 9XgLlBlpnZrf59mLyT2lS3FIlZXHWSOk+l2JBPH6EsACc8qlL8iaGq3+m+W1CLKzsA3G9rVWbld
 5RqNZlywIp1U0bz52RLLNfVX/sXUyPPOWW/gqnL7iOMA0UMh5ZzuvWrPIXz3X307spg6bmKz6k7
 hu6VasnAkZOWCcNYSwc7rjqpkodgpt5JTRjFIVRI48rx91U=
X-Google-Smtp-Source: AGHT+IHDbuWbWUa5ysOn5Tk8kkCozotAZad2hTLZvsyTccBqOyRncGCAPw0fN0lIu5xZIBDjJMmlng==
X-Received: by 2002:a17:902:d4cd:b0:220:e9ef:ec98 with SMTP id
 d9443c01a7336-22104047c9amr128772245ad.19.1739747431157; 
 Sun, 16 Feb 2025 15:10:31 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 023/162] tcg: Merge INDEX_op_nand_{i32,i64}
Date: Sun, 16 Feb 2025 15:07:52 -0800
Message-ID: <20250216231012.2808572-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
index c6869de244..1acdd7cfda 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
+DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
@@ -94,7 +95,6 @@ DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(nand_i32, 1, 2, 0, 0)
 DEF(nor_i32, 1, 2, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
@@ -147,7 +147,6 @@ DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
 DEF(neg_i64, 1, 1, 0, 0)
-DEF(nand_i64, 1, 2, 0, 0)
 DEF(nor_i64, 1, 2, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 4efd6a1b2c..b4dc34b9b1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -481,7 +481,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_eqv_vec:
         return ~(x ^ y);
 
-    CASE_OP_32_64_VEC(nand):
+    case INDEX_op_nand:
+    case INDEX_op_nand_vec:
         return ~(x & y);
 
     CASE_OP_32_64_VEC(nor):
@@ -2980,7 +2981,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(mulu2):
             done = fold_multiply2(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(nand):
+        case INDEX_op_nand:
+        case INDEX_op_nand_vec:
             done = fold_nand(&ctx, op);
             break;
         CASE_OP_32_64(neg):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3921bac48d..57782864fa 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -690,8 +690,8 @@ void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_nand_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nand_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_nand, ret, arg1, arg2);
     } else {
         tcg_gen_and_i32(ret, arg1, arg2);
         tcg_gen_not_i32(ret, ret);
@@ -2292,8 +2292,8 @@ void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_nand_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_nand_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_nand_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nand_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_nand, ret, arg1, arg2);
     } else {
         tcg_gen_and_i64(ret, arg1, arg2);
         tcg_gen_not_i64(ret, ret);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4f581af706..f870f41236 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1008,8 +1008,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
-    OUTOP(INDEX_op_nand_i32, TCGOutOpBinary, outop_nand),
-    OUTOP(INDEX_op_nand_i64, TCGOutOpBinary, outop_nand),
+    OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -5428,8 +5427,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_eqv:
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
+    case INDEX_op_nand:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index 8be59a0193..9886ddf001 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -559,7 +559,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] ^ regs[r2]);
             break;
-        CASE_32_64(nand)
+        case INDEX_op_nand:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] & regs[r2]);
             break;
@@ -1078,6 +1078,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_eqv:
+    case INDEX_op_nand:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
@@ -1085,8 +1086,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
     case INDEX_op_div_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index fe149e012d..7703dfbc51 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -327,7 +327,7 @@ Logical
 
      - | *t0* = ~(*t1* ^ *t2*), or equivalently, *t0* = *t1* ^ ~\ *t2*
 
-   * - nand_i32/i64 *t0*, *t1*, *t2*
+   * - nand *t0*, *t1*, *t2*
 
      - | *t0* = ~(*t1* & *t2*)
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 2a5c72705d..34a44a7674 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -672,7 +672,7 @@ static const TCGOutOpBinary outop_eqv = {
 static void tgen_nand(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_nand_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_nand, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_nand = {
-- 
2.43.0


