Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88D2C25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATk-00089e-3S; Thu, 23 May 2024 11:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATg-000854-RF
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:36 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATY-0002WE-Dv
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:36 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e1fa1f1d9bso109731281fa.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478525; x=1717083325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6PiOke/P0EHd2+VejL1Uhq9zA4XZ/Rv2AOL2z7Js64A=;
 b=tza7ERBF0Egz+aGiSkeCoaXxadOKMGhpz8u1QhTtiiOPyLoJBirSOdXgP9yPlyFde3
 7nhrU58jT1ZXLfBAKdAJuZfhNSkXyfEUVMIyttv4tgGSePSXr8pUivEwVliZmSfXHaXB
 dKVuYNsY8ooUNTdSYPQ87cMfibEBdokJiz3sD3x7voR4+lKIXPWBboutMIg190mlhX1i
 Qn2EGR2I0uV/+wqhQriGtLkvRub4HtNwVuHFHhuygQ9eNVYTWeWevMASFyonHGkWAIIC
 BvHg4tSrtNturmOOYjj0ZEYMd3F+oRzL9TKf2Fh0EmlXnMV+nv73Faa6BYorF2PpsDua
 dVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478525; x=1717083325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6PiOke/P0EHd2+VejL1Uhq9zA4XZ/Rv2AOL2z7Js64A=;
 b=qGcLoSTvckj/bqeu4tQSaHgkfrBbFm7Peb862w19jf2UuAoxCXisuBfbbl7ebfw3V/
 f3GrjyyD7ouv5qHZ9MVTHe9A9T6jfzGVhFwADogUV1XwE0zlr7YD2MgKYvDUwAWbNwAi
 sehf/hHt5xRw93Am0O3k+t51plmNaV4DZNs2tnqvsIbADS8iS9NAJlFQUuzFR1o8+wca
 nPSDwdSH8o+9sjOcCqTpbvAHBUiHRTutBE/DsLtYjmhdgHzmwbBbJkZcXpsP7Sm5wQZs
 TwmYgqAqu2UpHB1sZCa/RvOwM6IHohN9M3KNTLeFuz7BqVzd9YZRJBGv0o8pGeTTidzL
 Rtgw==
X-Gm-Message-State: AOJu0YyTswB0iUHmHNVJOmAwR7vXMcH8RZwbOGWIOdOloRn2AG1Or40X
 VcRWMs2bAAtW+/niiHGvnKXW2W1APne73zzTOgD/rdWJY3HK9w9O0JCDjSOL1eF4Pdh4uEZGp6P
 L
X-Google-Smtp-Source: AGHT+IHgrDFXWK+2dLs9mEVWab/uaodr3c/vHUkQDkMVwSr05elN+aMmoBgc/VzNJh94bY6KQzr4DA==
X-Received: by 2002:a2e:97c5:0:b0:2e5:2eaf:b09c with SMTP id
 38308e7fff4ca-2e949540cc6mr45180911fa.37.1716478525239; 
 Thu, 23 May 2024 08:35:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/37] target/arm: Convert FMLAL, FMLSL to decodetree
Date: Thu, 23 May 2024 16:35:04 +0100
Message-Id: <20240523153505.2900433-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240506010403.6204-29-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  10 +++
 target/arm/tcg/translate-a64.c | 144 ++++++++++-----------------------
 2 files changed, 51 insertions(+), 103 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 22dfe8568d6..7e993ed345f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -797,6 +797,11 @@ FMLA_v          0.00 1110 0.1 ..... 11001 1 ..... ..... @qrrr_sd
 FMLS_v          0.00 1110 110 ..... 00001 1 ..... ..... @qrrr_h
 FMLS_v          0.00 1110 1.1 ..... 11001 1 ..... ..... @qrrr_sd
 
+FMLAL_v         0.00 1110 001 ..... 11101 1 ..... ..... @qrrr_h
+FMLSL_v         0.00 1110 101 ..... 11101 1 ..... ..... @qrrr_h
+FMLAL2_v        0.10 1110 001 ..... 11001 1 ..... ..... @qrrr_h
+FMLSL2_v        0.10 1110 101 ..... 11001 1 ..... ..... @qrrr_h
+
 FCMEQ_v         0.00 1110 010 ..... 00100 1 ..... ..... @qrrr_h
 FCMEQ_v         0.00 1110 0.1 ..... 11100 1 ..... ..... @qrrr_sd
 
