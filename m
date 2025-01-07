Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BFCE77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4eD-0006oL-Nx; Tue, 07 Jan 2025 03:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4dr-0005qv-NU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:08:48 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4dm-0004SZ-FS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:08:47 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso215070965ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237321; x=1736842121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHkH+yoDhdptRxSNPHQhXg5UfEe1jlwqLSHXsjre/Y8=;
 b=zYHM2Hlu4Ir9RzTNVt5ErsMGzVld2LHS/6rHqzWirR7pIiFw4jBjZcKhH4jcLOI4Rt
 iYdAy870UqcvE2bV1vy3IU3rvYgGxMvU1IboGQ6sNlSxurCODlgc5LGCYZAh/k9PJazQ
 BUc5Vxc6zjps8IvPFxsn19nJmWZxSyYDBAEzT03nlgqd/k75I3FH66OSCoWKTBj4plrL
 UaJM03TlNwAD6HPWjtfYAr2zrPnSysb1toygAMh0UwcyiBBJ8Z5NcuzVzueHygzfG5W1
 HNOBv95JtJ+5AAb98gCymTT/22SbRLPtEIFykyS2OAQ36tEnC9EetTO1yUmldDhmynlP
 QfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237321; x=1736842121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHkH+yoDhdptRxSNPHQhXg5UfEe1jlwqLSHXsjre/Y8=;
 b=q+VVdeM7/MKHhPCOpk/nD1fpsMnaevXK5KZfFjyN66CAQeNG2n2P3dT/ohRrpMrpq+
 GDvER7WR5aJgGg+AlakLYSfXrvF/gi6owbugRO0AWihOvUd58DZk7u9GguLfTBMEA30w
 xIZ2OP0mYaBxBXk26TLOWcskryTxhx0XzcXxjSyqgJDTMpASralVdBIVdRAmWLIFVjn/
 edNIE2aS8n/3+TtymHW1tAuaqD0ZsyYiWqsSJZKu+W61VPbgwCnu/nEeJeFtog255+0t
 VCFbXCmuMSNnR3UldMNIK0hMJX/aCOxnJw6ebvSVYSxq/Zkue/VytUVRpYOsW+q1BhN4
 lqBg==
X-Gm-Message-State: AOJu0YzLGBt+77Gbw1aJ/FZRlb1BKwv/23QRNFKeO4eK7uysG/u4UfAe
 49JgkzG8T3urxvVMFt/XRVV9TgCySnFl91qE1XhWrIo5Ce42YVqlv1iM0CXJcBedJqSAR9jmatO
 I
X-Gm-Gg: ASbGncvKP1NdB3nlXGTL0KDSK56XLcOTIHx7QRgJp+dVMcqkjJ/VywAtl1I8W4BYR5F
 EUCIu8/ocdguWbtdVcUrmYM5D78i52Z5SpSCypQUiQXfoW6/Pplh7ey1zycNlfv0olU3jTAGPAK
 9mqu6JC/EKLlsxBfo9kC0GjtsRNp+H3DC2TmR2RsuVGbm1qwh78wdTTaxBNvLId/n9ODVjxpRLV
 Xym7E+ZJ0m+8GnQbh5Woi4R1+jqUj8+fv8EM9HJEsCeP/390Oq7gNPW2iSpqhtDzF56EQoLlwLM
 K9JGbPUYATRKDwlRBg==
X-Google-Smtp-Source: AGHT+IFCrtrugg6CDPh5l4rvfEDGEOFHyZBre22XBCFoS/O2RIgo7gHRkByq41G0PZVvra4l4PhjZQ==
X-Received: by 2002:aa7:888c:0:b0:725:f212:12e5 with SMTP id
 d2e1a72fcca58-72abded14e5mr94762433b3a.24.1736237321174; 
 Tue, 07 Jan 2025 00:08:41 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad816305sm32624205b3a.31.2025.01.07.00.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:08:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 81/81] tcg: Merge INDEX_op_not_{i32,i64}
Date: Tue,  7 Jan 2025 00:01:12 -0800
Message-ID: <20250107080112.1175095-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 13 ++++++-------
 tcg/tcg-op.c             | 16 ++++++++--------
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                | 11 +++++------
 tcg/tci/tcg-target.c.inc |  2 +-
 6 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 9e148bb1b2..7177ed61b3 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -46,6 +46,7 @@ DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(neg, 1, 1, 0, TCG_OPF_INT)
 DEF(nor, 1, 2, 0, TCG_OPF_INT)
