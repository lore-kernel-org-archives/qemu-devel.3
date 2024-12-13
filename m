Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B28E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xn-0007rh-FP; Fri, 13 Dec 2024 12:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XC-00074E-Ur
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:03 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XA-0001XK-0n
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso13698665e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111178; x=1734715978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SebYeO56jOAlUYYHC79zwogvEFSt4JEj+habP31pt+w=;
 b=aNM7Y6dkxpBDqnSWm64rLHC/87mBlWWhr8TB/+UenaRSnYo0aAyG5vVZU2H+s+oLi8
 XXmrP1yGOEKZGae9k3ESBDpI4KMgrku170wMb0y808YWY8FFBEDeykQ2i40NW7u0vyhn
 MUpIc6sPJLpymPOIvFEE9vtAKcMf59HoXhtzh8X4gmP96iVRQYS2/Owqn+QzClVOyswz
 fq1n7wHWqumw5fu8WJ5oNtTnQpZ+LpcKKgJZfR6SzADOdmyXShsZGHrsANDvBmTFwdnM
 G6MGzrEScQLH1HqMZ0FWhlICbbKT7ulqfouf+e7xBi8PtRjQXvjbDpvFO7/XriHZxtAm
 HPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111178; x=1734715978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SebYeO56jOAlUYYHC79zwogvEFSt4JEj+habP31pt+w=;
 b=Jge8qE2x8UP66JjZ21eKz91+iWcN+sJ5yhVqZeGBVvfpBOn972nZBF/QaF9MfGqyXf
 421NlWLl2EgvmmONXfWikbagTw9TGNLtOAVlx/yVh6z5c6yVwwB1J1rdqQDeF0nJ7wIA
 tFBUO6tgWSCvmy7eilpXQGMdCUQ5f9FYkB50VbXHZAnQ7omHeIiG51sooGUgIEv5sqtJ
 LCmEtTycpSI7A4nL2TcD1PGD8ayz6nmbezXOYr8LkZIUkcaX2IbUja5cS8GFSIH7tPBF
 xms5meRCxpRJkVJg2b5FHbw6yHekzZ044V11wsNZ/1yEot+m4gK4AFk7bD1UyqpN1lCl
 Y5Fw==
X-Gm-Message-State: AOJu0Yy+t4UAr6NCFHdjqkfknpfBq9gsrta03j+BbNrsqDndNR6tFmP2
 +UrPGXhRXR9oFogWpqF3D9xO4aSO903kzNXo0Wv19ngW+tFARTMdlTjBqzjPAipr+lTnDbOzSHf
 k
X-Gm-Gg: ASbGncuVm5sCy1Uukt2sPFfivVO/uuZj4ys9giK12DtL5/YKYQPQvBi+jjrD1t4dwr4
 fLh1bxQ6knHiFongJQCsu4mE/SajGnk+RyqkfYWhb5ZYZRFfaCDPFR5I0D9Eas2ie1WNNfTXGYG
 Jy9wmVgxb5X2bnmv89m3ohvSrtp7J7plBH7U8ROcHfi37Rbmd28N//wEnzPbl7Wy0FAlpSMhBUR
 jxtJ4z/UwLBuhMu1tZMcq/SdFwLkFa8v35kgzktuTEcN5FdpB2z5Dp8lWINpQ==
X-Google-Smtp-Source: AGHT+IHB5Ump2OtFXQM/NUH/GdpuNYo0lSKsFAah2r/EnJX1WzC6WdbGi1o/KfbM0qrVUwwJ1CxwuA==
X-Received: by 2002:a05:600c:4e10:b0:431:54d9:da57 with SMTP id
 5b1f17b1804b1-4362aaa92ffmr32847205e9.30.1734111177963; 
 Fri, 13 Dec 2024 09:32:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/85] target/arm: Pass fpstatus to vfp_sqrt*
