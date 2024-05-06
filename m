Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB243C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmd-0007sR-G4; Sun, 05 May 2024 21:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmU-0007nA-JL
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:38 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmD-0002T9-VE
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:38 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2b43490e0e2so904113a91.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957458; x=1715562258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGPndtGWlkLDXJmnPlFT/i8yOT+LICCQYdJfFN7NVPY=;
 b=Jjjvp1XS4OcjG767FQdnazbXDKWDtR32BPtp36L1aFb8pHIVZ4IP52HoSp48ZWXAUM
 91sKSPsNPqjkuDCwflgpHhY5IjS3uH9vwTZcJdO2K4N+MI9nUA7UdV9FShEq2hiJ/BVJ
 IpTZK398Z0bNS7AnwmkFGr41lFXVvrcL6XNAHLyNkguNmS4xug1yndQzpL6gtvlRx7O/
 qYmLdvct5g/GXWVM5oKe1aLPUGkGZ0q7GR+EcSMz5IHAjJzmlB6bfXPUBjn637zt/2XZ
 +I3/bnBSRGT5Z9P6auwwyh2vQlqEwsdsBHsoFvfWWDGOuPV4Pjbn5oTbA9btobVMC+K8
 Wx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957458; x=1715562258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JGPndtGWlkLDXJmnPlFT/i8yOT+LICCQYdJfFN7NVPY=;
 b=s+FRQZmSJOPF0x082cQK9aG1KeHyJoSD80A+qjQM/d47W9FDhCqxbRdo1lImXAd44G
 ddmryrASqe/lT850TawLwO501NUqurWMozXIRnU9lTWGzNNNwF1wvC/cwOOZW1oryysj
 9UvBM8DciorppKghC+DLyphmzzp24qO2n+v2OA5yCcu5CsI2wVzt49/ZCPYMEu9380gx
 2DTlAEvmImtOXV7zm0YWRnhYcETjdSvQMS5SqMkSJkMjjzwmLBaC1PS/fWuJDPPBBCzG
 fUUSrA/XwqmG3hXt+eMwH091eOg6W1oG4HhH74W073cLz8grotg/7CTrZJ9Rl3Gyf74b
 nTfA==
X-Gm-Message-State: AOJu0Ywwekgp1ouCSmHAda5Vm/KS/7ur883VUiNpZBG1oAZH7dpes7FO
 4yFi0b8b3pXLxE8Qfz/JGncIfUEMSw8K8EqsH6Hm3ucZ0eU0916wv7l6nWC2s6Vi3vUV0LIZf0U
 z
X-Google-Smtp-Source: AGHT+IG17kyIhCDHFjXHcMnTQG4Dv/XuY1yqtGEca5TSwlaKu35i9eUFg1MAirZAn2bNHzAPRIvefg==
X-Received: by 2002:a17:90a:b118:b0:2ad:51d6:d578 with SMTP id
 z24-20020a17090ab11800b002ad51d6d578mr6996919pjq.10.1714957458399; 
 Sun, 05 May 2024 18:04:18 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 15/57] target/arm: Expand vfp neg and abs inline