@@ -877,3 +882,8 @@ FMLS_vi         0.00 1111 11 0 ..... 0101 . 0 ..... .....   @qrrx_d
 FMULX_vi        0.10 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
 FMULX_vi        0.10 1111 10 . ..... 1001 . 0 ..... .....   @qrrx_s
 FMULX_vi        0.10 1111 11 0 ..... 1001 . 0 ..... .....   @qrrx_d
+
+FMLAL_vi        0.00 1111 10 .. .... 0000 . 0 ..... .....   @qrrx_h
+FMLSL_vi        0.00 1111 10 .. .... 0100 . 0 ..... .....   @qrrx_h
+FMLAL2_vi       0.10 1111 10 .. .... 1000 . 0 ..... .....   @qrrx_h
+FMLSL2_vi       0.10 1111 10 .. .... 1100 . 0 ..... .....   @qrrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3fa36566b19..11afa5c4f6a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5256,6 +5256,24 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnmp[3] = {
 };
 TRANS(FMINNMP_v, do_fp3_vector, a, f_vector_fminnmp)
 
+static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
+{
+    if (fp_access_check(s)) {
+        int data = (is_2 << 1) | is_s;
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm), tcg_env,
+                           a->q ? 16 : 8, vec_full_reg_size(s),
+                           data, gen_helper_gvec_fmlal_a64);
+    }
+    return true;
+}
+
+TRANS_FEAT(FMLAL_v, aa64_fhm, do_fmlal, a, false, false)
+TRANS_FEAT(FMLSL_v, aa64_fhm, do_fmlal, a, true, false)
+TRANS_FEAT(FMLAL2_v, aa64_fhm, do_fmlal, a, false, true)
+TRANS_FEAT(FMLSL2_v, aa64_fhm, do_fmlal, a, true, true)
+
 TRANS(ADDP_v, do_gvec_fn3, a, gen_gvec_addp)
 TRANS(SMAXP_v, do_gvec_fn3_no64, a, gen_gvec_smaxp)
 TRANS(SMINP_v, do_gvec_fn3_no64, a, gen_gvec_sminp)
@@ -5447,6 +5465,24 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
 TRANS(FMLA_vi, do_fmla_vector_idx, a, false)
 TRANS(FMLS_vi, do_fmla_vector_idx, a, true)
 
