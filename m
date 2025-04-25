Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C34DC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RAL-0002M6-ER; Fri, 25 Apr 2025 18:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7o-0005eS-6p
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:24 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7j-0001Nx-JC
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:23 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af6a315b491so2681549a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618537; x=1746223337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GMzNZGF3Jy3ATjjKaE/l0/MMwfUqafM/ks97nr/OJY=;
 b=loKoqkSonm+CPke6Bk+FRDDBheyf/+HGCl19tv9ijJsLYmN4fNUCgrQBXmqpJPMtYR
 VFp97c+VwR+hU3aZy8BnLPVi4G9zxDqSnJwy7t9gNn8hr0usen616vhtJvVZZ54WFUB7
 /EpNgUNXCtVz/Cg8w5Yqp/tsJq5xJ7U5AXx2Sm4JPljlUJiL8A2WIsXaLBUj5NBhFNt7
 NGE1/zEajrCzKWX6jKt2NIIQTZRKj6N8J86m5MFFJlk7J3nDljXsumfoqnkQypJ8SeG6
 h0ObnNXq/Sma+10Ta6/EuMtHPQZvKHvmKaqz82MiuF5KXzeidtr7hHJJR+R2m/mu8DYp
 CSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618537; x=1746223337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GMzNZGF3Jy3ATjjKaE/l0/MMwfUqafM/ks97nr/OJY=;
 b=VAeBfpKbr+p4U4nbv2RyZCpHQHVmM4qCCXtuA3r1MIbj6nuSAPdFKS4Nl145hLhIvc
 dgCGJt1JqbsNUlvwjYUJlWKNW1jWMBr9WGzq/EVWJiwpwX/URZNAjG3Ds7EG1Rame2K1
 qT7Pj73BPl7Gf05Nhu8EXi8SwisqUUNQs6GLgVE2G47b65tZY7uHTAgv03UL1HNkNess
 LFg8N5aD9IKyuibSOq4agmv9P3CDjB+wMDCrB395/pYCd2oRHoQElCe23cApJSs3xuIZ
 oUp/e214UHKfxQl5SU6wNzS6a8L6/cFdWc4c/s6Uo6yq7vquJSEtxKWDWi9AVkd5UOSE
 8kwQ==
X-Gm-Message-State: AOJu0YwEz7GSb8FMkBz6cvjRNwVkBCaagE+xN5tghXMmpB83ZPIIEOqc
 KXUFdktbQXe+OGLjg5pJ+D/EGe3ark7PPD158Dc1bVkMJf4XzrdZA3Fz9JuY0GT2MRTtiCDWUFI
 d
X-Gm-Gg: ASbGncuHI+tedJXjitdi6pGOzAGL+UOfIsWuqKD8Ef8miKfkIXg1xkD2RLEFuWE4F9E
 81n1F2jPP12hfFwHI/X2eILSOA6FNi0oXCIYTZA7Kw5FaxKnN23R700sMnA3XuJeCj1A+JrdCuj
 kn1gsnqT1LemsMdtaFT4jhGsyoyN0FfSiMPsjD+ymSPkMf9CrCHDjbM3Jut69kqUvVMVI44dkEX
 2VoZJ4IO9SFgeIAl5nqKu410IjfjV443ljGWUWGRV09+LOemF98ZkJBYeqPhqHZ4i/qjQ9fzgLh
 u+Rw+GV79UV3j+IeuKby3daOdxWkmLcwKiUzuLV3crFarB7ZFHcyJcR7fxJN8fP0SaLdR6yseiA
 =
X-Google-Smtp-Source: AGHT+IEfW5bmsZYNwPLNkLjiX/G0bog9p6bZQhSd6g0Qvw1loPkFkJl4x9vDezC/k1iR9PbBagb8TQ==
X-Received: by 2002:a17:90b:586f:b0:2ee:ad18:b309 with SMTP id
 98e67ed59e1d1-30a01300251mr1624297a91.3.1745618537522; 
 Fri, 25 Apr 2025 15:02:17 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 109/159] tcg: Merge INDEX_op_extract2_{i32,i64}
Date: Fri, 25 Apr 2025 14:54:03 -0700
Message-ID: <20250425215454.886111-110-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h      |  5 +----
 tcg/optimize.c             | 10 +++++-----
 tcg/tcg-op.c               | 16 ++++++++--------
 tcg/tcg.c                  |  6 ++----
 docs/devel/tcg-ops.rst     |  4 ++--
 target/i386/tcg/emit.c.inc | 12 +-----------
 6 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index c6848b3c63..1f995c54be 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -56,6 +56,7 @@ DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(extract, 1, 1, 2, TCG_OPF_INT)
+DEF(extract2, 1, 2, 1, TCG_OPF_INT)
 DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(muls2, 2, 2, 0, TCG_OPF_INT)
@@ -90,8 +91,6 @@ DEF(ld_i32, 1, 1, 1, 0)
 DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
-/* shifts/rotates */
-DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(add2_i32, 2, 4, 0, 0)
 DEF(sub2_i32, 2, 4, 0, 0)
@@ -110,8 +109,6 @@ DEF(st8_i64, 0, 2, 1, 0)
 DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