Date: Sun,  5 May 2024 18:03:21 -0700
Message-Id: <20240506010403.6204-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/helper.h            |  6 ----
 target/arm/tcg/translate.h     | 30 +++++++++++++++++++
 target/arm/tcg/translate-a64.c | 44 +++++++++++++--------------
 target/arm/tcg/translate-vfp.c | 54 +++++++++++++++++-----------------
 target/arm/vfp_helper.c        | 30 -------------------
 5 files changed, 79 insertions(+), 85 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 7ee15b9651..0fd01c9c52 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -132,12 +132,6 @@ DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, ptr)
 DEF_HELPER_3(vfp_minnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_minnums, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
-DEF_HELPER_1(vfp_negh, f16, f16)
-DEF_HELPER_1(vfp_negs, f32, f32)
-DEF_HELPER_1(vfp_negd, f64, f64)
-DEF_HELPER_1(vfp_absh, f16, f16)
-DEF_HELPER_1(vfp_abss, f32, f32)
-DEF_HELPER_1(vfp_absd, f64, f64)
 DEF_HELPER_2(vfp_sqrth, f16, f16, env)
 DEF_HELPER_2(vfp_sqrts, f32, f32, env)
 DEF_HELPER_2(vfp_sqrtd, f64, f64, env)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index ecfa242eef..b05a9eb668 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -406,6 +406,36 @@ static inline void gen_swstep_exception(DisasContext *s, int isv, int ex)
  */
 uint64_t vfp_expand_imm(int size, uint8_t imm8);
 
+static inline void gen_vfp_absh(TCGv_i32 d, TCGv_i32 s)
+{
+    tcg_gen_andi_i32(d, s, INT16_MAX);
+}
+
+static inline void gen_vfp_abss(TCGv_i32 d, TCGv_i32 s)
+{
+    tcg_gen_andi_i32(d, s, INT32_MAX);
+}
+
+static inline void gen_vfp_absd(TCGv_i64 d, TCGv_i64 s)
+{
+    tcg_gen_andi_i64(d, s, INT64_MAX);
+}
+
+static inline void gen_vfp_negh(TCGv_i32 d, TCGv_i32 s)
+{
+    tcg_gen_xori_i32(d, s, 1u << 15);
+}
+
+static inline void gen_vfp_negs(TCGv_i32 d, TCGv_i32 s)
+{
+    tcg_gen_xori_i32(d, s, 1u << 31);
+}
+
+static inline void gen_vfp_negd(TCGv_i64 d, TCGv_i64 s)
+{
+    tcg_gen_xori_i64(d, s, 1ull << 63);
+}
+
 /* Vector operations shared between ARM and AArch64.  */
 void gen_gvec_ceq0(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                    uint32_t opr_sz, uint32_t max_sz);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c7b379385f..e6c3da5b2a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6592,10 +6592,10 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
         tcg_gen_mov_i32(tcg_res, tcg_op);
         break;
     case 0x1: /* FABS */
-        tcg_gen_andi_i32(tcg_res, tcg_op, 0x7fff);
+        gen_vfp_absh(tcg_res, tcg_op);
         break;
     case 0x2: /* FNEG */
-        tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
+        gen_vfp_negh(tcg_res, tcg_op);
         break;
     case 0x3: /* FSQRT */
         fpst = fpstatus_ptr(FPST_FPCR_F16);
@@ -6646,10 +6646,10 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
         tcg_gen_mov_i32(tcg_res, tcg_op);
         goto done;
     case 0x1: /* FABS */
-        gen_helper_vfp_abss(tcg_res, tcg_op);
+        gen_vfp_abss(tcg_res, tcg_op);
         goto done;
     case 0x2: /* FNEG */
-        gen_helper_vfp_negs(tcg_res, tcg_op);
+        gen_vfp_negs(tcg_res, tcg_op);
         goto done;
     case 0x3: /* FSQRT */
         gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
@@ -6721,10 +6721,10 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
 
     switch (opcode) {
     case 0x1: /* FABS */
-        gen_helper_vfp_absd(tcg_res, tcg_op);
+        gen_vfp_absd(tcg_res, tcg_op);
         goto done;
     case 0x2: /* FNEG */
-        gen_helper_vfp_negd(tcg_res, tcg_op);
+        gen_vfp_negd(tcg_res, tcg_op);
         goto done;
     case 0x3: /* FSQRT */
         gen_helper_vfp_sqrtd(tcg_res, tcg_op, tcg_env);
@@ -6950,7 +6950,7 @@ static void handle_fp_2src_single(DisasContext *s, int opcode,
     switch (opcode) {
     case 0x8: /* FNMUL */
         gen_helper_vfp_muls(tcg_res, tcg_op1, tcg_op2, fpst);
-        gen_helper_vfp_negs(tcg_res, tcg_res);
+        gen_vfp_negs(tcg_res, tcg_res);
         break;
     default:
     case 0x0: /* FMUL */
@@ -6984,7 +6984,7 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
     switch (opcode) {
     case 0x8: /* FNMUL */
         gen_helper_vfp_muld(tcg_res, tcg_op1, tcg_op2, fpst);
-        gen_helper_vfp_negd(tcg_res, tcg_res);
+        gen_vfp_negd(tcg_res, tcg_res);
         break;
     default:
     case 0x0: /* FMUL */
@@ -7018,7 +7018,7 @@ static void handle_fp_2src_half(DisasContext *s, int opcode,
     switch (opcode) {
     case 0x8: /* FNMUL */
         gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
-        tcg_gen_xori_i32(tcg_res, tcg_res, 0x8000);
+        gen_vfp_negh(tcg_res, tcg_res);
         break;
     default:
     case 0x0: /* FMUL */
@@ -7103,11 +7103,11 @@ static void handle_fp_3src_single(DisasContext *s, bool o0, bool o1,
      * flipped if it is a negated-input.
      */
     if (o1 == true) {
-        gen_helper_vfp_negs(tcg_op3, tcg_op3);
+        gen_vfp_negs(tcg_op3, tcg_op3);
     }
 
     if (o0 != o1) {
-        gen_helper_vfp_negs(tcg_op1, tcg_op1);
+        gen_vfp_negs(tcg_op1, tcg_op1);
     }
 
     gen_helper_vfp_muladds(tcg_res, tcg_op1, tcg_op2, tcg_op3, fpst);
@@ -7135,11 +7135,11 @@ static void handle_fp_3src_double(DisasContext *s, bool o0, bool o1,
      * flipped if it is a negated-input.
      */
     if (o1 == true) {
-        gen_helper_vfp_negd(tcg_op3, tcg_op3);
+        gen_vfp_negd(tcg_op3, tcg_op3);
     }
 
     if (o0 != o1) {
-        gen_helper_vfp_negd(tcg_op1, tcg_op1);
+        gen_vfp_negd(tcg_op1, tcg_op1);
     }
 
     gen_helper_vfp_muladdd(tcg_res, tcg_op1, tcg_op2, tcg_op3, fpst);
@@ -9240,7 +9240,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             switch (fpopcode) {
             case 0x39: /* FMLS */
                 /* As usual for ARM, separate negation for fused multiply-add */
-                gen_helper_vfp_negd(tcg_op1, tcg_op1);
+                gen_vfp_negd(tcg_op1, tcg_op1);
                 /* fall through */
             case 0x19: /* FMLA */
                 read_vec_element(s, tcg_res, rd, pass, MO_64);
@@ -9264,7 +9264,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 break;
             case 0x7a: /* FABD */
                 gen_helper_vfp_subd(tcg_res, tcg_op1, tcg_op2, fpst);
-                gen_helper_vfp_absd(tcg_res, tcg_res);
+                gen_vfp_absd(tcg_res, tcg_res);
                 break;
             case 0x7c: /* FCMGT */
                 gen_helper_neon_cgt_f64(tcg_res, tcg_op1, tcg_op2, fpst);
@@ -9298,7 +9298,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             switch (fpopcode) {
             case 0x39: /* FMLS */
                 /* As usual for ARM, separate negation for fused multiply-add */
-                gen_helper_vfp_negs(tcg_op1, tcg_op1);
+                gen_vfp_negs(tcg_op1, tcg_op1);
                 /* fall through */
             case 0x19: /* FMLA */
                 read_vec_element_i32(s, tcg_res, rd, pass, MO_32);
@@ -9322,7 +9322,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 break;
             case 0x7a: /* FABD */
                 gen_helper_vfp_subs(tcg_res, tcg_op1, tcg_op2, fpst);
-                gen_helper_vfp_abss(tcg_res, tcg_res);
+                gen_vfp_abss(tcg_res, tcg_res);
                 break;
             case 0x7c: /* FCMGT */
                 gen_helper_neon_cgt_f32(tcg_res, tcg_op1, tcg_op2, fpst);
@@ -9735,10 +9735,10 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         }
         break;
     case 0x2f: /* FABS */
-        gen_helper_vfp_absd(tcg_rd, tcg_rn);
+        gen_vfp_absd(tcg_rd, tcg_rn);
         break;
     case 0x6f: /* FNEG */
-        gen_helper_vfp_negd(tcg_rd, tcg_rn);
+        gen_vfp_negd(tcg_rd, tcg_rn);
         break;
     case 0x7f: /* FSQRT */
         gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_env);
@@ -12561,10 +12561,10 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     }
                     break;
                 case 0x2f: /* FABS */
-                    gen_helper_vfp_abss(tcg_res, tcg_op);
+                    gen_vfp_abss(tcg_res, tcg_op);
                     break;
                 case 0x6f: /* FNEG */
-                    gen_helper_vfp_negs(tcg_res, tcg_op);
+                    gen_vfp_negs(tcg_res, tcg_op);
                     break;
                 case 0x7f: /* FSQRT */
                     gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
@@ -13285,7 +13285,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             switch (16 * u + opcode) {
             case 0x05: /* FMLS */
                 /* As usual for ARM, separate negation for fused multiply-add */
-                gen_helper_vfp_negd(tcg_op, tcg_op);
+                gen_vfp_negd(tcg_op, tcg_op);
                 /* fall through */
             case 0x01: /* FMLA */
                 read_vec_element(s, tcg_res, rd, pass, MO_64);
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index b9af03b7c3..ee53257687 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -1763,7 +1763,7 @@ static void gen_VMLS_hp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     gen_helper_vfp_mulh(tmp, vn, vm, fpst);
-    gen_helper_vfp_negh(tmp, tmp);
+    gen_vfp_negh(tmp, tmp);
     gen_helper_vfp_addh(vd, vd, tmp, fpst);
 }
 
@@ -1781,7 +1781,7 @@ static void gen_VMLS_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     gen_helper_vfp_muls(tmp, vn, vm, fpst);
-    gen_helper_vfp_negs(tmp, tmp);
+    gen_vfp_negs(tmp, tmp);
     gen_helper_vfp_adds(vd, vd, tmp, fpst);
 }
 
@@ -1799,7 +1799,7 @@ static void gen_VMLS_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     TCGv_i64 tmp = tcg_temp_new_i64();
 
     gen_helper_vfp_muld(tmp, vn, vm, fpst);
-    gen_helper_vfp_negd(tmp, tmp);
+    gen_vfp_negd(tmp, tmp);
     gen_helper_vfp_addd(vd, vd, tmp, fpst);
 }
 
@@ -1819,7 +1819,7 @@ static void gen_VNMLS_hp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     gen_helper_vfp_mulh(tmp, vn, vm, fpst);
-    gen_helper_vfp_negh(vd, vd);
+    gen_vfp_negh(vd, vd);
     gen_helper_vfp_addh(vd, vd, tmp, fpst);
 }
 
@@ -1839,7 +1839,7 @@ static void gen_VNMLS_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     gen_helper_vfp_muls(tmp, vn, vm, fpst);
-    gen_helper_vfp_negs(vd, vd);
+    gen_vfp_negs(vd, vd);
     gen_helper_vfp_adds(vd, vd, tmp, fpst);
 }
 
@@ -1859,7 +1859,7 @@ static void gen_VNMLS_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     TCGv_i64 tmp = tcg_temp_new_i64();
 
     gen_helper_vfp_muld(tmp, vn, vm, fpst);
-    gen_helper_vfp_negd(vd, vd);
+    gen_vfp_negd(vd, vd);
     gen_helper_vfp_addd(vd, vd, tmp, fpst);
 }
 
@@ -1874,8 +1874,8 @@ static void gen_VNMLA_hp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     gen_helper_vfp_mulh(tmp, vn, vm, fpst);
-    gen_helper_vfp_negh(tmp, tmp);
-    gen_helper_vfp_negh(vd, vd);
+    gen_vfp_negh(tmp, tmp);
+    gen_vfp_negh(vd, vd);
     gen_helper_vfp_addh(vd, vd, tmp, fpst);
 }
 
@@ -1890,8 +1890,8 @@ static void gen_VNMLA_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     gen_helper_vfp_muls(tmp, vn, vm, fpst);
-    gen_helper_vfp_negs(tmp, tmp);
-    gen_helper_vfp_negs(vd, vd);
+    gen_vfp_negs(tmp, tmp);
+    gen_vfp_negs(vd, vd);
     gen_helper_vfp_adds(vd, vd, tmp, fpst);
 }
 
@@ -1906,8 +1906,8 @@ static void gen_VNMLA_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     TCGv_i64 tmp = tcg_temp_new_i64();
 
     gen_helper_vfp_muld(tmp, vn, vm, fpst);
-    gen_helper_vfp_negd(tmp, tmp);
-    gen_helper_vfp_negd(vd, vd);
+    gen_vfp_negd(tmp, tmp);
+    gen_vfp_negd(vd, vd);
     gen_helper_vfp_addd(vd, vd, tmp, fpst);
 }
 