+DEF(not, 1, 1, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
@@ -95,7 +96,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
-DEF(not_i32, 1, 1, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
@@ -144,7 +144,6 @@ DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
-DEF(not_i64, 1, 1, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9af8f15235..3e0c77f8d4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -463,7 +463,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_rotl_i64:
         return rol64(x, y & 63);
 
-    CASE_OP_32_64_VEC(not):
+    case INDEX_op_not:
+    case INDEX_op_not_vec:
         return ~x;
 
     case INDEX_op_neg:
@@ -1088,12 +1089,9 @@ static bool fold_to_not(OptContext *ctx, TCGOp *op, int idx)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        not_op = INDEX_op_not_i32;
-        have_not = tcg_op_supported(INDEX_op_not_i32, TCG_TYPE_I32, 0);
-        break;
     case TCG_TYPE_I64:
-        not_op = INDEX_op_not_i64;
-        have_not = tcg_op_supported(INDEX_op_not_i64, TCG_TYPE_I64, 0);
+        not_op = INDEX_op_not;
+        have_not = tcg_op_supported(INDEX_op_not, ctx->type, 0);
         break;
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
@@ -2972,7 +2970,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_nor_vec:
             done = fold_nor(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(not):
+        case INDEX_op_not:
+        case INDEX_op_not_vec:
             done = fold_not(&ctx, op);
             break;
         case INDEX_op_or:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e0f8ab28b8..ddc1f465a4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -462,9 +462,9 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not_i32, TCG_TYPE_I32, 0)) {
+               tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
         /* Don't recurse with tcg_gen_not_i32.  */
-        tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg1);
+        tcg_gen_op2_i32(INDEX_op_not, ret, arg1);
     } else {
         tcg_gen_xor_i32(ret, arg1, tcg_constant_i32(arg2));
     }
@@ -472,8 +472,8 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (tcg_op_supported(INDEX_op_not_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg);
+    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
+        tcg_gen_op2_i32(INDEX_op_not, ret, arg);
     } else {
         tcg_gen_xori_i32(ret, arg, -1);
     }
@@ -1764,9 +1764,9 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not_i64, TCG_TYPE_I64, 0)) {
+               tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
         /* Don't recurse with tcg_gen_not_i64.  */
-        tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg1);
+        tcg_gen_op2_i64(INDEX_op_not, ret, arg1);
     } else {
         tcg_gen_xor_i64(ret, arg1, tcg_constant_i64(arg2));
     }
@@ -2254,8 +2254,8 @@ void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_not_i32(TCGV_LOW(ret), TCGV_LOW(arg));
         tcg_gen_not_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
-    } else if (tcg_op_supported(INDEX_op_not_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg);
+    } else if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
+        tcg_gen_op2_i64(INDEX_op_not, ret, arg);
     } else {
         tcg_gen_xori_i64(ret, arg, -1);
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c1c91b3373..5b04c4bef8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1011,8 +1011,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
-    OUTOP(INDEX_op_not_i32, TCGOutOpUnary, outop_not),
-    OUTOP(INDEX_op_not_i64, TCGOutOpUnary, outop_not),
+    OUTOP(INDEX_op_not, TCGOutOpUnary, outop_not),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
@@ -5454,8 +5453,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_neg:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
+    case INDEX_op_not:
         {
             const TCGOutOpUnary *out =
                 container_of(all_outop[op->opc], TCGOutOpUnary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 706932eef7..183b5ea477 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -581,6 +581,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = -regs[r1];
             break;
+        case INDEX_op_not:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = ~regs[r1];
+            break;
 
             /* Arithmetic operations (32 bit). */
 
@@ -705,10 +709,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = bswap32(regs[r1]);
             break;
 #endif
-        CASE_32_64(not)
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = ~regs[r1];
-            break;
 #if TCG_TARGET_REG_BITS == 64
             /* Load/store operations (64 bit). */
 
@@ -1109,6 +1109,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
 
     case INDEX_op_mov:
     case INDEX_op_neg:
+    case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
@@ -1116,8 +1117,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         tci_args_rr(insn, &r0, &r1);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index b781a2c5dd..249d881c40 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -761,7 +761,7 @@ static const TCGOutOpUnary outop_neg = {
 
 static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
-    tcg_out_op_rr(s, glue(INDEX_op_not_i,TCG_TARGET_REG_BITS), a0, a1);
+    tcg_out_op_rr(s, INDEX_op_not, a0, a1);
 }
 
 static const TCGOutOpUnary outop_not = {
-- 
2.43.0