-/* shifts/rotates */
-DEF(extract2_i64, 1, 2, 1, 0)
 
 /* size changing ops */
 DEF(ext_i32_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index acc566ed76..a728a4b2fa 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1873,12 +1873,12 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
         uint64_t v2 = arg_info(op->args[2])->val;
         int shr = op->args[3];
 
-        if (op->opc == INDEX_op_extract2_i64) {
-            v1 >>= shr;
-            v2 <<= 64 - shr;
-        } else {
+        if (ctx->type == TCG_TYPE_I32) {
             v1 = (uint32_t)v1 >> shr;
             v2 = (uint64_t)((int32_t)v2 << (32 - shr));
+        } else {
+            v1 >>= shr;
+            v2 <<= 64 - shr;
         }
         return tcg_opt_gen_movi(ctx, op, op->args[0], v1 | v2);
     }
@@ -2878,7 +2878,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_extract:
             done = fold_extract(&ctx, op);
             break;
-        CASE_OP_32_64(extract2):
+        case INDEX_op_extract2:
             done = fold_extract2(&ctx, op);
             break;
         case INDEX_op_ext_i32_i64:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5f95350d5d..edbb214f7c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -921,7 +921,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
 
     t1 = tcg_temp_ebb_new_i32();
 
-    if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
+    if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
         if (ofs + len == 32) {
             tcg_gen_shli_i32(t1, arg1, len);
             tcg_gen_extract2_i32(ret, t1, arg2, len);
@@ -1077,8 +1077,8 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
         tcg_gen_mov_i32(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i32(ret, al, ofs);
-    } else if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4i_i32(INDEX_op_extract2_i32, ret, al, ah, ofs);
+    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
+        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_shri_i32(t0, al, ofs);
@@ -1799,7 +1799,7 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
             tcg_gen_movi_i32(TCGV_LOW(ret), 0);
         }
     } else if (right) {
-        if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
+        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
             tcg_gen_extract2_i32(TCGV_LOW(ret),
                                  TCGV_LOW(arg1), TCGV_HIGH(arg1), c);
         } else {
@@ -1813,7 +1813,7 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
             tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
         }
     } else {
-        if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
+        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
             tcg_gen_extract2_i32(TCGV_HIGH(ret),
                                  TCGV_LOW(arg1), TCGV_HIGH(arg1), 32 - c);
         } else {
@@ -2553,7 +2553,7 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
 
     t1 = tcg_temp_ebb_new_i64();
 
-    if (tcg_op_supported(INDEX_op_extract2_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
         if (ofs + len == 64) {
             tcg_gen_shli_i64(t1, arg1, len);
             tcg_gen_extract2_i64(ret, t1, arg2, len);
@@ -2781,8 +2781,8 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
         tcg_gen_mov_i64(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i64(ret, al, ofs);
-    } else if (tcg_op_supported(INDEX_op_extract2_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4i_i64(INDEX_op_extract2_i64, ret, al, ah, ofs);
+    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
+        tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_shri_i64(t0, al, ofs);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3fbbe3bd83..037b5a4664 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1146,8 +1146,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_extract, TCGOutOpExtract, outop_extract),
-    OUTOP(INDEX_op_extract2_i32, TCGOutOpExtract2, outop_extract2),
-    OUTOP(INDEX_op_extract2_i64, TCGOutOpExtract2, outop_extract2),
+    OUTOP(INDEX_op_extract2, TCGOutOpExtract2, outop_extract2),
     OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
@@ -5597,8 +5596,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_extract2_i32:
-    case INDEX_op_extract2_i64:
+    case INDEX_op_extract2:
         {
             const TCGOutOpExtract2 *out = &outop_extract2;
 
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index aea8a897bd..9392d88069 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -476,9 +476,9 @@ Misc
        |
        | (using an arithmetic right shift) on TCG_TYPE_I32.
 
-   * - extract2_i32/i64 *dest*, *t1*, *t2*, *pos*
+   * - extract2 *dest*, *t1*, *t2*, *pos*
 
-     - | For N = {32,64}, extract an N-bit quantity from the concatenation
+     - | For TCG_TYPE_I{N}, extract an N-bit quantity from the concatenation
          of *t2*:*t1*, beginning at *pos*. The tcg_gen_extract2_{i32,i64} expander
          accepts 0 <= *pos* <= N as inputs. The backend code generator will
          not see either 0 or N as inputs for these opcodes.
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 4e09e96fc1..3cd2a381bb 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -19,16 +19,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-/*
- * Sometimes, knowing what the backend has can produce better code.
- * The exact opcode to check depends on 32- vs. 64-bit.
- */
-#ifdef TARGET_X86_64
-#define INDEX_op_extract2_tl            INDEX_op_extract2_i64
-#else
-#define INDEX_op_extract2_tl            INDEX_op_extract2_i32
-#endif
-
 #define MMX_OFFSET(reg)                        \
   ({ assert((reg) >= 0 && (reg) <= 7);         \
      offsetof(CPUX86State, fpregs[reg].mmx); })
@@ -3023,7 +3013,7 @@ static void gen_PMOVMSKB(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_ld8u_tl(s->T0, tcg_env, offsetof(CPUX86State, xmm_t0.ZMM_B(vec_len - 1)));
     while (vec_len > 8) {
         vec_len -= 8;
-        if (tcg_op_supported(INDEX_op_extract2_tl, TCG_TYPE_TL, 0)) {
+        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_TL, 0)) {
             /*
              * Load the next byte of the result into the high byte of T.
              * TCG does a similar expansion of deposit to shl+extract2; by
-- 
2.43.0