Date: Fri, 13 Dec 2024 17:31:29 +0000
Message-Id: <20241213173229.3308926-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Pass fpstatus not env, like most other fp helpers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-26-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |  6 +++---
 target/arm/tcg/translate-a64.c | 15 +++++++--------
 target/arm/tcg/translate-vfp.c |  6 +++---
 target/arm/vfp_helper.c        | 12 ++++++------
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 58919b670ef..0a697e752bc 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -133,9 +133,9 @@ DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, ptr)
 DEF_HELPER_3(vfp_minnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_minnums, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
-DEF_HELPER_2(vfp_sqrth, f16, f16, env)
-DEF_HELPER_2(vfp_sqrts, f32, f32, env)
-DEF_HELPER_2(vfp_sqrtd, f64, f64, env)
+DEF_HELPER_2(vfp_sqrth, f16, f16, ptr)
+DEF_HELPER_2(vfp_sqrts, f32, f32, ptr)
+DEF_HELPER_2(vfp_sqrtd, f64, f64, ptr)
 DEF_HELPER_3(vfp_cmph, void, f16, f16, env)
 DEF_HELPER_3(vfp_cmps, void, f32, f32, env)
 DEF_HELPER_3(vfp_cmpd, void, f64, f64, env)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ca2b95510e2..cfc73b8506d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8401,8 +8401,8 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
 
     switch (opcode) {
     case 0x3: /* FSQRT */
-        gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
-        goto done;
+        gen_fpst = gen_helper_vfp_sqrts;
+        break;
     case 0x6: /* BFCVT */
         gen_fpst = gen_helper_bfcvt;
         break;
@@ -8450,7 +8450,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst(tcg_res, tcg_op, fpst);
     }
 
- done:
     write_fp_sreg(s, rd, tcg_res);
 }
 
@@ -8467,8 +8466,8 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
 
     switch (opcode) {
     case 0x3: /* FSQRT */
-        gen_helper_vfp_sqrtd(tcg_res, tcg_op, tcg_env);
-        goto done;
+        gen_fpst = gen_helper_vfp_sqrtd;
+        break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
@@ -8513,7 +8512,6 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst(tcg_res, tcg_op, fpst);
     }
 
- done:
     write_fp_dreg(s, rd, tcg_res);
 }
 
@@ -9459,7 +9457,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         gen_vfp_negd(tcg_rd, tcg_rn);
         break;
     case 0x7f: /* FSQRT */
-        gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_env);
+        gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_fpstatus);
         break;
     case 0x1a: /* FCVTNS */
     case 0x1b: /* FCVTMS */
@@ -10402,6 +10400,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             handle_2misc_fcmp_zero(s, opcode, false, u, is_q, size, rn, rd);
             return;
         case 0x7f: /* FSQRT */
+            need_fpstatus = true;
             if (size == 3 && !is_q) {
                 unallocated_encoding(s);
                 return;
@@ -10631,7 +10630,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     gen_vfp_negs(tcg_res, tcg_op);
                     break;
                 case 0x7f: /* FSQRT */
-                    gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
+                    gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 case 0x1a: /* FCVTNS */
                 case 0x1b: /* FCVTMS */
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index b6fa28a7bf6..c160a86e703 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -2424,17 +2424,17 @@ DO_VFP_2OP(VNEG, dp, gen_vfp_negd, aa32_fpdp_v2)
 
 static void gen_VSQRT_hp(TCGv_i32 vd, TCGv_i32 vm)
 {
-    gen_helper_vfp_sqrth(vd, vm, tcg_env);
+    gen_helper_vfp_sqrth(vd, vm, fpstatus_ptr(FPST_FPCR_F16));
 }
 
 static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
 {
-    gen_helper_vfp_sqrts(vd, vm, tcg_env);
+    gen_helper_vfp_sqrts(vd, vm, fpstatus_ptr(FPST_FPCR));
 }
 
 static void gen_VSQRT_dp(TCGv_i64 vd, TCGv_i64 vm)
 {
-    gen_helper_vfp_sqrtd(vd, vm, tcg_env);
+    gen_helper_vfp_sqrtd(vd, vm, fpstatus_ptr(FPST_FPCR));
 }
 
 DO_VFP_2OP(VSQRT, hp, gen_VSQRT_hp, aa32_fp16_arith)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 62638d2b1f9..f24992c798a 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -314,19 +314,19 @@ VFP_BINOP(minnum)
 VFP_BINOP(maxnum)
 #undef VFP_BINOP
 
-dh_ctype_f16 VFP_HELPER(sqrt, h)(dh_ctype_f16 a, CPUARMState *env)
+dh_ctype_f16 VFP_HELPER(sqrt, h)(dh_ctype_f16 a, void *fpstp)
 {
-    return float16_sqrt(a, &env->vfp.fp_status_f16);
+    return float16_sqrt(a, fpstp);
 }
 
-float32 VFP_HELPER(sqrt, s)(float32 a, CPUARMState *env)
+float32 VFP_HELPER(sqrt, s)(float32 a, void *fpstp)
 {
-    return float32_sqrt(a, &env->vfp.fp_status);
+    return float32_sqrt(a, fpstp);
 }
 
-float64 VFP_HELPER(sqrt, d)(float64 a, CPUARMState *env)
+float64 VFP_HELPER(sqrt, d)(float64 a, void *fpstp)
 {
-    return float64_sqrt(a, &env->vfp.fp_status);
+    return float64_sqrt(a, fpstp);
 }
 
 static void softfloat_to_vfp_compare(CPUARMState *env, FloatRelation cmp)
-- 
2.34.1