@@ -1935,7 +1935,7 @@ static void gen_VNMUL_hp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
 {
     /* VNMUL: -(fn * fm) */
     gen_helper_vfp_mulh(vd, vn, vm, fpst);
-    gen_helper_vfp_negh(vd, vd);
+    gen_vfp_negh(vd, vd);
 }
 
 static bool trans_VNMUL_hp(DisasContext *s, arg_VNMUL_sp *a)
@@ -1947,7 +1947,7 @@ static void gen_VNMUL_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
 {
     /* VNMUL: -(fn * fm) */
     gen_helper_vfp_muls(vd, vn, vm, fpst);
-    gen_helper_vfp_negs(vd, vd);
+    gen_vfp_negs(vd, vd);
 }
 
 static bool trans_VNMUL_sp(DisasContext *s, arg_VNMUL_sp *a)
@@ -1959,7 +1959,7 @@ static void gen_VNMUL_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
 {
     /* VNMUL: -(fn * fm) */
     gen_helper_vfp_muld(vd, vn, vm, fpst);
-    gen_helper_vfp_negd(vd, vd);
+    gen_vfp_negd(vd, vd);
 }
 
 static bool trans_VNMUL_dp(DisasContext *s, arg_VNMUL_dp *a)
@@ -2110,12 +2110,12 @@ static bool do_vfm_hp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
     vfp_load_reg32(vm, a->vm);
     if (neg_n) {
         /* VFNMS, VFMS */
-        gen_helper_vfp_negh(vn, vn);
+        gen_vfp_negh(vn, vn);
     }
     vfp_load_reg32(vd, a->vd);
     if (neg_d) {
         /* VFNMA, VFNMS */
-        gen_helper_vfp_negh(vd, vd);
+        gen_vfp_negh(vd, vd);
     }
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     gen_helper_vfp_muladdh(vd, vn, vm, vd, fpst);
@@ -2169,12 +2169,12 @@ static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
     vfp_load_reg32(vm, a->vm);
     if (neg_n) {
         /* VFNMS, VFMS */
-        gen_helper_vfp_negs(vn, vn);
+        gen_vfp_negs(vn, vn);
     }
     vfp_load_reg32(vd, a->vd);
     if (neg_d) {
         /* VFNMA, VFNMS */
-        gen_helper_vfp_negs(vd, vd);
+        gen_vfp_negs(vd, vd);
     }
     fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_vfp_muladds(vd, vn, vm, vd, fpst);
