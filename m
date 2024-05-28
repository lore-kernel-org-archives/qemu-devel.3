Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172EAC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3Tb-00031u-OE; Tue, 28 May 2024 16:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TT-0002t1-Oj
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:12 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TH-0003by-EG
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:11 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-701b0b0be38so1068120b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928257; x=1717533057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7KiqDzN6bb5vBFvhOm/RJBOmgl/lpd8IobGZUwkIko=;
 b=eA4nAYIztgQUuhRjhKGe0IbgTtqMXLUdGnTngnjuUfv8kni57xqoBU1Ls5ENmwIKiC
 XuOdGQCHM91BR8sfGm1oG9VtLls5Z5CuigatTdWzhaZwLzfZi0Sue/lDtZDy0CAfkszg
 PBkDskwna61aiJcXxTAXe2uDkGzcgHs2hXMMyMkSUHt2QEndLlVEORLMV5acq5mC4kxH
 e7+TRHxDMxk97AHlUGvJJE2t9qwzT/uXWvL3C5EDYf8PWIovWGELUI+zZBGCiqG8piZ6
 v8QPoWNbWDrJbk467zzCOMJ/2XO0ppiizB1uMd/vacAYFVxG7cpAiO5pHLPJ6pp+S5zv
 BNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928257; x=1717533057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7KiqDzN6bb5vBFvhOm/RJBOmgl/lpd8IobGZUwkIko=;
 b=jZnS3tgocmjTOTpplcuJftVIAVhOMMvbHlV88afRhBbkt5QYpWja7NgD8ljBjYLsZd
 abNpC4c7/Wkw2r4ADS9Q27yU+3658yuAQkjrBl7iq1WA+Hit4wuXCscIvj5jBgKPLTsh
 cwXZct7IyST1EzQfvSVxNuRK6pxTh1fnLu8uCpeQ5xPS6rccYCTbp1bOlvtw0KjtCE9U
 UAz/c9jHmXzlLIvtLWKkJEQzwofxinDhIU4NfRWzaRdvRABCvvAXb+F9u+refDhSFxKX
 StzBILg1ogMSG/8VyRjgVNLzchg3cb4UUlds0Zk9IiX6WmDeSnGg8O3DPvv8Jd6ngL1v
 /cUg==
X-Gm-Message-State: AOJu0YyiyntHc93cTwA8KkA0QETsIw+cVJAbDGFDIWxtcbf8e12bgAdD
 WPgyt74euoTxl55p4pm93pgzlmQ0Ls02ZNz3ELJfeQ2NR7yvyJ1JEi/vHjBh7oQ+mX5QbAK14NX
 Q
X-Google-Smtp-Source: AGHT+IGV29ZI/aYDfTHI8ief1aJkd/9piaJJenhdhtBJlgyddL5txgWGaxxu/l8r/QLMt0nVjJu63w==
X-Received: by 2002:a05:6a00:301c:b0:6e8:f66f:6b33 with SMTP id
 d2e1a72fcca58-6f8f32aa343mr14971536b3a.4.1716928257198; 
 Tue, 28 May 2024 13:30:57 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:30:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 13/33] target/arm: Convert SQSHL, UQSHL to decodetree
Date: Tue, 28 May 2024 13:30:24 -0700
Message-Id: <20240528203044.612851-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++
 target/arm/tcg/translate-a64.c | 74 ++++++++++++++++++++++------------
 2 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 9e02776036..85caf37948 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -760,6 +760,8 @@ SSHL_s          0101 1110 111 ..... 01000 1 ..... ..... @rrr_d
 USHL_s          0111 1110 111 ..... 01000 1 ..... ..... @rrr_d
 SRSHL_s         0101 1110 111 ..... 01010 1 ..... ..... @rrr_d
 URSHL_s         0111 1110 111 ..... 01010 1 ..... ..... @rrr_d
+SQSHL_s         0101 1110 ..1 ..... 01001 1 ..... ..... @rrr_e
+UQSHL_s         0111 1110 ..1 ..... 01001 1 ..... ..... @rrr_e
 
 ### Advanced SIMD scalar pairwise
 
@@ -886,6 +888,8 @@ SSHL_v          0.00 1110 ..1 ..... 01000 1 ..... ..... @qrrr_e
 USHL_v          0.10 1110 ..1 ..... 01000 1 ..... ..... @qrrr_e
 SRSHL_v         0.00 1110 ..1 ..... 01010 1 ..... ..... @qrrr_e
 URSHL_v         0.10 1110 ..1 ..... 01010 1 ..... ..... @qrrr_e
+SQSHL_v         0.00 1110 ..1 ..... 01001 1 ..... ..... @qrrr_e
+UQSHL_v         0.10 1110 ..1 ..... 01001 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c88702dad6..97bd69eb3f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5119,6 +5119,49 @@ TRANS(USHL_s, do_int3_scalar_d, a, gen_ushl_i64)
 TRANS(SRSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_s64)
 TRANS(URSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_u64)
 