+static bool do_fmlal_idx(DisasContext *s, arg_qrrx_e *a, bool is_s, bool is_2)
+{
+    if (fp_access_check(s)) {
+        int data = (a->idx << 2) | (is_2 << 1) | is_s;
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm), tcg_env,
+                           a->q ? 16 : 8, vec_full_reg_size(s),
+                           data, gen_helper_gvec_fmlal_idx_a64);
+    }
+    return true;
+}
+
+TRANS_FEAT(FMLAL_vi, aa64_fhm, do_fmlal_idx, a, false, false)
+TRANS_FEAT(FMLSL_vi, aa64_fhm, do_fmlal_idx, a, true, false)
+TRANS_FEAT(FMLAL2_vi, aa64_fhm, do_fmlal_idx, a, false, true)
+TRANS_FEAT(FMLSL2_vi, aa64_fhm, do_fmlal_idx, a, true, true)
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -10904,78 +10940,6 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Floating point op subgroup of C3.6.16. */
-static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
-{
-    /* For floating point ops, the U, size[1] and opcode bits
-     * together indicate the operation. size[0] indicates single
-     * or double.
-     */
-    int fpopcode = extract32(insn, 11, 5)
-        | (extract32(insn, 23, 1) << 5)
-        | (extract32(insn, 29, 1) << 6);
-    int is_q = extract32(insn, 30, 1);
-    int size = extract32(insn, 22, 1);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    if (size == 1 && !is_q) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (fpopcode) {
-    case 0x1d: /* FMLAL  */
-    case 0x3d: /* FMLSL  */
-    case 0x59: /* FMLAL2 */
-    case 0x79: /* FMLSL2 */
-        if (size & 1 || !dc_isar_feature(aa64_fhm, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (fp_access_check(s)) {
-            int is_s = extract32(insn, 23, 1);
-            int is_2 = extract32(insn, 29, 1);
-            int data = (is_2 << 1) | is_s;
-            tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
-                               vec_full_reg_offset(s, rn),
-                               vec_full_reg_offset(s, rm), tcg_env,
-                               is_q ? 16 : 8, vec_full_reg_size(s),
-                               data, gen_helper_gvec_fmlal_a64);
-        }
-        return;
-
-    default:
-    case 0x18: /* FMAXNM */
-    case 0x19: /* FMLA */
-    case 0x1a: /* FADD */
-    case 0x1b: /* FMULX */
-    case 0x1c: /* FCMEQ */
-    case 0x1e: /* FMAX */
-    case 0x1f: /* FRECPS */
-    case 0x38: /* FMINNM */
-    case 0x39: /* FMLS */
-    case 0x3a: /* FSUB */
-    case 0x3e: /* FMIN */
-    case 0x3f: /* FRSQRTS */
-    case 0x58: /* FMAXNMP */
-    case 0x5a: /* FADDP */
-    case 0x5b: /* FMUL */
-    case 0x5c: /* FCMGE */
-    case 0x5d: /* FACGE */
-    case 0x5e: /* FMAXP */
-    case 0x5f: /* FDIV */
-    case 0x78: /* FMINNMP */
-    case 0x7a: /* FABD */
-    case 0x7d: /* FACGT */
-    case 0x7c: /* FCMGT */
-    case 0x7e: /* FMINP */
-        unallocated_encoding(s);
-        return;
-    }
-}
-
 /* Integer op subgroup of C3.6.16. */
 static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 {
@@ -11244,16 +11208,13 @@ static void disas_simd_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x3: /* logic ops */
         disas_simd_3same_logic(s, insn);
         break;
-    case 0x18 ... 0x31:
-        /* floating point ops, sz[1] and U are part of opcode */
-        disas_simd_3same_float(s, insn);
-        break;
     default:
         disas_simd_3same_int(s, insn);
         break;
     case 0x14: /* SMAXP, UMAXP */
     case 0x15: /* SMINP, UMINP */
     case 0x17: /* ADDP */
+    case 0x18 ... 0x31: /* floating point ops */
         unallocated_encoding(s);
         break;
     }
@@ -12519,22 +12480,15 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
         is_fp = 2;
         break;
-    case 0x00: /* FMLAL */
-    case 0x04: /* FMLSL */
-    case 0x18: /* FMLAL2 */
-    case 0x1c: /* FMLSL2 */
-        if (is_scalar || size != MO_32 || !dc_isar_feature(aa64_fhm, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        size = MO_16;
-        /* is_fp, but we pass tcg_env not fp_status.  */
-        break;
     default:
+    case 0x00: /* FMLAL */
     case 0x01: /* FMLA */
+    case 0x04: /* FMLSL */
     case 0x05: /* FMLS */
     case 0x09: /* FMUL */
+    case 0x18: /* FMLAL2 */
     case 0x19: /* FMULX */
+    case 0x1c: /* FMLSL2 */
         unallocated_encoding(s);
         return;
     }
@@ -12653,22 +12607,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
         return;
 
-    case 0x00: /* FMLAL */
-    case 0x04: /* FMLSL */
-    case 0x18: /* FMLAL2 */
-    case 0x1c: /* FMLSL2 */
-        {
-            int is_s = extract32(opcode, 2, 1);
-            int is_2 = u;
-            int data = (index << 2) | (is_2 << 1) | is_s;
-            tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
-                               vec_full_reg_offset(s, rn),
-                               vec_full_reg_offset(s, rm), tcg_env,
-                               is_q ? 16 : 8, vec_full_reg_size(s),
-                               data, gen_helper_gvec_fmlal_idx_a64);
-        }
-        return;
-
     case 0x08: /* MUL */
         if (!is_long && !is_scalar) {
             static gen_helper_gvec_3 * const fns[3] = {
-- 
2.34.1