@@ -2234,12 +2234,12 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
     vfp_load_reg64(vm, a->vm);
     if (neg_n) {
         /* VFNMS, VFMS */
-        gen_helper_vfp_negd(vn, vn);
+        gen_vfp_negd(vn, vn);
     }
     vfp_load_reg64(vd, a->vd);
     if (neg_d) {
         /* VFNMA, VFNMS */
-        gen_helper_vfp_negd(vd, vd);
+        gen_vfp_negd(vd, vd);
     }
     fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_vfp_muladdd(vd, vn, vm, vd, fpst);
@@ -2409,13 +2409,13 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 DO_VFP_VMOV(VMOV_reg, sp, tcg_gen_mov_i32)
 DO_VFP_VMOV(VMOV_reg, dp, tcg_gen_mov_i64)
 
-DO_VFP_2OP(VABS, hp, gen_helper_vfp_absh, aa32_fp16_arith)
-DO_VFP_2OP(VABS, sp, gen_helper_vfp_abss, aa32_fpsp_v2)
-DO_VFP_2OP(VABS, dp, gen_helper_vfp_absd, aa32_fpdp_v2)
+DO_VFP_2OP(VABS, hp, gen_vfp_absh, aa32_fp16_arith)
+DO_VFP_2OP(VABS, sp, gen_vfp_abss, aa32_fpsp_v2)
+DO_VFP_2OP(VABS, dp, gen_vfp_absd, aa32_fpdp_v2)
 