+typedef struct ENVScalar2 {
+    NeonGenTwoOpEnvFn *gen_bhs[3];
+    NeonGenTwo64OpEnvFn *gen_d;
+} ENVScalar2;
+
+static bool do_env_scalar2(DisasContext *s, arg_rrr_e *a, const ENVScalar2 *f)
+{
+    if (!fp_access_check(s)) {
+        return true;
+    }
+    if (a->esz == MO_64) {
+        TCGv_i64 t0 = read_fp_dreg(s, a->rn);
+        TCGv_i64 t1 = read_fp_dreg(s, a->rm);
+        f->gen_d(t0, tcg_env, t0, t1);
+        write_fp_dreg(s, a->rd, t0);
+    } else {
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+
+        read_vec_element_i32(s, t0, a->rn, 0, a->esz);
+        read_vec_element_i32(s, t1, a->rm, 0, a->esz);
+        f->gen_bhs[a->esz](t0, tcg_env, t0, t1);
+        write_fp_sreg(s, a->rd, t0);
+    }
+    return true;
+}
+
+static const ENVScalar2 f_scalar_sqshl = {
+    { gen_helper_neon_qshl_s8,
+      gen_helper_neon_qshl_s16,
+      gen_helper_neon_qshl_s32 },
+    gen_helper_neon_qshl_s64,
+};
+TRANS(SQSHL_s, do_env_scalar2, a, &f_scalar_sqshl)
+
+static const ENVScalar2 f_scalar_uqshl = {
+    { gen_helper_neon_qshl_u8,
+      gen_helper_neon_qshl_u16,
+      gen_helper_neon_qshl_u32 },
+    gen_helper_neon_qshl_u64,
+};
+TRANS(UQSHL_s, do_env_scalar2, a, &f_scalar_uqshl)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5368,6 +5411,8 @@ TRANS(SSHL_v, do_gvec_fn3, a, gen_gvec_sshl)
 TRANS(USHL_v, do_gvec_fn3, a, gen_gvec_ushl)
 TRANS(SRSHL_v, do_gvec_fn3, a, gen_gvec_srshl)
 TRANS(URSHL_v, do_gvec_fn3, a, gen_gvec_urshl)
+TRANS(SQSHL_v, do_gvec_fn3, a, gen_neon_sqshl)
+TRANS(UQSHL_v, do_gvec_fn3, a, gen_neon_uqshl)
 
 
 /*
@@ -9381,13 +9426,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
         }
         gen_cmtst_i64(tcg_rd, tcg_rn, tcg_rm);
         break;
-    case 0x9: /* SQSHL, UQSHL */
-        if (u) {
-            gen_helper_neon_qshl_u64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
-        } else {
-            gen_helper_neon_qshl_s64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
-        }
-        break;
     case 0xb: /* SQRSHL, UQRSHL */
         if (u) {
             gen_helper_neon_qrshl_u64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
@@ -9406,6 +9444,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     case 0x1: /* SQADD / UQADD */
     case 0x5: /* SQSUB / UQSUB */
     case 0x8: /* SSHL, USHL */
+    case 0x9: /* SQSHL, UQSHL */
     case 0xa: /* SRSHL, URSHL */
         g_assert_not_reached();
     }
@@ -9428,7 +9467,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     TCGv_i64 tcg_rd;
 
     switch (opcode) {
-    case 0x9: /* SQSHL, UQSHL */
     case 0xb: /* SQRSHL, UQRSHL */
         break;
     case 0x6: /* CMGT, CMHI */
@@ -9450,6 +9488,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x1: /* SQADD, UQADD */
     case 0x5: /* SQSUB, UQSUB */
     case 0x8: /* SSHL, USHL */
+    case 0x9: /* SQSHL, UQSHL */
     case 0xa: /* SRSHL, URSHL */
         unallocated_encoding(s);
         return;
@@ -9477,16 +9516,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         void (*genfn)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64, MemOp) = NULL;
 
         switch (opcode) {
-        case 0x9: /* SQSHL, UQSHL */
-        {
-            static NeonGenTwoOpEnvFn * const fns[3][2] = {
-                { gen_helper_neon_qshl_s8, gen_helper_neon_qshl_u8 },
-                { gen_helper_neon_qshl_s16, gen_helper_neon_qshl_u16 },
-                { gen_helper_neon_qshl_s32, gen_helper_neon_qshl_u32 },
-            };
-            genenvfn = fns[size][u];
-            break;
-        }
         case 0xb: /* SQRSHL, UQRSHL */
         {
             static NeonGenTwoOpEnvFn * const fns[3][2] = {
@@ -9510,6 +9539,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         default:
         case 0x1: /* SQADD, UQADD */
         case 0x5: /* SQSUB, UQSUB */
+        case 0x9: /* SQSHL, UQSHL */
             g_assert_not_reached();
         }
 
@@ -10927,6 +10957,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x01: /* SQADD, UQADD */
     case 0x05: /* SQSUB, UQSUB */
     case 0x08: /* SSHL, USHL */
+    case 0x09: /* SQSHL, UQSHL */
     case 0x0a: /* SRSHL, URSHL */
         unallocated_encoding(s);
         return;
@@ -10937,13 +10968,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x09: /* SQSHL, UQSHL */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_neon_uqshl, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_neon_sqshl, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