-DO_VFP_2OP(VNEG, hp, gen_helper_vfp_negh, aa32_fp16_arith)
-DO_VFP_2OP(VNEG, sp, gen_helper_vfp_negs, aa32_fpsp_v2)
-DO_VFP_2OP(VNEG, dp, gen_helper_vfp_negd, aa32_fpdp_v2)
+DO_VFP_2OP(VNEG, hp, gen_vfp_negh, aa32_fp16_arith)
+DO_VFP_2OP(VNEG, sp, gen_vfp_negs, aa32_fpsp_v2)
+DO_VFP_2OP(VNEG, dp, gen_vfp_negd, aa32_fpdp_v2)
 
 static void gen_VSQRT_hp(TCGv_i32 vd, TCGv_i32 vm)
 {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 3e5e37abbe..ce26b8a71a 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -281,36 +281,6 @@ VFP_BINOP(minnum)
 VFP_BINOP(maxnum)
 #undef VFP_BINOP
 
-dh_ctype_f16 VFP_HELPER(neg, h)(dh_ctype_f16 a)
-{
-    return float16_chs(a);
-}
-
-float32 VFP_HELPER(neg, s)(float32 a)
-{
-    return float32_chs(a);
-}
-
-float64 VFP_HELPER(neg, d)(float64 a)
-{
-    return float64_chs(a);
-}
-
-dh_ctype_f16 VFP_HELPER(abs, h)(dh_ctype_f16 a)
-{
-    return float16_abs(a);
-}
-
-float32 VFP_HELPER(abs, s)(float32 a)
-{
-    return float32_abs(a);
-}
-
-float64 VFP_HELPER(abs, d)(float64 a)
-{
-    return float64_abs(a);
-}
-
 dh_ctype_f16 VFP_HELPER(sqrt, h)(dh_ctype_f16 a, CPUARMState *env)
 {
     return float16_sqrt(a, &env->vfp.fp_status_f16);
-- 
2.34.1


